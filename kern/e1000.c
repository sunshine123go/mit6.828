#include <kern/e1000.h>
#include <kern/pci.h>
#include <kern/pmap.h>
#include <inc/string.h>
#include <inc/stdio.h>

// LAB 6: Your driver code here

volatile uint32_t *e1000_basemem;

// define the tx descriptor and the tx bufs
struct tx_desc *tx_desc;
struct pack_buf *tx_bufs;

// define the rx descriptor and the rx bufs, try a different manner
struct rx_desc *rx_desc;
char rx_bufs[NRXDES][PGSIZE / 2];

/* uintptr_t *packbuf[NTXDES]; */

static void trans_init();
static void recv_init();

int
pci_E1000_attach(struct pci_func *f)
{
    pci_func_enable(f);
    e1000_basemem = mmio_map_region(f->reg_base[0], f->reg_size[0]);
    /* cprintf("status address: 0x%x\n", e1000_base_mem[2]); */
    trans_init();
    recv_init();

    /* for (int i = 0; i < NTXDES; i++) */
        /* try_trans_pack("hello", 5); */

    return 1;
}

static inline void
write2reg(uint32_t reg_off, uint32_t value)
{
    uint32_t *reg = (uint32_t *)((uint32_t)e1000_basemem + reg_off);
    *reg = value;
}

static inline uint32_t
read_reg(uint32_t reg_off)
{
    return *((uint32_t *)((uint32_t)e1000_basemem + reg_off));
}

static inline void
tctl_init()
{
    uint32_t mask = 0;
    mask |= E1000_TCTL_EN;
    mask |= E1000_TCTL_PSP;
    mask |= E1000_TCTL_CT & (0x10 << 4);
    mask |= E1000_TCTL_COLD & (0x40 << 12);
    write2reg(E1000_TCTL, mask);
}

static inline void
tipg_init()
{
    uint32_t mask = 0;
    mask |= 10;
    mask |= (8 << 10);
    mask |= (12 << 10);
    write2reg(E1000_TIPG, mask);
}

static void
txdesc_init()
{
    int i;
    for (i = 0; i < NTXDES; ++i) {
        tx_desc[i].addr = PADDR(tx_bufs[i].buf);
        tx_desc[i].cmd = E1000_TXD_CMD_RS;
        tx_desc[i].status = E1000_TXD_STAT_DD;
    }
}

static void
trans_init()
{
    write2reg(E1000_TDBAL, PADDR(tx_desc));
    write2reg(E1000_TDBAH, 0);

    write2reg(E1000_TDLEN, NTXDES * DES_SIZE);
    write2reg(E1000_TDH, 0);
    write2reg(E1000_TDT, 0);

    tctl_init();

    tipg_init();

    txdesc_init();
}


// return the lenth transmited if success
// if the queue if full, then return -E_TRANS_QUEUE_FULL
int
try_trans_pack(const char *buf, uint32_t len)
{
    uint32_t TDT, TDT_NEXT;
    uint32_t trans_len;

    TDT = read_reg(E1000_TDT);
    TDT_NEXT = (TDT + 1) % NTXDES;

    if (tx_desc[TDT].status & E1000_TXD_STAT_DD) {
        trans_len = len > MAXPACKSIZE ? MAXPACKSIZE : len;
        memcpy(tx_bufs[TDT].buf, buf, trans_len);

        /* tx_desc[TDT].addr = PADDR(tx_bufs[TDT].buf); */
        tx_desc[TDT].length = trans_len;

        // for easy, we just use one descriptor to trans one packet
        tx_desc[TDT].cmd |= E1000_TXD_CMD_RS|E1000_TXD_CMD_EOP;
        // if we use a minimal descriptor buffer, then we can use more descriptor to trans a packet
        // just mark  the last descriptor's CMD_EOP bit
        /* if (len == 0) { */
            /* tx_desc[TDT].cmd |= E1000_TXD_CMD_EOP; */
        /* } */
        tx_desc[TDT].status &= ~E1000_TXD_STAT_DD;

        write2reg(E1000_TDT, TDT_NEXT);

        return trans_len;
    } else {
        /* cprintf("full desc\n"); */
        return -E_TRANS_QUEUE_FULL;
    }
}

static void
rxdesc_init()
{
    struct PageInfo *pp;
    int i, r;

    if ((pp = page_alloc(1)) == NULL) {
        panic("page_alloc error in rx_desc_init");
    }
    ++pp->pp_ref;
    // we are now in the kernel, so needn't worry the privilege
    rx_desc = (struct rx_desc *)page2kva(pp);

    for (i = 0; i < NRXDES; ++i) {
    	rx_desc[i].addr = PADDR(rx_bufs[i]);
    }

    write2reg(E1000_RDBAL, page2pa(pp));
    write2reg(E1000_RDBAH, 0);
    write2reg(E1000_RDLEN, DES_SIZE * NRXDES);
}

static inline void
rctl_init()
{
    uint32_t mask = 0;
    mask |= E1000_RCTL_EN;
    mask |= E1000_RCTL_LBM_NO;
    mask |= E1000_RCTL_BAM;
    mask |= E1000_RCTL_SZ_2048;
    mask |= E1000_RCTL_SECRC;
    write2reg(E1000_RCTL, mask);
}

static void
recv_init()
{
    // init the RAR with the disered Ethernet address
    write2reg(E1000_RAL0, (0x12 << 24)|(0x00 << 16)|(0x54 << 8)|(0x52));
    write2reg(E1000_RAH0, (0x56 << 8)|(0x34)|(1 << 31));

    // init the MTA arrays
    memset((void *)((uint32_t)e1000_basemem + E1000_MTABASE), 0, E1000_MTALEN);

    rxdesc_init();
    write2reg(E1000_RDT, NRXDES - 1);
    rctl_init();
}

// return the length of the receive data if success
// return -E_RECV_QUEUE_EMPTY if the queue is empty
int
recv_pack(char *buf, uint32_t len)
{
    uint32_t RDT, RDT_NEXT;
    uint32_t recv_len;

    RDT = read_reg(E1000_RDT);
    RDT_NEXT = (RDT + 1) % NRXDES;

    // for easy, we use a large buffer so that we needn't worry a packet will use more than
    // one buffer, so we just don't think the EOP, every packet will set it at the moment
    if (rx_desc[RDT_NEXT].status.DD) {
        recv_len = rx_desc[RDT_NEXT].length > len ? len : rx_desc[RDT_NEXT].length;
        memcpy(buf, rx_bufs[RDT_NEXT], recv_len);

        rx_desc[RDT_NEXT].status.DD = 0;
        write2reg(E1000_RDT, RDT_NEXT);

        return recv_len;
    } else {
        return -E_RECV_QUEUE_EMPTY;
    }
}

#include "ns.h"

extern union Nsipc nsipcbuf;

#define CACHENUM 10
#define CACHEBASE 0x20000000
void
input(envid_t ns_envid)
{
	binaryname = "ns_input";

	// LAB 6: Your code here:
	// 	- read a packet from the device driver
	//	- send it to the network server
	// Hint: When you IPC a page to the network server, it will be
	// reading from it for a while, so don't immediately receive
	// another packet in to the same physical page.
    int perm, i, r;
    struct jif_pkt *vas[CACHENUM];
    envid_t envid = sys_getenvid();

    for (i = 0; i < CACHENUM; i++) {
        vas[i] = (struct jif_pkt *)(CACHEBASE + i * PGSIZE);
    }
    for (i = 0; i < CACHENUM; i++) {
        if ((r = sys_page_alloc(envid, vas[i], PTE_P|PTE_U|PTE_W)) < 0) {
            panic("sys_page_alloc error in input: %e", r);
        }
    }
    i = 0;
    while (1) {
        // for easy, we just retry it, we can also suspend this env then using Interrupt to wakeup it
        while ((r = sys_recv_pack(vas[i]->jp_data, PGSIZE - sizeof (int))) < 0) {
            sys_yield();
        }
        vas[i]->jp_len = r;

        ipc_send(ns_envid, NSREQ_INPUT, vas[i], PTE_P|PTE_U|PTE_W);
        i = (i + 1) % CACHENUM;
    }
}

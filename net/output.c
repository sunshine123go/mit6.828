#include "ns.h"

extern union Nsipc nsipcbuf;

void
output(envid_t ns_envid)
{
	binaryname = "ns_output";

	// LAB 6: Your code here:
	// 	- read a packet from the network server
	//	- send the packet to the device driver
    envid_t whom;
    int perm, r;
    while (1) {
        if ((r = ipc_recv(&whom, &nsipcbuf, &perm)) < 0) {
            panic("output: ipc_recv error, %e", r);
        }
        assert(r == NSREQ_OUTPUT);
        assert(whom == ns_envid);

        while (sys_try_trans_pack(nsipcbuf.pkt.jp_data, nsipcbuf.pkt.jp_len) < 0) {
            sys_yield();
        }
    }
}

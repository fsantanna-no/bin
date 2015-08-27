mkisofs -o /g.iso .
cdrecord dev=ATA:0,1,0 /g.iso


 add_fsm_encoding \
       {BUS16CONTROL.RegState} \
       { }  \
       {{0000 0000} {0001 0101} {0010 0111} {0011 1000} {0111 0110} {1000 0001} {1001 0010} {1010 0011} {1011 0100} }

 add_fsm_encoding \
       {AXI32CONTROL.RegState} \
       { }  \
       {{0000 000000001} {0001 000100000} {0010 001000000} {0111 010000000} {1000 000000010} {1001 000000100} {1010 000001000} {1100 000010000} {1110 100000000} }

 add_fsm_encoding \
       {rd_chnl.rlast_sm_cs} \
       { }  \
       {{000 000} {001 010} {010 011} {011 100} {100 001} }
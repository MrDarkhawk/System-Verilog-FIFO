`include "fifo_interface.sv"
package fifo_pkg;
 
 //int no_of_trans = 10;
 
  `include "fifo_defines.sv"
  `include "fifo_trans.sv"
  `include "fifo_gen.sv"
  `include "fifo_drv.sv"
  `include "fifo_mon.sv"
  `include "fifo_rf.sv"
  `include "fifo_sb.sv"
  `include "fifo_env.sv"
 
  `include "fifo_base_test.sv"
  
endpackage
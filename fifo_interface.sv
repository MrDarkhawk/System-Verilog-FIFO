interface fifo_if(input bit clk);

  logic rst;
  logic full,empty,error;
  
  //write_signals
  logic write_en;
  logic [7:0] data_in;

//read_signals
  logic read_en;
  logic [7:0] data_out;
   
  clocking drv_cb @(posedge clk);
   default input #1 output #1;
   output rst;
   output write_en,read_en,data_in;
  input empty,full,error;
  endclocking
  
  clocking mon_cb @(posedge clk);
   default input #1 output #1;
   input rst;
   input write_en,read_en,data_in,data_out;
   input empty,full,error;
  endclocking
   
   modport DRV_MP (clocking drv_cb);
   modport MON_MP (clocking mon_cb);
   
 endinterface
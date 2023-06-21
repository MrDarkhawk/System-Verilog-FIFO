
`ifndef FIFO_TRANS_SV
`define FIFO_TRANS_SV

//typedef enum bit [1:0] {IDLE,READ,WRITE,SIM_RW} trans_kind;

class fifo_trans;

   //reset
   bit rst;
  rand bit write_en;
  rand bit read_en;
  randc bit [7:0] data_in;
        bit [7:0] data_out;
  bit empty,full,error;
  
    logic  [`DATA_WIDTH-1:0] exp_data;
	
	
 // logic  [`DATA_WIDTH-1:0] exp_data;
  
  //default constraint
  constraint ENB { write_en==1'b1; read_en==1'b1;}
  
  //add static variables to record no. of write and read transaction
  
  //add custom print/display method to print transaction attributes


endclass

`endif
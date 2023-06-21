import fifo_pkg::*;
module fifo_tb_top();

  bit clk;

  fifo_base_test test_h;
  
  fifo_if inf(clk);
  
  //dut instattiation
   fifo DUT (.clk(clk),
            .rst(inf.rst),
			.write_en(inf.write_en),
			.read_en(inf.read_en),
			.data_in(inf.data_in),
			.data_out(inf.data_out),
			.full(inf.full),
			.empty(inf.empty),
			.error(inf.error));
			
			
  always
   #5 clk = ~clk;
   
   
 
   
  initial begin
  
   test_h = new(inf,inf);
   test_h.build_and_start();
        
   
   #500 $finish;
  end
  
     
endmodule
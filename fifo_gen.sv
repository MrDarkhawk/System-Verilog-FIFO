////////////////////////////////////////////////
//
//           HEADER
//
/////////////////////////////////////////////////

`ifndef FIFO_GEN_SV
`define FIFO_GEN_SV

//description
class fifo_gen;

  fifo_trans trans_h;
  
  //mailbox
  mailbox #(fifo_trans) gen_drv;
  
  //description
  function new (mailbox #(fifo_trans) gen_drv);
	this.gen_drv = gen_drv;
  endfunction
  
  //description
 virtual task start();
    repeat(50) begin
	  trans_h = new();
	  if (!trans_h.randomize())
	   $error("FIFO_GEN","RANDOMIZATION FAILED");
	  gen_drv.put(trans_h);
	end
 endtask
	   
endclass

`endif
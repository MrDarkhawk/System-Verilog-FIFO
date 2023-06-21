
class fifo_drv;

 fifo_trans trans_h;
 
 //mailbox
  mailbox #(fifo_trans) gen_drv;

 //interface
 virtual fifo_if.DRV_MP vif;


 function new (mailbox #(fifo_trans) gen_drv, 
               virtual fifo_if.DRV_MP vif);
	this.gen_drv = gen_drv;
	this.vif = vif;
 endfunction
 
 task start();
 reset();
   forever begin
     gen_drv.get(trans_h);
	 //$display("trans_wd=%0d",trans_h);
	 send_to_dut();
	// #2;
    end
 endtask
 
 task reset();
 vif.drv_cb.rst<=1;
 #10;
 vif.drv_cb.rst<=0;
 endtask
 
 task send_to_dut();
       @(vif.drv_cb)
   //drive data to design
   vif.drv_cb.write_en <= trans_h.write_en;
   vif.drv_cb.read_en<=trans_h.read_en;
   vif.drv_cb.data_in<=trans_h.data_in;
   vif.drv_cb.rst<=trans_h.rst;
   trans_h.full=vif.drv_cb.full;
   trans_h.empty=vif.drv_cb.empty;
   trans_h.error=vif.drv_cb.error;
   //$display("wd to dut: write_en=%d,read_en=%d,data_in=%d",trans_h.write_en,trans_h.read_en,trans_h.data_in);
   
   
 endtask
 
endclass
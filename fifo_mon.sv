
class fifo_mon;

  fifo_trans trans_h;
  
  mailbox #(fifo_trans) mon_rf;
  mailbox #(fifo_trans) mon_sb;
  
  virtual fifo_if.MON_MP vif;
  
  
   function new (mailbox #(fifo_trans) mon_rf, 
                 mailbox #(fifo_trans) mon_sb,
               virtual fifo_if.MON_MP vif);
	this.mon_rf = mon_rf;
	this.mon_sb = mon_sb;
	this.vif = vif;
 endfunction
 
 task start();
    forever begin
   trans_h=new();
   monitor();
   mon_sb.put(trans_h);
   mon_rf.put(trans_h);
  end
 endtask
 
 
 task monitor();
   //sample data from design
   //create trans_h
        @(vif.mon_cb)
   trans_h.write_en = vif.mon_cb.write_en;
   trans_h.read_en = vif.mon_cb.read_en;
   trans_h.data_in = vif.mon_cb.data_in;
   trans_h.data_out = vif.mon_cb.data_out;
   trans_h.empty = vif.mon_cb.empty;
   trans_h.full = vif.mon_cb.full;
   trans_h.error = vif.mon_cb.error;
   //$display("dut to wm : write_en=%d,read_en=%d,data_in=%d,data_out=%d",trans_h.write_en,trans_h.read_en,trans_h.data_in,trans_h.data_out);
 endtask
 
endclass
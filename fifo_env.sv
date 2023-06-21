
 class fifo_env;
 
   //all verification component instance
   fifo_gen gen_h;
   fifo_drv  drv_h;
   fifo_mon  mon_h;
   fifo_rf  rf_h;
   fifo_sb  sb_h;
   
   //mailbox
   mailbox #(fifo_trans) gen_drv=new();
   mailbox #(fifo_trans) mon_rf=new();
   mailbox #(fifo_trans) mon_sb=new();
   mailbox #(fifo_trans) rf_sb=new();
   
  //interface
  virtual fifo_if.DRV_MP  drv_if;
  virtual fifo_if.MON_MP  mon_if;
   
  function new (virtual fifo_if.DRV_MP  drv_if,
                virtual fifo_if.MON_MP  mon_if);
	this.drv_if = drv_if;
	this.mon_if = mon_if;
  endfunction
  
  function void build();
    gen_h = new(gen_drv);
	drv_h  = new(gen_drv,drv_if);
	mon_h  = new(mon_rf,mon_sb,mon_if);
	rf_h  = new(mon_rf,rf_sb);
	sb_h  = new(mon_sb,rf_sb);
  endfunction
  
  task start();
   fork 
	 gen_h.start(); 
	 drv_h.start();  
	 mon_h.start();
	 rf_h.start();
	 sb_h.start();
   join_none
  endtask

endclass 
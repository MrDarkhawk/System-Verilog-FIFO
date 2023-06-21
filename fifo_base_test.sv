//import fifo_env_pkg::*;
 class fifo_base_test;
 
  fifo_env env_h;
  
    //interface
  virtual fifo_if.DRV_MP  drv_if;
  virtual fifo_if.MON_MP  mon_if;
     
   
  function new (virtual fifo_if.DRV_MP  drv_if,
                virtual fifo_if.MON_MP  mon_if);
	this.drv_if = drv_if;
	this.mon_if = mon_if;
  endfunction
  
  
  task build_and_start();
    env_h = new(drv_if,mon_if);
	env_h.build();
	env_h.start();
  endtask
  
endclass
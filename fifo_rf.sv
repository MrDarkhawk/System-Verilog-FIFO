
class fifo_rf;

  fifo_trans trans_h1;

  logic [7:0]ref_fifo[$:15];
  //logic [7:0] temp;  
  
  //mailbox
   mailbox #(fifo_trans) mon_rf;
   mailbox #(fifo_trans) rf_sb;
   
   function new (mailbox #(fifo_trans) mon_rf,
                 mailbox #(fifo_trans) rf_sb);
	this.mon_rf = mon_rf;
	this.rf_sb = rf_sb;
  endfunction
  
  
  task start();
   forever begin
    mon_rf.get(trans_h1);
	predict_exp_rd_data();
	
	/* fork
	 temp = #10 trans_h2.exp_data;
	 trans_h2.exp_data = temp;
	join */
	rf_sb.put(trans_h1);
   end
  endtask
    
  //description
 task predict_exp_rd_data();
 
    if(trans_h1.write_en)begin
	ref_fifo.push_front(trans_h1.data_out);	
	end
	if(trans_h1.read_en)begin
	trans_h1.exp_data=ref_fifo.pop_back();
	end
 endtask
  
 endclass
	
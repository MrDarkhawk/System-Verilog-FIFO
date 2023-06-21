/////////////////////////////////////////////////

`ifndef FIFO_SB_SV
`define FIFO_SB_SV

//description
class fifo_sb;

 fifo_trans act_trans, exp_trans;
 
 mailbox #(fifo_trans) mon_sb;
 mailbox #(fifo_trans) rf_sb;
        
 //description
 function new(mailbox #(fifo_trans) mon_sb,
              mailbox #(fifo_trans) rf_sb);
   this.mon_sb = mon_sb;
   this.rf_sb  = rf_sb;

 endfunction
 

 
 //description
 task start();
   forever begin
	 mon_sb.get(act_trans);
	 rf_sb.get(exp_trans);
	 check_data();
   end
 endtask	
 
 //description
  task check_data();
  
  if (act_trans.data_out !== 0 )begin
      if (act_trans.data_out == exp_trans.exp_data)
	      $display(" SUCCESS ! data_out = %d : %d = exp_data",act_trans.data_out,exp_trans.exp_data);
	  else
	      $display(" DATA MISMATCH ! data_out = %d : %d = exp_data",act_trans.data_out,exp_trans.exp_data);
    end
	
 endtask 
 
endclass :fifo_sb

`endif
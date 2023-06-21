module fifo(clk,rst,write_en,read_en,data_in,data_out,full,empty,error);
parameter DEPTH = 16;
parameter PTR_WIDTH = 4;
parameter WIDTH = 8;

input clk,rst,write_en,read_en;
input [WIDTH-1:0]data_in;					//input data to FIFO
output reg [WIDTH-1:0]data_out;			//output data from FIFO
output reg full,empty,error;

//internal parameters
reg [PTR_WIDTH-1:0]wr_ptr,rd_ptr;				//read & write pointer to point a memory location
reg [WIDTH-1:0]fifo_mem[0:DEPTH-1];			//FIFO internal memory declaration
reg wr_flag, rd_flag;

integer i;

always@(posedge clk)
begin
	//reset logic
	if(rst)
	begin
		data_out = 0;
		full = 0;
		empty = 0;
		rd_ptr = 0;
		wr_ptr = 0;
		error = 0;
		wr_flag = 0;
		rd_flag = 0;
		
		//full memory reset to 0
		for(i=0; i<DEPTH; i=i+1)
		begin
			fifo_mem[i] = 0;
		end
	end
	
	else
	begin
	
		//write logic in FIFO memory
		if(write_en)
		begin
			if(full == 1)
			begin
				if(error == 0)
				begin
					$display("---------------------------------------------------------------");
					$display($time," -- ERROR : FIFO Full --> We can't write");
					$display("---------------------------------------------------------------");
				end
				error = 1;		//you are writing on a full FIFO memory
				
			end
			
			else
			begin
				error = 0;
				fifo_mem[wr_ptr] = data_in;		//write data_in into FIFO memory
				//$display($time," -- Data Written in --> fifo_mem[%0d] = %0d",wr_ptr,data_in);
				if(wr_ptr == DEPTH-1)
				begin
					wr_flag = ~wr_flag;			//write flag toggle when write memory becomes full
					//$display($time," -- Last memory location to write -- ");
				end
				wr_ptr = wr_ptr + 1;
			end
		end
		
		if(read_en)
		begin
			if(empty == 1)
			begin
				if(error == 0)
				begin
				$display("---------------------------------------------------------------");
				$display($time," -- ERROR : FIFO Empty --> We can't Read");
				$display("---------------------------------------------------------------");
				end
				error = 1;		//you are reading from empty FIFO
				
			end
			
			else
			begin
				error = 0;
				data_out = fifo_mem[rd_ptr];	//data_out from FIFO perticular FIFO memory
				//$display($time," -- Data Read from --> fifo_mem[%0d] = %0d",rd_ptr,data_out);
				if(rd_ptr == DEPTH-1)
				begin
					rd_flag = ~rd_flag;			//read flag toggle when memory becomes empty
					//$display($time," -- Last memory location to Read -- ");
				end
				rd_ptr = rd_ptr + 1;
			end
		end
	end
end

//full and empty logic of FIFO
always@(*)
begin
	empty = 0;
	full = 0;
	if(wr_ptr == rd_ptr)
		begin
			if(wr_flag != rd_flag)
			begin
				full = 1;
			end
			if(wr_flag == rd_flag)
			begin
				empty = 1;
			end
		end
end
endmodule
	
		
		

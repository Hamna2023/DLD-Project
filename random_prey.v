module random_prey(clk_d, rand_X, rand_Y,updateclock);
	input clk_d, updateclock ;
	output reg [9:0]rand_X= 70;
	output reg [8:0]rand_Y=90;
	
	
  always@(posedge clk_d)
	begin
	rand_X= rand_X +30;
	if(rand_X >= 570)
		begin
		rand_X = 40 ;
		end
	end
	
  always @(posedge updateclock)
	begin
	rand_Y=rand_Y+20 ;
	if(rand_Y >= 400)
		begin
		rand_Y = 40 ;
		end
	end	
	
endmodule

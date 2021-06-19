module Prey(clk_d,good_collision,prey,start,xCount,yCount,updateclock);
	
	input clk_d , good_collision,start,xCount,yCount,updateclock;
	output reg prey ;
  reg [9:0] PreyX;
  reg [8:0] PreyY;
	reg prey_in_x;
	reg prey_in_y;
	wire [9:0]rand_X;
	wire [8:0]rand_Y;
	wire [9:0] xCount;
	wire [9:0] yCount;
  random_prey r1(clk_d, rand_X, rand_Y,updateclock);
  always@(clk_d)
	begin
		if(good_collision)
		begin
			PreyX=rand_X;
			PreyY=rand_Y;
		end
		if(~start)
		begin
		PreyX=rand_X;
		PreyY=rand_Y;
		end
		
	 end
	
  always @(posedge clk_d)
	begin
      prey_in_x <= (xCount > PreyX && xCount < (PreyX + 10));
      prey_in_y <= (yCount > PreyY && yCount < (PreyY + 10));
		prey = prey_in_x && prey_in_y;
	end
	

endmodule 

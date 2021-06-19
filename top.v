module top(
	input start,
	input clk, l,r,u,d,h,
    
  output reg [3:0]red, [3:0]green, [3:0]blue,
	output hsync,vsync,clk_d, blank_n,
    output wire [6:0]seg1,
  output wire [6:0]seg2);
  
    wire [9:0] c_h; 
    wire [9:0] c_v;
	wire p,q,r1,s;
	wire R;
	wire G;
	wire B;
	wire snakeHead,snakeBody;
	wire  GameOver;
	reg  border; 
	wire prey ;
    wire [9:0] a,b;

    
  assign p= clk_d;
  Clks_Generator CLKs(.clk(clk),.updateclock(s),.clk_d(p));
  h_counter c3(.clk(p),.h_count(c_h),.trig_v(q));
  v_counter c4(.clk(p),.enable_v(q),.v_count(c_v));
  vga_sync c5(.h_count(c_h),.v_count(c_v),.h_sync(hsync),.v_sync(vsync),.video_on(r1),.x_loc(a),.y_loc(b));
  
  collision col(.snakeBody(snakeBody),.snakeHead(snakeHead),.border(border),.GameOver(GameOver),.clk_d(p),.updateclock(s),.start(start),.xCount(c_h),.yCount(c_v),.l(l),.r(r),.u(u),.d(d),.h(h),.prey(prey),.seg1(seg1),.seg2(seg2));
  
  
	
	

	
  always @(posedge p) 
	begin
      border<=((((c_h>=0) & (c_h<15) & ((c_v>=220) & (c_v<280))) | (c_h>=630) & (c_h<481) & ((~c_v>=220) & (~c_v<280))) | ((c_v>=0) & (c_v<15) | (c_v>=465) & (c_v< 481)));
	end


							
  assign R = (r && ( prey || GameOver));
  assign G = (r && ((snakeBody || snakeHead || border)&& ~GameOver));
  assign B = (r && ~GameOver);
  always@(posedge clk_d)
	begin
      red = {4{R}};
      green = {4{G}};
      blue = {4{B}};
	end 

endmodule
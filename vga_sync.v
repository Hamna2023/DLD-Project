`timescale 1ns / 1ps
module v_counter(clk,enable_v,v_count);
  input clk;
  input enable_v;
  output [9:0] v_count;
  reg [9:0] v_count;
  initial v_count=0;
  always @ (posedge clk)
  
    begin
      if (enable_v==1)
        begin 
          if (v_count <= 523)
            begin
            	v_count <= v_count + 1;
        	end
          else
        	begin
          	v_count <= 0;
        	end
        end
    
    end
endmodule
module h_counter(clk,h_count,trig_v);
  input clk;
  output [9:0] h_count;
  output trig_v;
  reg [9:0] h_count;
  reg trig_v;
  initial 
    begin
      h_count=0;
      trig_v=0;
    end
  always @ (posedge clk)
    begin
      if (h_count<799)
        begin
          h_count <= h_count+1;
          if (h_count ==798)
          begin 
            trig_v <=1;
          end
        end
      else
        begin
          trig_v <=0;
          h_count <= 0;        
        end
    end
endmodule

module clk_div(clk,clk_d); 
  parameter div_value=1;
  input clk;
  output clk_d;
  reg clk_d;
  reg count;
  initial
    begin
    clk_d=0;
    count=0;
  end
  always @ (posedge clk)
    begin
      if (count==div_value)
        count<=0;
      else
        count<=count+1;
    end
  always @ (posedge clk)
    begin 
      if (count==div_value)
        clk_d <= ~clk_d;
    end
endmodule

module vga_sync(
  input [9:0] h_count,
  input [9:0] v_count,
  output h_sync,
  output v_sync,
  output video_on,
  output [9:0] x_loc,
  output [9:0] y_loc
);
  
  // horizontal 
  localparam HD = 640;   
  localparam HF =16;   
  localparam HB =48;    
  localparam HR =96;    
  
  // vertical
  localparam VD=480; 
  localparam VF=10; 
  localparam VB=33;  
  localparam VR=2;   
  
  
  assign h_sync=~((h_count>=HD+HF) && (h_count<HD+HF+HR));
  assign v_sync=~((v_count>=VD+VF) && (v_count<=491));
  
  // keep X and Y bound within the active pixels
  assign x_loc = h_count;
  assign y_loc = v_count;
  
  //video_on
  
  assign video_on = (h_count<640)&&(v_count<480);
  
endmodule



module top(clk,clk_d,h_sync,v_sync,red,green,blue);
  input clk;
  output clk_d;
  output h_sync;
  output v_sync;
  output reg [3:0] red;
  output reg [3:0] green;
  output reg [3:0] blue;
  wire p,q,r;
  wire [9:0] c_h;
  wire [9:0] c_v;
  wire [9:0] x,y;
  wire R,G,B;
  reg prey;
  reg border;
  reg snake_head;
  reg[9:0] X_snake;
  reg [8:0] Y_snake;
  reg [9:0] preyX;
  reg [9:0] preyY;
  reg X_in,Y_in;
 
  clk_div c1(.clk(clk),.clk_d(p));
  h_counter c2(.clk(p),.h_count(c_h),.trig_v(q));
  v_counter c3(.clk(p),.enable_v(q),.v_count(c_v));
  vga_sync c4(.h_count(c_h),.v_count(c_v),.h_sync(h_sync),.v_sync(v_sync),.video_on(r),.x_loc(x),.y_loc(y));
  assign clk_d=p;
  
  initial
    begin 
      X_snake=10'd20;
      Y_snake=9'd20;
    end
  always@(posedge p )
    begin
      X_in <=(c_h > preyX & c_h < (preyX + 50));
      Y_in <= (c_v > preyY & c_v < (preyY +50));
      prey <= X_in & Y_in;
    end
  
  always @ (posedge p)
    begin
      border<=((((c_h>=0) & (c_h<15) & ((c_v>=220) & (c_v<280))) | (c_h>=630) & (c_h<481) & ((~c_v>=220) & (~c_v<280))) | ((c_v>=0) & (c_v<15) | (c_v>=465) & (c_v< 481)));
    end
  always @ (posedge p)
    begin
      snake_head <= (c_h>X_snake & c_h < (X_snake+10)) & (c_v>Y_snake & c_v< (Y_snake+10));
    end
  always @ (posedge p)
    begin
      prey <= ((c_h>200 & c_h < 210) & (c_v > 300 & c_v < 310 )); 
    end
  assign R = (r & (prey));
  assign G = (r & (snake_head));
  assign B = (r & (border));
  
  always @(posedge p)
    begin
      red ={4{R}};
      green={4{G}};
      blue={4{B}};
    end 
endmodule
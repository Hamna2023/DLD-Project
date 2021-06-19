`timescale 1ns / 1ps
module testbench();
  reg clk = 0;
  reg[15:0]simtime =16'd5;
  reg l,r,u,d,h;
  reg start;
  wire hsync;
  wire vsync;
  wire clk_d;
  wire [3:0] red;
  wire [3:0] green;
  wire [3:0] blue;
  wire blank_n;
  wire [6:0] seg1,seg2;
  integer file_ID;
  
  top t1(start,clk,l,r,u,d,h, red, green, blue, hsync, vsync,clk_d, blank_n,seg1,seg2);


  
  initial
    #10 file_ID = $fopen("output_log_file.txt","w");
  always
    #5 clk = ~clk;
  initial begin
    #50000000 $fclose(file_ID);
    #10 $finish;
  end
  always @(posedge clk_d)
    $fwrite(file_ID,"%05d ns: %b %b %b %b %b\n", $realtime,hsync,vsync,red,green,blue,l,r,u,d);


endmodule
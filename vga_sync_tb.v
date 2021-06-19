`timescale 1ns / 1ps
module testbench_vga();
  reg clk = 0;
  reg[15:0]simtime =16'd5;
  wire h_sync;
  wire v_sync;
  wire clk_d;
  wire [3:0] red;
  wire [3:0] green;
  wire [3:0] blue;
  
  integer file_ID;
  
  top t(clk,clk_d,h_sync,v_sync,red,green,blue);
  
  initial
    #10 file_ID = $fopen("output_log_file.txt","w");
  always
    #5 clk = ~clk;
  initial begin
    #50000000 $fclose(file_ID);
    #10 $finish;
  end
  always @(posedge clk_d)
    $fwrite(file_ID,"%05d ns: %b %b %b %b %b\n", $realtime,h_sync,v_sync,red,green,blue);
  

endmodule
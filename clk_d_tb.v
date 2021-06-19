module tb();
  reg clk;
  reg rst;
  wire clk_d;
  clk_div c1(clk,rst,clk_d);
  initial
    clk = 1'b0;
  always
    #10 clk = ~clk;
  initial
    begin
      $monitor($time,"clk = %b,rst= %b,clk_d = %b",clk,rst,clk_d);
     rst =0;
      #20 rst =1;
      #100 $finish;
    end
  initial
    begin
     $dumpfile ("dump.vcd");
      $dumpvars (0,tb);
    end
endmodule
 
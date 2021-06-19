module tb();
  reg clk;
  wire updateclock;
  wire [21:0] count;
  updateclk u1(clk,updateclock,count);
  initial
    clk = 1'b0;
  always
    #10 clk = ~clk;
  initial
    begin
      $monitor($time,"clk = %b,updateclock = %b, count=%d",clk,updateclock,count);
      #100 $finish;
    end
  initial
    begin
     $dumpfile ("dump.vcd");
      $dumpvars (0,tb);
    end
endmodule
module tb();
  reg clk,l,r,u,d;
  wire [2:0] direction;
  Controller c1(clk,l,r,u,d,direction);
  initial 
    clk = 1'b0;
  always
    #10 clk = ~clk;
  initial
    begin
      $monitor($time,"clk = %b,l=%b,r=%b,u=%b,d=%b,direction=%b",clk,l,r,u,d,direction);
      #20 l=1; r=0; u=0; d=0; 
      #20 l=0; r=1; u=0; d=0; 
      #20l=0; r=0; u=1; d=0;
      #20l=0; r=0; u=0; d=1;
     
      #30 $finish ;
    end
  initial
    begin
     $dumpfile ("dump.vcd");
      $dumpvars (0,tb);
    end
endmodule
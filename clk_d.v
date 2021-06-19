module clk_div ( clk ,rst,clk_d ); 
  output reg clk_d;
  input clk ;
  input rst;
  always @(posedge clk)
    begin
      if (~rst)
        clk_d <= 1'b0;
      else
        clk_d <= ~clk_d;	
    end
endmodule
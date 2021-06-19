module updateclk(clk,updateclock,count);
  input clk;
  output reg updateclock;
  output reg[21:0] count;
  always @ (posedge clk)
    begin
      if (count<2000000)
        begin
          count<=count+1;
          updateclock<=0;
        end
      else
        begin
          count<=0;
          updateclock<=1;
        end
    end
endmodule
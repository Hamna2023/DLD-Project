module h_countertest();
  reg clk;
  wire [9:0] h_count;
  h_counter h1(.clk(clk),.h_count(h_count),.trig_v(trig_v));
  
  initial
    clk =1'b0;
  
  always
    #5 clk = ~clk;
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1,h_countertest);
      $monitor("Time = ",$time, " h_count = %d",h_count, " trig_v = %d",trig_v);
      #8500 $finish;
    end
endmodule
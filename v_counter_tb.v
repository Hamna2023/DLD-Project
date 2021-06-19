// or browse Examples
module v_countertest();
  reg clk;
  reg enable_v;
  wire [9:0] v_count;
  v_counter v1(.clk(clk),.enable_v(enable_v),.v_count(v_count));
  
  initial 
    begin
    clk =1'b0;
    enable_v=1;
    end
  
  
  
  
  always
    #5 clk = ~clk;
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1,v_countertest);
      $monitor("Time = ",$time, " v_count = %d",v_count, " enable_v = %d",enable_v);
      #8000 $finish;
    end
endmodule
module Controller(clk,l,r,u,d,direction);
  input clk,l,r,u,d;
  output reg [2:0] direction;
  
  always@(posedge clk)
    begin
      if(l == 1) 
        begin
          direction <= 3'b001; //left
        end
      else if(r == 1) 
        begin
          direction <= 3'b010; //right
        end
      else if(u == 1) 
        begin
          direction <= 3'b011; //up
        end
      else if(d == 1) 
        begin
          direction <= 3'b100; //down
        end
      else
        begin 
          direction <= direction ; //keep last input
        end
    end 
        
endmodule

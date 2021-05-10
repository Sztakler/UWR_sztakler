module gcdSub(input [15:0] a, b,
              input clk, init,
              output [15:0] o,
              output fin);
  logic cmp;
  logic [14:0] accA;
  logic [14:0] accB;
  assign cmp = accA < accB;
  assign fin = accA == accB;
  assign o = accA;

  always_ff @(posedge clk)
    if (init) 
      begin
        accA <= a;
        accB <= b;
      end 
  	else if (~fin)
      begin
    if (cmp) 
		accB <= accB - accA;
  	else if (!cmp)
		accA <= accA - accB;
      end
  
endmodule

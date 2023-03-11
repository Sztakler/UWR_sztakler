module circuit(input [0:3] i, output [0:3] o);
  assign o[0] = ~i[0] & ~i[1] & ~i[2];
  assign o[1] = ~i[1] & i[2] | i[1] & ~i[2];
  assign o[2] = i[2];
  assign o[3] = ~i[3];
                             
                                 
endmodule
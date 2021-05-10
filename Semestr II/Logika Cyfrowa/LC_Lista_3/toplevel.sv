module Block (input [3:0] a, input [3:0] b, input c0, output [3:0] sum, G_0, P_0);

  logic c1, c2, c3, g0, g1, g2, g3, p0, p1, p2, p3;

  assign g0 = a[0] & b[0];
  assign g1 = a[1] & b[1];
  assign g2 = a[2] & b[2];
  assign g3 = a[3] & b[3];
 
  assign p0 = a[0] | b[0];
  assign p1 = a[1] | b[1];
  assign p2 = a[2] | b[2];
  assign p3 = a[3] | b[3];

  assign c1 = (c0 & p0) | g0;
  assign c2 = (c0 & p0 & p1) | (g0 & p1) | g1;
  assign c3 = (c0 & p0 & p1 & p2) | (g0 & p1 & p2) | (g1 & p2) | g2;

  assign sum[0] = a[0] ^ b[0] ^ c0;
  assign sum[1] = a[1] ^ b[1] ^ c1;
  assign sum[2] = a[2] ^ b[2] ^ c2;
  assign sum[3] = a[3] ^ b[3] ^ c3;

  assign P_0 = p0 & p1 & p2 & p3;
  assign G_0 = (g0 & p1 & p2 & p3) | (g1 & p2 & p3) | (g2 & p3) | g3;

endmodule


module Predict_1 (input G_0, G_1, P_1, output c8);

  assign c8 = G_0 & P_1 | G_1;

endmodule

module Predict_2 (input G_0, G_1, G_2, P_1, P_2, output c12);

  assign c12 = (G_0 & P_1 & P_2) | (G_1 & P_2) | G_2;

endmodule

module Predict_3 (input G_0, G_1, G_2, G_3, P_1, P_2, P_3, output c16);

  assign c16 = (G_0 & P_1 & P_2 & P_3) | (G_1 & P_2 & P_3) | (G_2 & P_3) & G_3;

endmodule

module toplevel (input [15:0] a, input [15:0] b, output [15:0] o);

  logic  G_0, G_1, G_2, G_3, P_1, P_2, P_3, c4, c8, c12, c16;

  Block block_0 (a[3:0], b[3:0], 0, o[3:0], G_0, P_0);

  Block block_1 (a[7:4], b[7:4], G_0, o[7:4], G_1, P_1);
  Predict_1 p1 (G_0, G_1, P_1, c8);

  Block block_2 (a[11:8], b[11:8], c8, o[11:8], G_2, P_2);
  Predict_2 p2 (G_0, G_1, G_2, P_1, P_2, c12);
  
  Block block_3 (a[15:12], b[15:12], c12, o[15:12], G_3, P_3);
  Predict_3 p3 (G_0, G_1, G_2, G_3, P_1, P_2, P_3, c16);

endmodule

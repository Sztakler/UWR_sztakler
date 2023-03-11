module sumator_16_bit(input [0:15] a, input [0:15] b, output [0:15] o);

  function [0:2] sumator_1_bit(input a, b, c);
    sumator_1_bit = ({a & b, a | b, a ^ b ^ c});
  endfunction

  function out_c1(input c0, g0, p0);
    out_c1 = (g0 | p0 & c0);
  endfunction


  function out_c2(input c0, g0, p0, c1, g1, p1);
    out_c1 = (g1 | (p1 & g0) | (p1 & p0 & c0));
  endfunction



  function []sumator_2_bit(input [0:1] a, input [0:1] b, input c0);
  endfunction

endmodule

module sumator_16_bit(input [0:15] a, input [0:15] b, output [0:15] o);

  function ckn(input n, )

endmodule

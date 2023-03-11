module funnelshifter(input [7:0] a, input [7:0] b, input [3:0]n, output [7:0] o);
  logic [15:0] concatenated;
  assign concatenated = {a, b}; 
  assign o = concatenated[n+7:n];

endmodule

module left_right_shifter_rotator(input [7:0] i, input [3:0] n, input ar, lr, rot, output [7:0] o);
    funnelshifter fs
    (
        (rot? i : ar? (lr? i : (i[7]? 'b11111111 : 'b00000000)) : (lr? i : 'b00000000)),
        (rot? i : ar? (lr? 'b00000000 : i) : (lr? 'b00000000 : i)),
        (lr? 8-n : n),
        o 
    ); 

endmodule
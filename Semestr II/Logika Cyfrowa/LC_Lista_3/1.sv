module zad1(input [0:3] a, input [0:3] b, input sub, output [0:3] c);

    logic t, c0, c1, c2, c3, c4, c5, c6, c7;

    function [0:1] fullAdder(input a, b, c);
        fullAdder = ({(a ^ b ^ c), ((a & b) | (a & c) | (b & c))});
    endfunction

    assign {c[3], c0} = fullAdder(a[3], b[3], 0);
    assign {c[2], c1} = fullAdder(a[2], b[2], c0);
    assign {c[1], c2} = fullAdder(a[1], b[1], c1);
    assign {c[0], c3} = fullAdder(a[0], b[0], c2);

    assign t = c[2] & c[0];

    assign {c[7], c4} = fullAdder(a[3], b[3], c3);
    assign {c[6], c5} = fullAdder(a[2], b[2], c0);
    assign {c[5], c6} = fullAdder(a[1], b[1], c1);
    assign {c[4], c7} = fullAdder(a[0], b[0], c2);
 
endmodule
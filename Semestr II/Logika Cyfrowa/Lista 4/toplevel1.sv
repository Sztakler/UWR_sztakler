module toplevel(input [3:0] i, input l, input r, output [3:0] o);
    assign o[0] = i[1] && r || i[0] && (l ~| r);
    assign o[1] = (i[0] && l || i[2] && r) || (i[1] && (l ~| r));
    assign o[2] = (i[1] && l || i[3] && r) || (i[2] && (l ~| r));
    assign o[3] = i[2] && l || i[3] && (l ~| r);
endmodule
module tff(output q, nq, input t, clk, nrst);

logic ns, nr, ns1, nr1, j, k;

nand           
n1(ns, clk, j), 
n2(nr, clk, k),
n3(q, ns, nq), 
n4(nq, nr, q, nrst),
n5(ns1, !clk, t, nq), 
n6(nr1, !clk, t, q),
n7(j, ns1, k), 
n8(k, nr1, j, nrst);
endmodule

module asyncnt(output [2:0] q, input en, clk, nrst);

genvar n;
logic [2:-1] nq;

assign nq[-1] = clk;

for (n = 0; n < 3; n = n + 1)
	tff tf(q[n], nq[n], en, nq[n-1], nrst);
endmodule

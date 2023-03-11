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

module asyncnt(output [3:0] out, input clk, step, down, nrst);

  logic [3:0] nq, t;

  assign t[0] = step? 0:1;
  tff tf0(out[0], 
          nq[0], 
          t[0], 
          clk, 
          nrst);
  
  assign t[1] = down? 
				  	(step? 1:nq[0]) :
				   	(step? 1:out[0]);				   	
  tff tf1(out[1], 
          nq[1], 
          t[1], 
          clk, 
          nrst);
  
  assign t[2] = down? 
  					(nq[1] & t[1]) :
   					(out[1] & t[1]); 					
  tff tf2(out[2], 
          nq[2], 
          t[2], 
          clk, 
          nrst);
  
  assign t[3] = down? 
					(nq[2] & t[2]) : 
					(out[2] & t[2]);
  tff tf3(out[3], 
          nq[3], 
          t[3], 
          clk, 
          nrst);
  
endmodule


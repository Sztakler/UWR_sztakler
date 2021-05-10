module GrayToBin(
	input [31:0] GrayCode,
	output [31:0] BinCode);
	 
  integer j;
  always_comb
    begin
      BinCode = 0;
      BinCode[31] = GrayCode[31];
      
      for (j = 30; j >= 0; j--)
        BinCode[j] = GrayCode[j] ^ BinCode[j + 1];
    end
    
    
endmodule

module toplevel(
	input [31:0] i,
	output [31:0] o);
  
  //Stosuję algorytm z https://pl.wikipedia.org/wiki/Kod_Graya
  
  GrayToBin gtb(i, o);
      
endmodule


module decoder_2_to_4(input [1:0] i, output [3:0] o);
  always_comb
    case(i)
      2'd0: o = 4'b0001;
      2'd1: o = 4'b0010;
      2'd2: o = 4'b0100;
      2'd3: o = 4'b1000;
      endcase
endmodule
module circuit(input [2:0] i, output [7:0] o);
  logic [3:0] dec1;
  logic [3:0] dec2;
  logic [7:0] dec_3_to_8;
  logic [3:0] zero = 'b0000;
  
  decoder_2_to_4 dec_2_to_4_1(i[1:0], dec1);
  decoder_2_to_4 dec_2_to_4_2(i[1:0], dec2); //Powtórzenie pierwszego dekodera
  
  always_comb
    begin
      if (i[2] == 0) 
        begin
          dec_3_to_8 = {zero, dec1};
        end
      else if (i[2] == 1)
        begin
          dec_3_to_8 = {dec2, zero};
        end
    end
  
  assign o = dec_3_to_8;
         
endmodule


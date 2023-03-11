module sort(
	input [15:0] i,
 	output [15:0] o);
 
 
  logic [15:0] array;
  integer k, j, tmp;
  
  always_comb
    begin
      array = i;
      for (k = 0; k < 15; k = k + 4)
        for (j = 0; j < 11 - k; j = j + 4)
          begin
            if (array[j+3:j] > array[j+7:j+4])
              begin
                tmp = array[j+3:j];
                array[j+3:j] = array[j+7:j+4];
                array[j+7:j+4] = tmp;
              end
          end
    end
  assign o = array;
endmodule


module pwm(output logic [15:0] cnt, cmp, top,
            output logic out,
            input [1:0] sel,
            input [15:0] d,
            input clk);
  
  
  always_ff @(posedge clk)
    begin
      if (sel == 3) cnt <= d;
      else begin
      	cnt <= cnt + 16'b1;
        if (cnt >= top) cnt <= 16'b0;
        if (sel == 1) cmp <= d;
        else if (sel == 2) top <= d;
      end
    end
  
  assign out = (cnt < cmp);
  
  
endmodule

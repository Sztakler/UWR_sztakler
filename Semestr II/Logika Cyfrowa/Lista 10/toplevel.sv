module ram(
			input step, write,
			input [15:0] in,
			input [9:0] address,
			output [15:0] data);
			
  logic [15:0] mem [0:1023];
  assign data = mem[address-1];
  always_ff @(posedge step)
    if (write) mem[address] <= in;
  
endmodule		


module toplevel(input step, nrst, push,
				input [15:0] d,
				input [1:0] op,
				output [15:0] out,
				output [9:0] cnt);
				
  logic [15:0] prev, data, load, addr, res;
	always_comb
      case (op)
      	2'b01: res = -out;
      	2'b10: res = out + data;
      	2'b11: res = out * data;
      	default: res = out;
      endcase
     
        
  always_ff @(posedge step or negedge nrst)
		begin
          if(!nrst)
				begin
					out <= 16'b00;
					cnt <= 16'b00;
				end
			else if(push)
				begin	
					out <= d;
					cnt <= cnt + 10'b01;
				end
          else if((op==2'b10 || op==2'b11) & cnt > 0) 
				begin
					out <= res;
					cnt <= cnt - 10'b01;
				end
			else	out <= res;
        end
  
  ram stack(step, push, out, cnt-1, data);

endmodule 

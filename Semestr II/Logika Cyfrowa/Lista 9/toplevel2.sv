module microwave(
	input clk, nrst, door, start, finish,
	output heat, light, bell);
	
	//kody stanów automatu
	const logic [2:0] CLOSED = 3'b000, COOK = 3'b001,
					  PAUSE  = 3'b010, BELL = 3'b011,
					  OPEN   = 3'b100;
				
	//stan automatu
	logic [2:0] q;
	
	//funkcja wyjścia
	
	always_comb begin
		heat = 0; light = 0; bell = 0;
		unique case (q)
			CLOSED: begin
				end
			COOK: begin
				heat = 1;
				light = 1;
				end
			PAUSE: begin
				light = 1;
				end
			BELL: begin
				bell = 1;
				end
			OPEN: begin
				light = 1;
				end
		endcase
	end
	
	//funkcja przejścia
	
	always_ff @(posedge clk or negedge nrst)
		if(!nrst) q <= CLOSED;
		else unique case(q)
			CLOSED: begin
				if(door) q <= OPEN;
				else if(~door & start) q <= COOK;
				end
			COOK: begin
				if(door) q <= PAUSE; 
				else if(~door & finish) q <= BELL;
				end
			PAUSE: begin
				if(~door) q <= COOK;
				end
			BELL: begin
				if(door) q <= OPEN;
				end
			OPEN: begin
				if(~door) q <= CLOSED;
				end
			default: q <= q;
		endcase
						 
	
endmodule


module microwave(
	input clk, nrst, door, start, finish,
	output heat, light, bell);
	
	//kody stanów automatu
	const logic [2:0] CLOSED = 3'b000, COOK = 3'b001,
					  PAUSE  = 3'b010, BELL = 3'b011,
					  OPEN   = 3'b100;
				
	//stan automatu
	logic [2:0] q;
	
	//funkcja wyjścia
	
	always_comb begin
		heat = 0; light = 0; bell = 0;
		unique case (q)
			CLOSED: begin
				light = door | ~door & start;
				heat = ~door & start;
				end
			COOK: begin
				heat = ~door & ~finish;
				light = ~door & ~finish | door;
				bell = ~door & finish;
				end
			PAUSE: begin
				heat = ~door;
				light = 1;
				end
			BELL: begin
				bell = ~door & finish;
				light = door;
				end
			OPEN: begin
				light = door;
				end
		endcase
	end
	
	//funkcja przejścia
	
	always_ff @(posedge clk or negedge nrst)
		if(!nrst) q <= CLOSED;
		else unique case(q)
			CLOSED: begin
				if(door) q <= OPEN;
				else if(~door & start) q <= COOK;
				end
			COOK: begin
              if(door) q <= PAUSE; 
				else if(~door & finish) q <= BELL;
				end
			PAUSE: begin
				if(~door) q <= COOK;
				end
			BELL: begin
				if(door) q <= OPEN;
				end
			OPEN: begin
				if(~door) q <= CLOSED;
				end
			default: q <= q;
		endcase
						 
	
endmodule

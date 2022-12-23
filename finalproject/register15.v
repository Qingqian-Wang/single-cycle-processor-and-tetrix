module register15(D,Q,en,clk,clr);
	input[14:0] D;
	output reg[14:0] Q;
	input en,clk,clr;
	
	initial begin 
		Q = 15'h00000000;
	end 
	
	always @(posedge clk or posedge clr) begin
		if (clr)
			Q=15'h00000000;
		else if (en)
			Q=D;
	end
endmodule
			
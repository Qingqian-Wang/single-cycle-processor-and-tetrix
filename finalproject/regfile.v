module regfile(
	clock, wren, clear,regD, regA, regB,valD,valA, valB,
	row1,row2,row3,row4,row5,row6,row7,row8,row9,row10,
	row11,row12,row13,row14,row15,row16,row17,row18,row19,row20,score
);
	input clock, wren, clear;
	input [4:0] regD, regA, regB;
	input [31:0] valD;
	output [31:0] valA, valB;
	output [14:0] row1;
	output [14:0] row2;
	output [14:0] row3;
	output [14:0] row4;
	output [14:0] row5;
	output [14:0] row6;
	output [14:0] row7;
	output [14:0] row8;
	output [14:0] row9;
	output [14:0] row10;
	output [14:0] row11;
	output [14:0] row12;
	output [14:0] row13;
	output [14:0] row14;
	output [14:0] row15;
	output [14:0] row16;
	output [14:0] row17;
	output [14:0] row18;
	output [14:0] row19;
	output [14:0] row20;
	output [31:0] score;
	reg[31:0] regs[31:0];
   integer i;
	always @(posedge clock or posedge clear)
	begin
		if(clear)
			begin     
				for(i = 0; i < 32; i = i + 1)
					begin
						regs[i] = 32'd0;
					end
			end
		else
			if(wren && regD != 5'd0)
				regs[regD] = valD;
	end
	
	assign valA =regs[regA];
	assign valB =regs[regB];
	assign row1=regs[1][14:0];
	assign row2=regs[1][29:15];
	assign row3=regs[2][14:0];
	assign row4=regs[2][29:15];
	assign row5=regs[3][14:0]; 
	assign row6=regs[3][29:15];
	assign row7=regs[4][14:0];
	assign row8=regs[4][29:15];
	assign row9=regs[5][14:0];
	assign row10=regs[5][29:15];
	assign row11=regs[6][14:0];
	assign row12=regs[6][29:15];
	assign row13=regs[7][14:0];
	assign row14=regs[7][29:15];
	assign row15=regs[8][14:0];
	assign row16=regs[8][29:15];
	assign row17=regs[9][14:0];
	assign row18=regs[9][29:15];
	assign row19=regs[10][14:0];
	assign row20=regs[10][29:15];
	assign score=regs[17];
endmodule


module skeleton(resetn, 
	ps2_clock, ps2_data, 										// ps2 related I/O
	debug_data_in, debug_addr, leds, 						// extra debugging ports
	lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon,// LCD info
	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,		// seven segements
	VGA_CLK,   														//	VGA Clock
	VGA_HS,															//	VGA H_SYNC
	VGA_VS,															//	VGA V_SYNC
	VGA_BLANK,														//	VGA BLANK
	VGA_SYNC,														//	VGA SYNC 
	VGA_R,   														//	VGA Red[9:0]
	VGA_G,	 														//	VGA Green[9:0]
	VGA_B,															//	VGA Blue[9:0]
	CLOCK_50);  													// 50 MHz clock
		
	////////////////////////	VGA	////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	input				CLOCK_50;

	////////////////////////	PS2	////////////////////////////
	input 			resetn;
	inout 			ps2_data, ps2_clock;
	
	////////////////////////	LCD and Seven Segment	////////////////////////////
	output 			   lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[31:0] 	debug_data_in;
	output   [11:0]   debug_addr;
	
	
	
	
	
	wire			 clock;
	wire			 lcd_write_en;
	wire 	[31:0] lcd_write_data;
	wire	[7:0]	 ps2_key_data;
	wire			 ps2_key_pressed;
	wire	[7:0]	 ps2_out;	
	wire  [14:0] rowData1;
	wire  [14:0] rowData2;
	wire  [14:0] rowData3;
	wire  [14:0] rowData4;
	wire  [14:0] rowData5;
	wire  [14:0] rowData6;
	wire  [14:0] rowData7;
	wire  [14:0] rowData8;
	wire  [14:0] rowData9;
	wire  [14:0] rowData10;
	wire  [14:0] rowData11;
	wire  [14:0] rowData12;
	wire  [14:0] rowData13;
	wire  [14:0] rowData14;
	wire  [14:0] rowData15;
	wire  [14:0] rowData16;
	wire  [14:0] rowData17;
	wire  [14:0] rowData18;
	wire  [14:0] rowData19;
	wire  [14:0] rowData20;
	wire [31:0] scoreOut;
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	//assign clock = inclock;
	
	// your processor
	processor myprocessor(inclock, ~resetn, ps2_out, ps2_key_pressed, lcd_write_en, lcd_write_data,
	rowData1,rowData2,rowData3,rowData4,rowData5,rowData6,rowData7,rowData8,rowData9,rowData10,
			rowData11,rowData12,rowData13,rowData14,rowData15,rowData16,rowData17,rowData18,rowData19,rowData20,scoreOut);
	
	// keyboard controller
	
//	ps2 myps2
//	  (
//		 inclock,~resetn,ps2_key_pressed,ps2_clock,ps2_data
//		 ,ps2_out
//	  );
	
	// ps2_out here is the num after the ans/ps2_key_data here is the original data(is not important)
	// the pressed will be 1 if there is a new data
	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	
	// lcd controller
	lcd mylcd(clock, ~resetn, 1, ps2_out, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	// example for sending ps2 data to the first two seven segment displays
	Hexadecimal_To_Seven_Segment hex1(ps2_out[3:0], seg6);
	Hexadecimal_To_Seven_Segment hex2(ps2_out[7:4], seg7);
	
	// the other seven segment displays are currently set to 0
	Hexadecimal_To_Seven_Segment hex3(4'b0, seg3);
	Hexadecimal_To_Seven_Segment hex4(4'b0, seg4);
	Hexadecimal_To_Seven_Segment hex5(4'b0, seg5);
	Hexadecimal_To_Seven_Segment hex6(4'b0, seg1);
	Hexadecimal_To_Seven_Segment hex7(4'b0, seg2);
	Hexadecimal_To_Seven_Segment hex8(4'b0, seg8);
	
	// some LEDs that you could use for debugging if you wanted
	assign leds = 8'b00101011;
		
	// VGA
	Reset_Delay			r0	(.iCLK(clock),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(clock),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	vga_controller vga_ins(.iRST_n(DLY_RST),
								 .iVGA_CLK(VGA_CLK),
								 .oBLANK_n(VGA_BLANK),
								 .oHS(VGA_HS),
								 .oVS(VGA_VS),
								 .b_data(VGA_B),
								 .g_data(VGA_G),
								 .r_data(VGA_R),
								 .ps2_out(ps2_out),
								 .rowData1(rowData1),
								 .rowData2(rowData2),
								 .rowData3(rowData3),
								 .rowData4(rowData4),
								 .rowData5(rowData5),
								 .rowData6(rowData6),
								 .rowData7(rowData7),
								 .rowData8(rowData8),
								 .rowData9(rowData9),
								 .rowData10(rowData10),
			.rowData11(rowData11),
			.rowData12(rowData12),
			.rowData13(rowData13),
			.rowData14(rowData14),
			.rowData15(rowData15),
			.rowData16(rowData16),
			.rowData17(rowData17),
			.rowData18(rowData18),
			.rowData19(rowData19),
			.rowData20(rowData20),
			.scoreOut(scoreOut)
			);
	
	
endmodule

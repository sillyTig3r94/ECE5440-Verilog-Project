// Course:	ECE 5440
// Author:	Thong M. Nguyen
// Module:	access controller
// Describle:	access controller module blocked load modules until 4-dgit password
//					is entered correctly. A red and green led output will indicate if the password
//					is correctly entered. User will have to enter 4-digit continuesly, if one is wrong
//					users is allowed to re-enter the password.

module access_controller(	

	input	bt_loadin_1,

	input	bt_loadin_2,

	input	clk,
	
	input	reset,
	
	input	bt_check,
	
	input	[3:0] rom_q,

	input	[3:0]	sw_check,

	output	reg [1:0] led_indicate,

	output	reg [2:0] state, //only for debugging purpose, will be removed on the actual module design

	output	reg bt_loadout_1,

	output	reg bt_loadout_2,
	
	output	reg [1:0] addr_pt
);

	parameter s0 = 3'b000,	s1 = 3'b001,	s2 = 3'b010;

	parameter s3 = 3'b011,	s4 = 3'b100,	s5 = 3'b101;

//	reg	[2:0]	state;

reg	incorrect;	// wrong password status flag	

	always @(posedge clk) begin
	
		if(reset)	
			begin
				state = s0;	
				
				incorrect = 0;	
				
				addr_pt = 0;	//default
			end
		
		else	
			begin		
				case(state)
					s1:	
						begin
						
							if(bt_check == 0)
								begin
									state = s2;	// go to next stage, when button is pressed									
									if(sw_check != rom_q)		//checking for '5'
										incorrect = 1;	// wrong password entered set the flag
									addr_pt = 1;
								end

						end
					
					s2:	
						begin
						
							if(bt_check == 0)
								begin
									state = s3;	// go to next stage, when button is pressed
									
									if(sw_check != rom_q)		//checking for '7'
										incorrect = 1;	// wrong password entered set the flag
									addr_pt = 2;
								end
								
						end
					
					s3:	
						begin
						
							if(bt_check == 0)
								begin
									state = s4;	// go to next stage, when button is pressed
									
									if(sw_check != rom_q)		//checking for '4'
										incorrect = 1;	// wrong password entered set the flag
									addr_pt = 3;							
								end
						end
					
					s4:	
						begin
						
							if(bt_check == 0)
								begin
									state = s5;	// go to next stage, when button is pressed
									
									if(sw_check != rom_q)		//checking for '5'
										incorrect = 1;	// wrong password entered set the flag										
									addr_pt = 0;
								end
						end
					
					s5:	
						begin
						
							if(incorrect == 1) 
								begin
									state = s1;	// go back to s1, since one or more digits entered incorrectly
									incorrect = 0;
								end
							else
								begin							
									state = s5;	//locked state
									led_indicate = 2'b10;		// red led off, green led on
									bt_loadout_1 = bt_loadin_1;	// assign load_output = load_input
									bt_loadout_2 = bt_loadin_2;	// assign load_output = load_input
								end
						end
					
					default:
						begin
							state = s1;
							led_indicate = 2'b01;
							incorrect = 0;	//reset wrong password stage
							addr_pt = 0;
						end
				endcase
		end

	end

endmodule


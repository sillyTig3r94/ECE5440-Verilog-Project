// Course:	ECE 5440
// Author:	Thong M. Nguyen
// Module:	button shaper module
// Describle:	button shaper module take input button pressed and converted into
//					a single active-low pulse at output.
module button_shaper(button_in,clk,reset,button_out);
	input	button_in;

	input	clk;

	input	reset;

	output	button_out;

	reg	button_out;

	reg	[1:0]	state;

	parameter s1 = 2'b00,	s2 = 2'b01;
	parameter s3 = 2'b10,	s4 = 2'b11;

	always @(posedge clk) begin
		if(reset)
			button_out = 1;
		else
			begin	
				case(state)
					s1:	//initial state
						begin
							if(button_in == 0)	//button pressed
								begin
									state = s2;
									button_out = 1;
								end
						else
							begin
								state = s1;
								button_out = 1;
							end
			
						end

					s2:	// detected pressed
						begin
							state = s3;	//go to wait state
							button_out = 0;
						end
					s3:
						begin
							button_out = 1; // regardless button still pressed or not for single pulse
							if(button_in == 0)	//button still pressed
								begin
									state = s3;	//loop back to wait state
								end
							else	//button released
								begin
									state = s1;
								end
						end
					default: 
						begin
							state = s1;
							button_out = 1;
						end
	
				endcase
			end
		end
endmodule


	

// Course:	ECE 5440
// Author:	Thong M. Nguyen
// Module:	digital timer  module
// Describle:	countdown from config [s], stop at 0s.

module digital_timer(
	input clk_50Mhz,
	input clk_1hz,
	input reset,
	input enable,
	input game_bt,
	input config_bt,
	input [3:0] config_dec,
	input	[3:0] config_sec,
	output[3:0] timer_dec,
	output[3:0] timer_sec,
	output timeout_led
);

reg [3:0] counter_down_dec;
reg [3:0] counter_down_sec;
reg timeout_status;
reg game_flag;
reg config_flag;
reg config_next;


initial begin
	timeout_status = 0;
	counter_down_dec = 4'b1001;	//default value = 9
	counter_down_sec = 4'b1001;
end
// down counter
always @(posedge clk_1hz, posedge reset, negedge config_bt, negedge game_bt) begin

	if(reset == 1) 
		begin
			timeout_status = 0;
			counter_down_dec = 4'b1001;	// default value = 9
			counter_down_sec = 4'b1001;	// default value = 9
			config_next = 0;
			game_flag = 0;
			config_flag = 0;

		end
		
	else if(config_bt == 0) begin
		config_flag = 1;
		end
	else if(game_bt == 0) begin
		game_flag = 1;
		end
		
	else begin		
		/* button checking block */	
		if(game_flag == 1 && timeout_status == 0) 
			timeout_status = 1;
			
		if(config_flag == 1 && timeout_status == 0) begin	
		 
			if(config_dec > 4'b1001) 
				counter_down_dec = 4'b1001;
			else 
				counter_down_dec = config_dec;

			
			if(config_sec > 4'b1001) 
				counter_down_sec = 4'b1001;
			else
				counter_down_sec = config_sec;
		
				config_flag = 0;
		end
					
		/* timer block */	
		if(timeout_status == 1)  begin			
			counter_down_sec = counter_down_sec - 1;
			if(counter_down_sec == 4'b1111) begin
				counter_down_dec = counter_down_dec - 1;
				counter_down_sec = 4'b1001;
				if(counter_down_dec == 4'b1111) begin
					timeout_status = 0;	// clear timeout flag
					counter_down_sec = 4'b0000;
					counter_down_dec = 4'b0000;
					config_flag = 0;
					game_flag = 0;
				end
					
			end			
		end
	
	end
	
end



assign timer_dec = counter_down_dec;

assign timer_sec = counter_down_sec;

assign timeout_led = timeout_status;

endmodule

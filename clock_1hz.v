// Course:	ECE 5440
// Author:	Thong M. Nguyen
// Module:	clock 1hz
// Describle:	generate 1hz out clock from 50Mhz input clock
module clock_1hz (
	input clk_50Mhz,
	input reset,
	input enable,
	output clk_1hz);

reg [31:0] counter;
reg clk_out;
reg enable_flag;

initial begin
	counter <= 32'b0;
	clk_out <= 1'b0;
end

always @ (posedge clk_50Mhz) begin

	if(reset) begin
		counter = 32'b0;
		clk_out = 1'b0;
		enable_flag = 0;
	end

	if(enable == 1 && enable_flag == 0) begin
		enable_flag = 1;
		counter = 32'b0;
		clk_out = 1'b0;
	end

	if(enable_flag) begin
		counter = counter + 1'b1;
	if (counter == 25000000) begin	//actual value for 1[s]
//		if (counter == 24) begin // only for simulation 24 pulses of 50Mhz to generate 1 pulse/1 second
		clk_out = !clk_out;
		counter = 32'b0;
		end
	end
	
end

assign clk_1hz = clk_out;

endmodule 

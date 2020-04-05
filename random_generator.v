// Course:	ECE 5440
// Author:	Thong M. Nguyen
// Module:	random number generator module
// Describle:	generate a new random number when button is pressed.

module random_generator(
    input wire clk, reset, bt,enable,timeout,
    output [3:0] q
);


reg [3:0] r_reg;

wire bt_in;
                        
always @(posedge clk)
begin 
    if (reset)        
        r_reg <= 4'b0000;  // set initial value to 1 
    else 
		if (bt_in == 1'b1 && enable == 1 && timeout == 1)
			r_reg <= r_reg+1;
end

assign bt_in = ~ bt;

assign q = r_reg;

endmodule  

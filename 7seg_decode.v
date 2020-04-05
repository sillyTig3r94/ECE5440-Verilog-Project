// Course:	ECE 5440
// Author:	Thong M. Nguyen
// Module:	decode_7seg
// Describle:	decode_7seg module output the coressponding 7 bit - result  of  4 bit- input signal
//		to display on 7 segment led.
module decode_7seg(sw, decode_7seg);
	input 	[3:0]	sw;
	output	[6:0]	decode_7seg;
	reg	[6:0]	decode_7seg;

	always @(sw) begin
		case(sw)
			//input: sw3 sw2 sw1 sw0, output: g f e d c b a
			4'h0: decode_7seg = 7'b1000000;
			4'h1: decode_7seg = 7'b1111001;
			4'h2: decode_7seg = 7'b0100100;
			4'h3: decode_7seg = 7'b0110000;
			4'h4: decode_7seg = 7'b0011001;
			4'h5: decode_7seg = 7'b0010010;
			4'h6: decode_7seg = 7'b0000010;
			4'h7: decode_7seg = 7'b1111000;
			4'h8: decode_7seg = 7'b0000000;
			4'h9: decode_7seg = 7'b0010000;
			4'hA: decode_7seg = 7'b0001000;
			4'hB: decode_7seg = 7'b0000011;
			4'hC: decode_7seg = 7'b1000110;
			4'hD: decode_7seg = 7'b0100001;
			4'hE: decode_7seg = 7'b0000110;
			4'hF: decode_7seg = 7'b0001110;
		endcase
	end
endmodule


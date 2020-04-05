# -*- coding: utf-8 -*-
"""
Created on Tues Mar 24 18:22:36 2020

@author: sillytig3r94 
"""
 Note: just pseudo code 

module swapping(

	/* this is my input signal from other module - W.i.P */
	
	
	/* this is my hardware input signal */
	input	clk,
	input	reset,
	input	bt_left,
	input	bt_right,
	input	bt_choose,
	input	sw_done,
	
	/* this get from the word generator module */
	input	[7:0]	7seg_inChar0,
	input	[7:0]	7seg_inChar0,
	input	[7:0]	7seg_inChar0,
	
	/* this goes to 7 segment module for display */	
	output	[7:0]	7seg_outChar0,
	output	[7:0]	7seg_outChar1,
	output	[7:0]	7seg_outChar2,
	
	/* and this shit goes to my cursor control module */
	output	[2:0]	cursor_indicator
	);

reg [7:0]	swap_char0;	

reg [7:0]	swap_char1;

reg [7:0]	myOut_char [0:1]; //  1-D char array, this is not C or python, WTF is this ?  i hate this shit

reg	[2:0]	myCursor_indicator;

reg [1:0]	index_swap0;
reg [1:0]	index_swap1;

reg [1:0]	swap_status;

reg 

always @(posedge clk)
begin 
	/* reset */
	if(reset) {	
	
		myCursor_indicator = 3'b100;
		
		magic = 3'b000;
		
		swap_status = 0;	

		/* assign my input */
		myOut_char[0] = 7seg_inChar0;
		myOut_char[1] = 7seg_inChar1;
		myOut_char2[2] = 7seg_inChar2;
		myOut_char2[3] = 0;	// dummy or don't care
	}
	
	else {	
		/* move left */
		if(bt_left)	begin
			myCursor_indicator = myCursor_indicator << 1 | myCursor_indicator >> (3 - 1); // never heard of circular shift, google it.
		end
		
		if(bt_right) begin
			myCursor_indicator = myCursor_indicator >> 1 | myCursor_indicator << (3 - 1); // never heard of circular shift, google it.
		end
		
		if(bt_choose) begin
					
			switch(myCursor_indicator)
			{
				case '100':
					if(swap_status == 0)	//first swap character
						swap_char0 = myOut_char[0];
						index_swap0 = 0;
					else	//second swap character
						swap_char1 = myOut_char[0];
						index_swap0 = 0;
										
					break;
														
				case '010':
					if(swap_status == 0)	//first swap character
						swap_char0 = myOut_char[1];
						index_swap0 = 1;
					else
						swap_char1 = myOut_char[1];
						index_swap1 = 1;
											
					break;
					
				case '001':
					if(swap_status == 0)	//first swap character
						swap_char0 = myOut_char[2];
						index_swap0 = 2;
					else
						swap_char1 = myOut_char[2];
						index_swap1 = 2;
					break;
				default:
					/* not likely to get here but just in case */
					
					break;
			}
			swap_status += 1;
			
			if(swap_status == 2'11') begin
			/* already chosen 2 chars - then swap */		
				swap_status = 0; // re-initial , don't ask why >_< 			
				/* then perform swap */
				myOut_char[index_swap0] = swap_char1;
				myOut_char[index_swap1] = swap_char0;
		
			}
			 		
			end
			
		end
		
		
		/* done swapping - assign stuff */	
		if(done_swapping) begin
			/* do something , i don't know so tell me */
		end
	}
	
end

/* assign my output */
assign 7seg_outChar0 = myOut_char0;  
assign 7seg_outChar1 = myOut_char1;  
...
... 
assign cursor_indicator = myCursor_indicator;  

endmodule 


	
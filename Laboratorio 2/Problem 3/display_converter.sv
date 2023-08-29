module display_converter (input A, B, C, D, output [6:0] led_disp);

	assign led_disp[0] = ~A&~B&~C&D | ~A&B&~C&~D | A&~B&C&D | A&B&~C&D; 
	assign led_disp[1] = B&C&~D | A&C&D | A&B&~D | ~A&B&~C&D;
	assign led_disp[2] = A&B&~D | A&B&C | ~A&~B&C&~D; 
	assign led_disp[3] = ~B&~C&D | B&C&D | ~A&B&~C&~D | A&~B&C&~D; 
	assign led_disp[4] = ~A&D | ~B&~C&D | ~A&B&~C; 
	assign led_disp[5] = ~A&~B&D | ~A&~B&C | ~A&C&D | A&B&~C&D; 
	assign led_disp[6] = ~A&~B&~C | ~A&B&C&D | A&B&~C&~D; 

endmodule 
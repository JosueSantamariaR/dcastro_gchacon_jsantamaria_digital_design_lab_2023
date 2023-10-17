module calcWin(
	input logic [5:0]total_mines,
	output int toWin);
	
	assign toWin = 64 - total_mines;
		
endmodule

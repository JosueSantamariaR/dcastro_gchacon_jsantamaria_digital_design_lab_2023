module ClockDivider(
	input logic clk,
	output logic vgaclk);
	
	reg [15:0] cnt;
	   
		//------------------------------------Divisor de Clock-------------------------------
	   always @(posedge clk)
      {vgaclk, cnt} <= cnt + 16'h8000;
		
endmodule

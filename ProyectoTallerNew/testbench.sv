`timescale 1ns/1ps
module testbench();
	logic 		 clk;
	logic 		 reset;
	logic			 enabledVGA;

	
	logic Finished;
	logic	LReset;
	wire [7:0] red;
	wire [7:0] green;
	wire [7:0] blue;
	wire hsync;
	wire vsync;

				
	
	// Instantiate top
	ProcesadorTaller dut(clk, reset, enabledVGA, Finished, LReset, red,green,blue,hsync,vsync);
	
	// Initialize
	initial
	begin
		reset <= 1;
		enabledVGA <= 0;
		#50;
		reset <= 0;
		enabledVGA <= 1;
	end
	
	// Clock to sequence tests
	always
	begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	end
	
	
endmodule
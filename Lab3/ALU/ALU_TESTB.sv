module ALU_TESTB;
	
	
	parameter N = 4;
	
	reg _trigger;
	reg _reset;
	reg [N-1:0] A;
	reg [N-1:0] B;
	reg [3:0] _selection;
	
	wire Negative;
	wire Zero;
	wire CarryOut;
	wire Overflow;
	wire [N-1:0] _Result;
	wire [3:0] oper;
	
	ALU #(.M(N)) Alu_TEST(
		.A(A),
		.B(B),
		._triggerer(_trigger),
		.reset(_reset),
		.ALU__Selection(_selection),
		.CarryOut(CarryOut),
		.Zero(Zero),
		.Negative(Negative),
		.Overflow(Overflow),
		.ALU_Out(_Result)  //Requiere que la ALU tenga un output
	);
	
	
	initial begin
	
		//Case 1  Sum
		_selection = 4'b0000;
		A = 4'b1010;
		B = 4'b0111;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0000;
		A = 4'b1111;
		B = 4'b1111;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		
		//Case 2  _Resett
		_selection = 4'b0001;
		A = 4'b1010;
		B = 4'b0111;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0001;
		A = 4'b1110;
		B = 4'b0011;

		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		//Case 3  Mult
		_selection = 4'b0010;
		A = 4'b0010;
		B = 4'b0010;

		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0010;
		A = 4'b0011;
		B = 4'b0001;

		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		//Case 4  Div
		_selection = 4'b0011;
		A = 4'b0011;
		B = 4'b0011;

		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0011;
		A = 4'b0101;
		B = 4'b0011;

		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		//Case 5 - Modulo
		_selection = 4'b0100;
		A = 4'b0011;
		B = 4'b0011;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0100;
		A = 4'b0101;
		B = 4'b0011;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		//Case 6  AND
		_selection = 4'b0101;
		A = 4'b1010;
		B = 4'b0111;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0101;
		A = 4'b1110;
		B = 4'b0101;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		
		//Case 7  OR
		_selection = 4'b0110;
		A = 4'b1010;
		B = 4'b0111;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0110;
		A = 4'b1110;
		B = 4'b0101;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		
		//Case 8  XOR
		_selection = 4'b0111;
		A = 4'b1010;
		B = 4'b0111;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b0111;
		A = 4'b1110;
		B = 4'b0011;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
	
		//Case 9  Sft left
		_selection = 4'b1000;
		A = 4'b1010;
		B = 4'b0000;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b1000;
		A = 4'b0110;
		B = 4'b0000;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		
		//Case 10 - Sft Right
		_selection = 4'b1001;
		A = 4'b1010;
		B = 4'b0000;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		_selection = 4'b1001;
		A = 4'b1110;
		B = 4'b0000;
		
		_reset = 1'b0;
		_trigger = 1'b1;
		#40;
		_reset = 1'b1;
		_trigger = 1'b0;
		#40;
		
		end
    
endmodule
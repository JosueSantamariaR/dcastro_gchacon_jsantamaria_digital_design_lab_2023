module ALU #( parameter N = 4 ) (

	input [N-1:0] A, B, // ALU N-bit inputs
	input [3:0] ALU_selector, // ALU 3-bit selector
	input logic trigger,
	input logic reset,

	output CarryOut, // ALU carry out flag
	output Zero, // ALU zero out flag
	output Negative, // ALU Negative out flag
	output Overflow, // ALU overflow out flag
	
	output [6:0] display1, //Output display1
	output [6:0] display2, //Output display2

	output [3:0] oper,
	output [N-1:0] ALU_Out
	
);

	reg[3:0] oper_aux;
	reg[N-1:0] mult_aux;
	//reg[N-1:0] ALU_Out_AUX;
	
	
	wire[N-1:0] sum;
	wire[N-1:0] subs;
	wire[2*N-1:0] mult;
	wire[N-1:0] div;
	wire[N-1:0] mo;
	wire[N-1:0] and_;
	wire[N-1:0] or_;
	wire[N-1:0] xor_;
	wire[N-1:0] shift_l;
	wire[N-1:0] shift_r;
	
		
	Opcode opcode0 (ALU_selector[0], oper_aux[0]);
	Opcode opcode1 (ALU_selector[1], oper_aux[1]);
	Opcode opcode2 (ALU_selector[2], oper_aux[2]);
	Opcode opcode3 (ALU_selector[3], oper_aux[3]);
	
	Converter converter (oper_aux, oper);
	
	//For testbench change the ALU_selector to oper_aux for testbech and implementation in FPGA
	Multiplexor mux_1 (
		trigger, reset, sum, 
		subs, mult, div, mo, 
		and_, or_, xor_, shift_l, 
		shift_r, ALU_selector, ALU_Out,
		mult_aux); 


endmodule
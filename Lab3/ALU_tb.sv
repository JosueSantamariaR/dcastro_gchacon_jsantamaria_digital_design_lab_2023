module ALU_tb;
	
	
	parameter N = 4;
	
	// Inputs
	logic [N-1:0] a;
	logic [N-1:0] b;
	logic [3:0] select;
	
	logic [N-1:0] result;
	logic[6:0] led_disp;
	logic neg_flag;
	logic zero_flag;
	logic carry_flag;
	logic overflow_flag;

	
	
	
	
	ALU #(.N(N)) uut (
        .a(a),
        .b(b),
        .select(select),
        .result(result),
        .led_disp(led_disp),
        .neg_flag(neg_flag),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag)
    );
	 
initial begin
		a = 4'b1010;
		b = 4'b1010;
		select = 4'b0000;
		#100;
		
		
		
		end
endmodule

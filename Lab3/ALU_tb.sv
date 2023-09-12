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
	select = 4'b0110;//OR
		a = 4'b0101; 
		b = 4'b1001;
		#100;
/*
	select = 4'b0010;//MULTI
		a = 4'b1111; 
		b = 4'b0001;
		#100;



		select = 4'b0010;//MULTI
		a = 4'b0100; 
		b = 4'b0101;
		#100;
		
		select = 4'b0001;//RESTA
		a = 4'b0111; 
		b = 4'b0011;
		#100;
		
		select = 4'b0101;//AND
		a = 4'b1111; 
		b = 4'b0111;
		#100;
		
		select = 4'b0110;//OR
		a = 4'b0101; 
		b = 4'b1001;
		#100;
		
		select = 4'b0111;//XOR
		a = 4'b1101; 
		b = 4'b1111;
		#100;
	
		select = 4'b1000;//SLL
		a = 4'b1101; 
		b = 4'b0010;
		#100;
		
		select = 4'b1001;//SRL
		a = 4'b1011; 
		b = 4'b0011;
		#100;
		*/
		
		
		
		
		end
endmodule


module ALU

#( parameter N = 4 )
(
	input logic [N-1:0] a,
	input logic [N-1:0] b,
	input logic [3:0] select,
	
	output logic [N-1:0] result,
	output logic [6:0] led_disp,
	output logic neg_flag,
	output logic zero_flag,
	output logic carry_flag,
	output logic overflow_flag

);


	always @(a or b) begin
		
		logic [N-1:0] tempa;
		logic [N-1:0] tempb;
		static logic carry_in = 0;
		
		
		//Select the operation
		case (select)
		4'b0000: begin
						for (int i = 0; i < N; i = i + 1) begin
							tempa = a[i];
							tempb = b[i];
							
							result[i] = (~((~tempa & tempb) || (tempa & ~tempb)) & carry_in) 
							|| (((~tempa & tempb) || (tempa & ~tempb)) & ~carry_in);
							
							carry_in = (((~tempa & tempb) || (tempa & ~tempb)) & carry_in) || (tempa & tempb);				
							
						end
						carry_flag = carry_in;
		
		
					end
		4'b0001: led_disp = 7'b0000000; // Seleccionado 1
		4'b0010: led_disp = 7'b0000000; // Seleccionado 2
		4'b0011: led_disp = 7'b0000000; // Seleccionado 3
		4'b0100: led_disp = 7'b0000000; // Seleccionado 4
		4'b0101: led_disp = 7'b0000000; // Seleccionado 5
		4'b0110: led_disp = 7'b0000000; // Seleccionado 6
		4'b0111: led_disp = 7'b0000000; // Seleccionado 7
		default: led_disp = 7'b1010101; // Otro valor
		
		endcase		
		
	end

endmodule
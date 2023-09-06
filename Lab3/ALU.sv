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
		
		//Select the operation
		case (select)
		4'b0000: // Seleccionado 0
		4'b0001: // Seleccionado 1
		4'b0010: // Seleccionado 2
		4'b0011: // Seleccionado 3
		4'b0100: // Seleccionado 4
		4'b0101: // Seleccionado 5
		4'b0110: // Seleccionado 6
		4'b0111: // Seleccionado 7
		default: // Otro valor
		
		endcase		
		
	end

endmodule



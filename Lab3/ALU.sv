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
		logic [N-1:0] tempsll;
		logic A;
		logic B;
		logic C;
		logic D;
		static logic carry_in = 0;		
		carry_flag = 0;
		overflow_flag = 0;
		neg_flag = 0;
		zero_flag = 0;
		
		
		
		
		case (select)
		//Suma
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
		
		//Resta (a-b)
		4'b0001: begin
						logic [N-1:0] complemento_1;
						logic [N-1:0] complemento_2;
						carry_in = 0;
						for (int i = 0; i < N; i = i + 1) begin
							complemento_1[i] = ~b[i];
						end
						complemento_2 = complemento_1 + 1;
						
						//Suma de A con el complemento a 2 de B (complemento_2)
						for (int i = 0; i < N; i = i + 1) begin
							tempa = a[i];
							tempb = complemento_2[i];
							
							result[i] = (~((~tempa & tempb) || (tempa & ~tempb)) & carry_in) 
							|| (((~tempa & tempb) || (tempa & ~tempb)) & ~carry_in);
							
							carry_in = (((~tempa & tempb) || (tempa & ~tempb)) & carry_in) || (tempa & tempb);
							if(result[i] == 0)begin zero_flag=1;end
							else begin zero_flag = 0; end
						end	
						if(a < b )begin
									neg_flag = 1;
							end else begin
									neg_flag = 0;
							end
		
		end
		
		//Multiplicación
		4'b0010: begin
					static int temp_dec = 1;
					static int decimal_number = 0;
					static logic [N-1:0] bin_temp = '0;

					//Obtiene la representación decimal del array b
					for (int i = 0; i < N; i = i + 1) begin
					
						for(int j = 0; j < i ; j = j + 1)begin
							temp_dec = temp_dec * 2;
						end
						decimal_number = decimal_number + (b[i] * temp_dec);
						temp_dec = 1;
						
					end
					$display("El valor decimal en multi es: %d", decimal_number);
					
					
					for (int i = 0; i < decimal_number; i = i + 1)begin
						//
						
						for (int i = 0; i < N; i = i + 1) begin
							tempa = a[i];
							tempb = bin_temp[i];
							
							result[i] = (~((~tempa & tempb) || (tempa & ~tempb)) & carry_in)| | (((~tempa & tempb) || (tempa & ~tempb)) & ~carry_in);
							bin_temp[i] = result[i];
							
							carry_in = (((~tempa & tempb) || (tempa & ~tempb)) & carry_in) || (tempa & tempb);				
							
						end
						carry_flag = carry_in;
						
						
						
					end
					
				
					
					
					
		
		
		end
		
		//DIVISION
		4'b0011:led_disp = 7'b0000000; 
		
		//MODULO
		4'b0100: led_disp = 7'b0000000; 
		
		//AND
		4'b0101: begin
					for(int i = 0; i < N; i = i + 1)begin
						result[i] = a[i] & b[i];
					end
		end
		
		//OR
		4'b0110: begin
					for(int i = 0; i < N; i = i + 1)begin
						result[i] = a[i] | b[i];
					end
		end
		//XOR
		4'b0111: begin
					for(int i = 0; i < N; i = i + 1)begin
						result[i] = ((~a[i] & b[i]) | (a[i] & ~b[i]));
					end
		end
		
		//SLL
		4'b1000:begin
					static int temp = 0;
					
					
					for(int j = 0; j < N; j = j + 1)begin
						if (j < b) begin
							result[j] = 0;
						end else begin
							result[j] = a[temp];
							temp = temp + 1;
						end
					end
					
		end
		
		
		//SRL
		4'b1001: begin
					static int temp = 0;
					static int temp_dec = 1;
					static int decimal_number = 0;

					//Obtiene la representación decimal del array b
					for (int i = 0; i < N; i = i + 1) begin
					
						for(int j = 0; j < i ; j = j + 1)begin
							temp_dec = temp_dec * 2;
						end
						decimal_number = decimal_number + (b[i] * temp_dec);
						temp_dec = 1;
						
					end
					
					//$display("El valor decimal es: %d", decimal_number);	
					
					temp = N -  decimal_number;
					for(int j = 0; j < N; j = j + 1)begin
					
						if (j >= N-decimal_number) begin
							result[j] = 0;
						end else begin 
							result[j] = a[temp];
							temp = temp + 1;
						end
					end
					
		end
		endcase		
		//$display("RESULT ES: %d", result);
		A = result[3];
		B = result[2];
		C = result[1];
		D = result[0];

		led_disp[0] = ~A&~B&~C&D | ~A&B&~C&~D | A&~B&C&D | A&B&~C&D; 
		led_disp[1] = B&C&~D | A&C&D | A&B&~D | ~A&B&~C&D;
		led_disp[2] = A&B&~D | A&B&C | ~A&~B&C&~D; 
		led_disp[3] = ~B&~C&D | B&C&D | ~A&B&~C&~D | A&~B&C&~D; 
		led_disp[4] = ~A&D | ~B&~C&D | ~A&B&~C; 
		led_disp[5] = ~A&~B&D | ~A&~B&C | ~A&C&D | A&B&~C&D; 
		led_disp[6] = ~A&~B&~C | ~A&B&C&D | A&B&~C&~D; 
		end
		
		


endmodule



















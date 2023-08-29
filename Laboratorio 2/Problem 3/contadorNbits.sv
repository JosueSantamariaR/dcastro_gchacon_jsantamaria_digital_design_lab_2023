module contadorNbits 

#( parameter N = 6 ) 

(
	input logic clk,        
	input logic reset,        
	output reg[N-1:0] countdownOut,
	output logic [6:0] led2,
	output logic [6:0] led1
	
);
    
	 

	reg[N-1:0] countdown = (2**N)-1;   

	display_converter converter4led1(countdownOut[3], countdownOut[2], countdownOut[1], countdownOut[0], led1);
	display_converter converter4led2(1'b0, 1'b0, countdownOut[5], countdownOut[4], led2);
		
	always @(posedge clk or posedge reset) 
		begin
			if (reset) 
				begin     
					countdown = (2**N)-1;
					countdownOut = countdown;
				end
				
			else
				begin
					if (countdown == 0) 
						begin   
							countdown = (2**N)-1;
							countdownOut = countdown;
						end
					else 
						begin       
							countdown = countdown - 1;
							countdownOut = countdown;
						end
				end
		end
	
	

			

	
endmodule
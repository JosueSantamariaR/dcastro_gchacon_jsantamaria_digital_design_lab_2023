module FSM (
	input logic entrada,
	input logic clk,
	input logic rst,
	output logic test
);

 logic [2:0] state, next_state;
 logic test = 1;
 



// Actual state logic
  always_ff @(posedge clk or posedge rst)
	if(rst) state = 2'b000;
	else
		state = next_state;

  // Next state logic
  always_comb
  begin
    case(state)
		 // Estado 0
        2'b000: next_state = 2'b000;
		  
        // Estado 1
        2'b001: next_state = 2'b001;
		  
        // Estado 2
        2'b010: next_state = 2'b010;
		  
        // Estado 3
        2'b011: next_state = 2'b011;
		  
        // Estado 4
        2'b100: next_state = 2'b100;
		  
        // Estado 5
        2'b101: next_state = 2'b101;
		  
        // Estado 6
        2'b110: next_state = 2'b110;
		  
        // Estado 7
        2'b111: next_state = 2'b111;
		  
        default: next_state = 2'b000;
		  
    endcase
	
  end
  
  //Output Logic (To be able to use if and else
  always @(next_state) begin

		if(t0)begin
		test=0;
		$display("prueba");
		end else begin
		test=1;
		$display("OMG SIRVE EL ELSE");
		end
  
  
  end
  

  // Output logic just assigns 

//assign msj_f = msj;

endmodule
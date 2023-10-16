module busca_minas (
    input logic mov_rigth,
    input logic mov_left,
    input logic sel_flag,
    input logic sel,
    input wire clk,
    input wire rst,
    input logic [3:0] total_mines
);

logic [2:0] state, next_state;
logic bomb = 0;
logic win = 0;
logic mov = 0;
logic put_mine = 0;

reg [2:0] random_row;
reg [2:0] random_col;

/* 
typedef struct {
		bit mine;   
		bit revealed;
		bit[3:0] adjacent;
	} cell_t;
	
cell_t tablero_de_juego[8][8];
*/

RandomGenerator r_inst (
    .clk(clk),
    .rst(rst),
    .random_row(random_row),
    .random_column(random_col)
);

// Instanciar el módulo tablero
tablero tab_ins (
    .clk(clk),
    .rst(rst),
    .total_mines(total_mines),
    .put_mine(put_mine),
    .random_row(random_row),
    .random_col(random_col)
);
  	

// Actual state logic
  always_ff @(posedge clk or posedge rst)
	if(rst) state = 3'b000;
	else
		state = next_state;

  // Next state logic
  always_comb
  begin
    case(state)
			// Estado 0
        3'b000: if (mov) next_state = 3'b111;
               else if (sel_flag) next_state = 3'b110;
               else if (sel) next_state = 3'b001;
               else next_state = 3'b000;

        // Estado 1
        3'b001: if (bomb) next_state = 3'b011;  //Revisar si hay bomba o no
					else if(~bomb) next_state = 3'b010;
					else next_state = 3'b001;
					
        // Estado 2
        3'b010: if (win) next_state = 3'b101; //Revisar si se ganó o no
					else if(~win) next_state = 3'b100;
					else next_state = 3'b010;
		  
        // Estado 3
        3'b011: next_state = 3'b011; //Perdió y solo se sale con rst
		  
        // Estado 4
        3'b100: next_state = 3'b000; //Estado para continuar jugando cuando no hay victoria
		  
        // Estado 5
        3'b101: next_state = 3'b101; //Ganó, solo se sale con rst
		  
        // Estado 6
        3'b110: next_state = 3'b000;
		  
        // Estado 7
        3'b111: next_state = 3'b000;
		  
        default: next_state = 3'b000;
		  
    endcase
	
  end
  
  //Output Logic (To be able to use if and else)
  always @(next_state) begin
		/*
		if(test)begin
		test=0;
		$display("prueba");
		end else begin
		$display("OMG SIRVE EL ELSE");
		end
  */
  
  end
  

  // Output logic just assigns 

//assign msj_f = msj;

endmodule
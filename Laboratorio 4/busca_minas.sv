module busca_minas (
	 input logic mov,
    input logic mov_rigth,
    input logic mov_left,
    input logic sel_flag,
    input logic sel,
    input wire clk,
    input wire rst,
    input logic [3:0] total_mines
);

/*
,
	 output logic game_board_mine[8][8],
	 output logic game_board_revealed[8][8],
	 output int game_board_adjacent[8][8]

*/
int x = 0;
int y = 0;

logic [2:0] state, next_state;
logic bomb = 0;
logic win = 0;

reg [2:0] random_row;
reg [2:0] random_col;

logic game_board_mine[8][8];
logic game_board_revealed[8][8];
int game_board_adjacent[8][8];


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
    .random_row(random_row),
    .random_col(random_col),
	 .game_board_mine(game_board_mine),
	 .game_board_revealed(game_board_revealed),
	 .game_board_adjacent(game_board_adjacent)
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
   
  always @(mov_rigth or mov_left)begin
  $display("HAY MOVIMIENTO"); 
	if(mov_rigth)begin
		if(x == 7)begin
			x = 0;
			$display("posicion en x es: %0d", x);
		end else begin
			x = x + 1;
			$display("posicion en x es: %0d", x);
		end
	end
	if(mov_left)begin
		if(y == 7)begin
			y = 0;
			$display("posicion en y es: %0d", y);
		end else begin
			y = y + 1;
			$display("posicion en y es: %0d", y);
		end
	
	end
  end
endmodule 
/*
  always @(next_state) begin
	//printing the matrix
	$display("ya esta el maldito tablero en la fsm!");
			for (int row = 0; row < 8; row = row + 1) begin
				for (int col = 0; col < 8; col = col + 1) begin
					$display("matrix[%0d][%0d]", row, col);
					$display(game_board_mine[row][col]);
				end
			end
  end
  */
  // Output logic just assigns 

//assign msj_f = msj;


module busca_minas (
    input logic mov_right,
    input logic mov_down,
    input logic sel_flag,
    input logic sel,
    input wire clk,
    input wire rst,
    input logic [5:0] total_mines,
	 output logic gameover
);


int columna = 0;
int fila = 0;

logic [2:0] state, next_state;
int cont = 0;
int toWin = 0;

reg [2:0] random_row;
reg [2:0] random_col;

logic game_board_mine[8][8];
logic game_board_revealed[8][8];
int game_board_adjacent[8][8];


// Instanciar el random

RandomGenerator r_inst (
    .clk(clk),
    .rst(rst),
    .random_row(random_row),
    .random_column(random_col)
);


calcWin calcwin_inst (
	.toWin(toWin),
	.total_mines(total_mines));

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
        3'b000:	if (sel) next_state = 3'b001;
						else next_state = 3'b000;

        // Estado 1
        3'b001: if (game_board_mine[fila][columna]) next_state = 3'b011;  //Revisa bomba y pierde
					else next_state = 3'b010; //Revisa bomba y sigue
					
        // Estado 2
        3'b010: if (cont==toWin) next_state = 3'b101; //Revisar si se ganó o no
					else next_state = 3'b100;
		  
        // Estado 3
        3'b011: next_state = 3'b011; //Perdió y solo se sale con rst
		  
        // Estado 4
        3'b100: next_state = 3'b000; //Estado para continuar jugando cuando no hay victoria
		  
        // Estado 5
        3'b101: next_state = 3'b101; //Ganó, solo se sale con rst
		  

        default: next_state = 3'b000;
		  
    endcase
	
  end
  
  //Output Logic (To be able to use if and else)
   
  always @(mov_right or mov_down)begin
	if(~mov_right)begin
		if(columna == 7)begin
			columna = 0;
		end else begin
			columna = columna + 1;
		end
	end
	if(~mov_down)begin
		if(fila == 7)begin
			fila = 0;
		end else begin
			fila = fila + 1;
		end
	 
	end
	$display("HAY MOVIMIENTO pos fila: %0d, columna: %0d",fila, columna);  
  end
 

  always @(next_state) begin
	$display("El estado es: %0d", next_state);
	//$display(sel);
	
	//---------------------------------
	/*
	$display("Game Board Mines:");
    for (int i = 0; i < 8; i = i + 1) begin
      for (int j = 0; j < 8; j = j + 1) begin
        $display("%0d ", game_board_mine[i][j]);
      end
      $display(""); // Nueva línea después de cada fila
    end
	*/
	//---------------------------------
	
	
	if (next_state == 1) begin
		cont = cont +1;
		//$display(toWin);
		$display("hubo seleccion en la pos fila: %0d, columna: %0d", fila,columna); 
	end
	
	if (next_state == 3) begin
		gameover = 1;
		$display("Perdiste");
	end else begin
		gameover=0;
	end
		
	
	if(next_state == 2)begin
		$display("estado 2");
	end
		
	
  end
  
  
  endmodule

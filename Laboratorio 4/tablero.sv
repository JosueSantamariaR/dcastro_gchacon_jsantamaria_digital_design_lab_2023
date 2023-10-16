module tablero(
	input wire clk,       
   input wire rst,      
	input logic [3:0] total_mines,
	input logic put_mine,
	output reg [2:0] random_row, 
	output reg [2:0] random_col
    );
	 
	 int contador = 0;
	 
	 
	RandomGenerator r_inst (
		.clk(clk),
		.rst(rst),
		.random_row(random_row),
		.random_column(random_col)
	);
	 
	typedef struct {
		bit mine;   
		bit revealed;
		bit[3:0] adjacent;
	} cell_t;

	cell_t game_board[8][8];
	
	initial begin
		for (int i = 0; i < 8; i++) begin
			for (int j = 0; j < 8; j++) begin
				game_board[i][j].mine = 0;
				game_board[i][j].revealed = 0;
				game_board[i][j].adjacent = 0;
			end
		end
		$display("INICIO TERMINADO"); 
	end
	 
	 
	 always @(posedge clk) begin
		$display("entró al posedge clk");
		if(contador < total_mines) begin
			if (!game_board[random_row][random_col].mine && random_row >= 0) begin
				game_board[random_row][random_col].mine = 1;
				$display("mina colocada en fila: %0d columna: %0d",random_row, random_col);
				contador = contador +1;
			end
		end
		
		
		
	 end
	 
	
		
	 
	 
	 
	/* 
	 
	always @(negedge clk) begin
	#100;
	$display(random_row);
	$display(random_col);
	if(contador < total_mines) begin
			if (!game_board[random_row][random_col].mine) begin
				game_board[random_row][random_col].mine = 1;
				$display("mina colocada en fila: %0d columna: %0d",random_row, random_col);
				contador = contador +1;
			end
		end
	end
	*/
	

	
	function void calc_board;
		for (int i = 0; i < 8; i++) begin
			for (int j = 0; j < 8; j++) begin
				if (!game_board[i][j].mine) begin
					automatic int adjacent_mines = 0;
					for (int x = -1; x <= 1; x++) begin
						for (int y = -1; y <= 1; y++) begin
							if (i + x >= 0 && i + x < 8 && j + y >= 0 && j + y < 8) begin
								adjacent_mines += game_board[i + x][j + y].mine;
							end
						end
					end
					game_board[i][j].adjacent = adjacent_mines;
				end
			end
		end
		for (int row = 0; row < 8; row = row + 1) begin
			for (int col = 0; col < 8; col = col + 1) begin
                    $display("matrix[%0d][%0d]", row, col);
						  $display(game_board[row][col].adjacent);
			end
		end

	endfunction

endmodule

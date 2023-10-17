module tablero(
	input wire clk,       
   input wire rst,      
	input logic [5:0] total_mines,
	input reg [2:0] random_row, 
	input reg [2:0] random_col,
	output logic game_board_mine[8][8],
	output logic game_board_revealed[8][8],
	output int game_board_adjacent[8][8]
);
	 
	int contador = 0;
	//int temporal = 0;
	logic calcular_ad = 0;

	reg total_mine_changed = 0;
	reg prev_total_mines = 0;
	 
	
	initial begin
		prev_total_mines = total_mines;
		$display("AAAAAAAAAAA:");
		$display(prev_total_mines);
		for (int i = 0; i < 8; i++) begin
			for (int j = 0; j < 8; j++) begin
				game_board_mine[i][j] = 0; 
				game_board_revealed[i][j] = 0;
				game_board_adjacent[i][j] = 0;
			end
		end
		$display("tablero en blanco!!!!!!!!!!!!!!!!!");
		//$display(total_mines); 
	end
	
	 
	 always @(posedge clk) begin
		//verficar si totalmines ha cambiado
		
		if (total_mines != prev_total_mines && prev_total_mines >= 0 && total_mines >= 0) begin
			$display("las minas cambiaroooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooon");
			total_mine_changed = 1;
			prev_total_mines = total_mines;
		end
	
	
		//colocar las minas
		if(contador < total_mines) begin
			if (!game_board_mine[random_row][random_col] && random_row >= 0) begin
				game_board_mine[random_row][random_col] = 1;
				$display("mina colocada en fila: %0d columna: %0d",random_row, random_col);
				contador = contador +1;
			end
		end
		//calcular ads
		if(contador == (total_mines) && ~calcular_ad)begin
			$display("nos fuimos a calcular!");
			calcular_ad = 1;		
		end
		
		//cuando hay cambio de minas para recalcular el tablero
		if(total_mine_changed) begin
			for (int i = 0; i < 8; i++) begin
				for (int j = 0; j < 8; j++) begin
					game_board_mine[i][j] = 0; 
					game_board_revealed[i][j] = 0;
					game_board_adjacent[i][j] = 0;
				end
			end
			$display("tablero en blanco");
			$display("cambiaron las total mines");
			contador = 0;
			calcular_ad = 0;
			total_mine_changed = 0;
		end
		
		//calculo de adyacentes
		
		if(calcular_ad) begin
			$display("calculando adyacencias");
			for (int i = 0; i < 8; i++) begin
				for (int j = 0; j < 8; j++) begin
					if (!game_board_mine[i][j]) begin
						automatic int adjacent_mines = 0;
						for (int x = -1; x <= 1; x++) begin
							for (int y = -1; y <= 1; y++) begin
								if (i + x >= 0 && i + x < 8 && j + y >= 0 && j + y < 8) begin
									adjacent_mines += game_board_mine[i + x][j + y];
								end
							end
						end
						game_board_adjacent[i][j] = adjacent_mines;
					end
				end
			end
			
			$display("adyacencias calculadas");
			calcular_ad = 0;
			contador = contador + 1;
			end
	 end

endmodule
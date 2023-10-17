module busca_minas_tb;
	logic mov_right = 1;
	logic mov_down = 1;
	logic sel_flag = 0;
	logic sel = 0;
	reg clk;
	reg rst;
	logic [5:0] total_mines;
	logic gameover;
	 
	busca_minas busca_minas_inst (
    .mov_right(mov_right),
	 .mov_down(mov_down),
	 
    .sel_flag(sel_flag),
    .sel(sel),
    .clk(clk),
    .rst(rst),
    .total_mines(total_mines),
	 .gameover(gameover) 
);
  // Generación de señal de reloj
  always #15 clk = ~clk;

  // Inicialización de señales
  initial begin
	total_mines = 6'b000101;
    clk = 0;
    rst = 0;

    // Ciclo de reinicio
    rst = 1;
    #10 rst = 0;

    // Espera un tiempo para observar la secuencia de números aleatorios generada
    #150;
		mov_right = 0;
		#10;
		mov_right = 1;
		#10;
		mov_right = 0;
		#10;
		mov_right = 1;
		#10;
		mov_right = 0;
		#10;
		mov_right = 1;
		#10;
		sel = 1;
		#10;
		sel=0;
  end
endmodule


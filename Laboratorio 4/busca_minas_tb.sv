module busca_minas_tb;
	logic mov_right = 0;
	logic mov_down = 0;
	logic sel_flag = 0;
	logic sel = 0;
	reg clk;
	reg rst;
	logic [5:0] total_mines;
	 
	busca_minas busca_minas_inst (
    .mov_right(mov_right),
	 .mov_down(mov_down),
    .sel_flag(sel_flag),
    .sel(sel),
    .clk(clk),
    .rst(rst),
    .total_mines(total_mines)
);
  // Generación de señal de reloj
  always #15 clk = ~clk;

  // Inicialización de señales
  initial begin
	total_mines = 5;
    clk = 0;
    rst = 0;
    
     
    // Ciclo de reinicio (opcional)
    rst = 1;
    #10 rst = 0;

    // Espera un tiempo para observar la secuencia de números aleatorios generada
    #150;
	 $display("-------------------------------------------------------------------------------");
	 #10;
		mov_right = 0;
		#10;
		mov_down = 0;
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
		mov_right = 0;
		#10;
		sel = 1;
		#10;
		sel=0;
		
	 /*
	 total_mines = 5;
    #150;
	 $display("-------------------------------------------------------------------------------");
	 mov=1;
	 #100;
	 mov=0;
	 //total_mines=10;
	 */
  end

  // Puedes agregar más tareas o funciones de prueba aquí

endmodule


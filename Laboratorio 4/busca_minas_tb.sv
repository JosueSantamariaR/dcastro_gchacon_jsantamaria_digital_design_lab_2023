module busca_minas_tb;

	logic mov_rigth = 0;
	logic mov_left = 0;
	logic sel_flag = 0;
	logic sel = 0;
	reg clk;
	reg rst;
	logic [3:0] total_mines;
	
	
	busca_minas busca_minas_inst (
    .mov_rigth(mov_rigth),
	 .mov_left(mov_left),
    .sel_flag(sel_flag),
    .sel(sel),
    .clk(clk),
    .rst(rst),
    .total_mines(total_mines)
);
  // Generación de señal de reloj
  always #5 clk = ~clk;

  // Inicialización de señales
  initial begin
	total_mines = 5;
    clk = 0;
    rst = 0;
    
     
    // Ciclo de reinicio (opcional)
    rst = 1;
    #10 rst = 0;

    // Espera un tiempo para observar la secuencia de números aleatorios generada
    #100;
	 $display("-------------------------------------------------------------------------------");
    total_mines=10;
  end

  // Puedes agregar más tareas o funciones de prueba aquí

endmodule
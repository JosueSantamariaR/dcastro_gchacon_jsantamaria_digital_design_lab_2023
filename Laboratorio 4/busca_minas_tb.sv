module busca_minas_tb;

	logic mov = 0;
	logic sel_flag = 0;
	logic sel = 0;
	reg clk;
	reg rst;
	logic [3:0] total_mines;
	reg [2:0] random_row;
	reg [2:0] random_col;
	
	
	busca_minas busca_minas_inst (
    .mov(mov),
    .sel_flag(sel_flag),
    .sel(sel),
    .clk(clk),
    .rst(rst),
    .total_mines(total_mines),
    .random_row(random_row),
    .random_col(random_col)
);


  // Generación de señal de reloj
  always #5 clk = ~clk;

  // Inicialización de señales
  initial begin
    clk = 0;
    rst = 0;
    total_mines = 5;
    
    // Ciclo de reinicio (opcional)
    rst = 1;
    #10 rst = 0;

    // Espera un tiempo para observar la secuencia de números aleatorios generada
    #100;
	 $display("------------------------------------------cambio de tablero-------------------");
	 //total_mines = 10; 
    
	 
    
    // Simulación de la inicialización del tablero
    //
	 
    // Simulación de la colocación de minas en el tablero
    
    // Terminar la simulación
    //$finish;
  end

  // Puedes agregar más tareas o funciones de prueba aquí

endmodule

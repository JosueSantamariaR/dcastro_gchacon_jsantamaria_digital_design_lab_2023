module RandomGenerator(
  input wire clk,     // Señal de reloj
  input wire rst,     // Señal de reinicio
  output reg [2:0] random_row,   // Variable para la fila aleatoria (0-7)
  output reg [2:0] random_column // Variable para la columna aleatoria (0-7)
);

  reg [15:0] lfsr_row; // LFSR para la fila
  reg [15:0] lfsr_column; // LFSR para la columna

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      lfsr_row = 16'hACE1; // Semilla inicial para la fila (puedes cambiarla)
      lfsr_column = 16'hBEEF; // Semilla inicial para la columna (puedes cambiarla)
    end else begin
      // LFSR de 16 bits con retroalimentación XOR para la fila
      lfsr_row = {lfsr_row[0] ^ lfsr_row[2], lfsr_row[15:1]}; 

      // LFSR de 16 bits con retroalimentación XOR para la columna
      lfsr_column = {lfsr_column[0] ^ lfsr_column[3], lfsr_column[15:1]}; 

      // Generar números pseudoaleatorios en el rango 0-7
      random_row = lfsr_row[2:0];
      random_column = lfsr_column[2:0];
    end
  end

endmodule

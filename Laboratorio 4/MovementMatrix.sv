module movementMatrix(
  input logic clk, // Reloj
  input logic reset, // Reinicio
  input logic [1:0] direction, // Dirección de movimiento (00: Quieto, 01: Abajo, 10: Derecha, 11: Izquierda)
  output logic [3:0] position_x, // Posición X del cuadro negro
  output logic [3:0] position_y // Posición Y del cuadro negro
);

  // Parámetros de tamaño del tablero
  parameter NUM_COLUMNS = 8;
  parameter NUM_ROWS = 8;

  // Parámetros de velocidad de movimiento
  parameter MOVE_DELAY = 25000; // Ajusta según la velocidad deseada

  // Variables de posición horizontal y vertical
  logic [3:0] pos_x;
  logic [3:0] pos_y;
  logic [15:0] move_counter;

  // Inicialización
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      pos_x <= 4'b0000;
      pos_y <= 4'b0000;
      move_counter <= 16'b0;
    end else if (move_counter == MOVE_DELAY) begin
      // Actualiza la posición según la dirección
      case (direction)
        2'b01: pos_y <= (pos_y == 4'b0111) ? 4'b0000 : pos_y + 1; // Abajo
        2'b10: pos_x <= (pos_x == 4'b0111) ? 4'b0000 : pos_x + 1; // Derecha
        2'b11: pos_x <= (pos_x == 4'b0000) ? 4'b0111 : pos_x - 1; // Izquierda
        // Para otras direcciones o sin movimiento, no cambia la posición
      endcase
      move_counter <= 16'b0;
    end else begin
      move_counter <= move_counter + 1;
    end
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      position_x <= 4'b0000;
      position_y <= 4'b0000;
    end else begin
      position_x <= pos_x;
      position_y <= pos_y;
    end
  end
endmodule

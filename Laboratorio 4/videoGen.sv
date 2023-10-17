module videoGen(
  input logic [9:0] x,
  input logic [9:0] y,
  input logic btn_down, // Botón para mover hacia abajo
  input logic btn_right, // Botón para cambiar de columna hacia la derecha
  input logic btn_select, // Botón para cambiar de columna hacia la derecha
  output logic [7:0] red,
  output logic [7:0] green,
	  output logic [7:0] blue
  
);

  // Tamaño del tablero y colores
  parameter NUM_COLUMNS = 8;
  parameter NUM_ROWS = 8;
  logic [7:0] background_color = 8'b11111111; // Blanco
  logic [7:0] line_color = 8'b00000000; // Negro
  logic [7:0] fill_color = 8'b10101010; // Gris en formato binario

  // Tamaño de la pantalla
  parameter SCREEN_WIDTH = 637;
  parameter SCREEN_HEIGHT = 477;

  // Tamaño de cada casilla en el tablero
  parameter CELL_WIDTH = SCREEN_WIDTH / NUM_COLUMNS;
  parameter CELL_HEIGHT = SCREEN_HEIGHT / NUM_ROWS;

  // Calcula las coordenadas relativas al tablero centrado
  int rel_x;
  int rel_y;

  // Variables para controlar la posición vertical y horizontal del cuadro negro
  int black_box_position = 0;
  int black_box_row = 0;

  // Variables para controlar la casilla seleccionada
  int selected_row = 0;
  int selected_column = 0;

  always_ff @(posedge btn_down) begin
    // Al presionar el botón de mover hacia abajo, aumenta la posición vertical del cuadro negro
    black_box_position <= black_box_position + 1;
    // Verifica si el cuadro negro ha llegado al final de la fila
    if (black_box_position >= NUM_ROWS - 1 ) begin
      // Reinicia la posición vertical a 0
      black_box_position <= 0;
    end
  end

  always_ff @(posedge btn_right) begin
    // Al presionar el botón de mover hacia la derecha, aumenta la posición horizontal del cuadro negro
    black_box_row <= black_box_row + 1;
    // Verifica si el cuadro negro ha llegado al final de la columna
    if (black_box_row >= NUM_COLUMNS - 1 ) begin
      // Reinicia la posición horizontal a 0
      black_box_row <= 0;
    end
  end

  always_ff @(posedge btn_select) begin
    // Al presionar el botón de seleccionar, actualiza la casilla seleccionada
    selected_row <= black_box_position;
    selected_column <= black_box_row;
  end

  always_comb begin
    // Calcula las coordenadas relativas al tablero centrado
    rel_x = x - (SCREEN_WIDTH - (NUM_COLUMNS * CELL_WIDTH)) / 2;
    rel_y = y - (SCREEN_HEIGHT - (NUM_ROWS * CELL_HEIGHT)) / 2;

    // Dibuja líneas negras alrededor de cada casilla
    if ((rel_x % CELL_WIDTH < 2) || (rel_y % CELL_HEIGHT < 2) ||
        (rel_x % CELL_WIDTH >= CELL_WIDTH - 2) || (rel_y % CELL_HEIGHT >= CELL_HEIGHT - 2)) begin
      red = line_color;
      green = line_color;
      blue = line_color;
    end else begin
      // Rellena cada casilla con el color gris en formato binario
      red = fill_color;
      green = fill_color;
      blue = fill_color;
    end

    // Si estamos fuera de las casillas, pinta el fondo blanco
    if (rel_x < 0 || rel_x >= CELL_WIDTH * NUM_COLUMNS || rel_y < 0 || rel_y >= CELL_HEIGHT * NUM_ROWS) begin
      red = background_color;
      green = background_color;
      blue = background_color;
    end

    // Agrega un cuadro negro que se mueve hacia abajo en la fila deseada
    if (rel_x >= black_box_row * CELL_WIDTH && rel_x < (black_box_row + 1) * CELL_WIDTH &&
        rel_y >= black_box_position * CELL_HEIGHT && rel_y < (black_box_position + 1) * CELL_HEIGHT) begin
      red = 8'b00000000; // Negro
      green = 8'b00000000; // Negro
      blue = 8'b00000000; // Negro
    end

     // Pinta la casilla seleccionada de verde
  if (rel_x >= selected_column * CELL_WIDTH && rel_x < (selected_column + 1) * CELL_WIDTH &&
      rel_y >= selected_row * CELL_HEIGHT && rel_y < (selected_row + 1) * CELL_HEIGHT) begin
    green = 8'b00100000; // Verde en formato binario
  end
  end
endmodule

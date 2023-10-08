module vgaController #(
  parameter HACTIVE = 640,
  parameter HFP = 16,
  parameter HSYN = 96,
  parameter HBP = 48,
  parameter HMAX = HACTIVE + HFP + HSYN + HBP,
  parameter VBP = 32,
  parameter VACTIVE = 480,
  parameter VFP = 11,
  parameter VSYN = 2,
  parameter VMAX = VACTIVE + VFP + VSYN + VBP
)(
  input logic vgaclk,
  output logic hsync, vsync, sync_b, blank_b,
  output logic [9:0] x, y
);

  logic [9:0] hcnt = 0;
  logic [9:0] vcnt = 0;

  always_ff @(posedge vgaclk) begin
    if (hcnt == HMAX - 1) begin
      hcnt <= 0;
      if (vcnt == VMAX - 1) begin
        vcnt <= 0;
      end else begin
        vcnt <= vcnt + 1;
      end
    end else begin
      hcnt <= hcnt + 1;
    end
  end

  // Compute sync signals (active low)
  assign hsync = ~(hcnt >= HACTIVE + HFP && hcnt < HACTIVE + HFP + HSYN);
  assign vsync = ~(vcnt >= VACTIVE + VFP && vcnt < VACTIVE + VFP + VSYN);
  assign sync_b = hsync & vsync;

  // Force outputs to black when outside the legal display area
  assign blank_b = (hcnt < HACTIVE) && (vcnt < VACTIVE);

  // Output x and y coordinates
  assign x = hcnt;
  assign y = vcnt;

endmodule

module videoGen(
  input logic [9:0] x,
  input logic [9:0] y,
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

  always_comb begin
    // Calcula las coordenadas relativas al tablero centrado
    rel_x = x - (SCREEN_WIDTH - (NUM_COLUMNS * CELL_WIDTH)) / 2;
    rel_y = y - (SCREEN_HEIGHT - (NUM_ROWS * CELL_HEIGHT)) / 2;

    // Agrega un borde gris oscuro en la parte superior
    if (rel_y == 0 && (rel_x % CELL_WIDTH >= 2) && (rel_x % CELL_WIDTH < CELL_WIDTH - 2)) begin
      red = 8'b11110000; // Gris oscuro en formato binario
      green = 8'b11110000; // Gris oscuro en formato binario
      blue = 8'b11110000; // Gris oscuro en formato binario
    end else begin
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
    end
  end

endmodule
module MovimientoCuadro(
  input logic clock, // Reloj de la FPGA
  input logic reset, key0, key1, key2, key3, // Señal de reinicio
  input logic [9:0] x, // Posición actual en X
  input logic [9:0] y, // Posición actual en Y
  output logic [9:0] new_x, // Nueva posición en X
  output logic [9:0] new_y, // Nueva posición en Y
  output logic [7:0] cuadro_color // Color del cuadro (blanco)
);

  // Parámetros de la matriz y del cuadro
  parameter MATRIX_WIDTH = 8; // Ancho de la matriz
  parameter MATRIX_HEIGHT = 8; // Alto de la matriz
  parameter CUADRO_SIZE = 50; // Tamaño del cuadro (ancho y alto) en píxeles
  parameter LINE_WIDTH = 2; // Ancho de las líneas negras
  parameter FILL_COLOR = 8'b10101010; // Color de fondo de las casillas (gris)

  // Registros para almacenar la posición actual del cuadro
  logic [9:0] cuadro_x;
  logic [9:0] cuadro_y;

  always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
      cuadro_x <= 0; // Inicializa la posición en X del cuadro a 0
      cuadro_y <= 0; // Inicializa la posición en Y del cuadro a 0
    end else begin
      // Actualiza la posición del cuadro en función de los botones de control
      if (key0 && cuadro_y < (MATRIX_HEIGHT - 1) * CUADRO_SIZE) // Mover hacia abajo
        cuadro_y <= cuadro_y + CUADRO_SIZE;
      else if (key1 && cuadro_y > 0) // Mover hacia arriba
        cuadro_y <= cuadro_y - CUADRO_SIZE;
      else if (key2 && cuadro_x < (MATRIX_WIDTH - 1) * CUADRO_SIZE) // Mover hacia la derecha
        cuadro_x <= cuadro_x + CUADRO_SIZE;
      else if (key3 && cuadro_x > 0) // Mover hacia la izquierda
        cuadro_x <= cuadro_x - CUADRO_SIZE;
    end
  end

  // Salida de las nuevas coordenadas del cuadro y el color del cuadro (blanco)
  assign new_x = cuadro_x;
  assign new_y = cuadro_y;
  assign cuadro_color = 8'b11111111; // Color blanco

endmodule


module vga(
  input logic clk, key0, key1, key2, key3,
  output logic vgaclk, // 25.175 MHz VGA clock
  output logic hsync, vsync,
  output logic sync_b, blank_b,
  output reg [7:0] red, green, blue // Cambiamos las salidas a registros (reg)
);

  logic [9:0] x, y, posx, posy, x1, y1;
  logic [7:0] red_output, green_output, blue_output; // Salidas de color temporales

  assign x1=x;
  assign y1=y;

  // Use a PLL to create the 25.175 MHz VGA pixel clock (Insert the code for PLL instantiation here)
  ClockDivider divider (
    .clk(clk),
    .vgaclk(vgaclk)
  );

  vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);

  // Conexión del módulo de movimiento del cuadro
  MovimientoCuadro movimiento_cuadro (
    .clock(clk),
    .reset(!blank_b), // Reiniciar en cada nuevo cuadro
    .x(x), // Cambia x por la coordenada actual x
    .y(y), // Cambia y por la coordenada actual y
    .new_x(posx), // Salida de la nueva posición en X
    .new_y(posy)  // Salida de la nueva posición en Y
  );
 
  
  NumerosBuscaminas numeros_busca_minas (
    .x(x1),
    .y(y1),
    .numero(3'b001), // Ejemplo: Muestra el número 1 en la casilla actual
   .red(red_output), // Salida temporal de color rojo
    .green(green_output), // Salida temporal de color verde
    .blue(blue_output) // Salida temporal de color azul
  );

 
  videoGen videogen(x, y, red, green, blue);

endmodule




module VGA_Controller (
  input logic clk_50MHz,    // Frecuencia de reloj de 50 MHz
  output logic hsync_n,     // Sincronización horizontal (negada)
  output logic vsync_n,     // Sincronización vertical (negada)
  output logic blank_n,     // Señal BLANK (negada)
  output logic [7:0] red,   // Componente de color rojo
  output logic [7:0] green, // Componente de color verde
  output logic [7:0] blue,  // Componente de color azul
  output logic [3:0] xpos,  // Posición horizontal actual
  output logic [3:0] ypos   // Posición vertical actual
);

  // Módulo del divisor de frecuencia
  logic clk_vga; // Salida del divisor

  ClockDivider divider (
    .clk_50MHz(clk_50MHz),
    .clk_vga(clk_vga)
  );

  // Parámetros de resolución VGA
  localparam H_SYNC_CYCLES = 96;
  localparam H_BACK_PORCH = 48;
  localparam H_ACTIVE_VIDEO = 640;
  localparam H_FRONT_PORCH = 16;
  localparam H_TOTAL = 800;

  localparam V_SYNC_CYCLES = 2;
  localparam V_BACK_PORCH = 33;
  localparam V_ACTIVE_VIDEO = 480;
  localparam V_FRONT_PORCH = 10;
  localparam V_TOTAL = 525;

  reg [10:0] h_counter = 0;
  reg [10:0] v_counter = 0;

  always @(posedge clk_vga) begin
    if (h_counter == H_TOTAL-1) begin
      h_counter <= 0;
      if (v_counter == V_TOTAL-1) begin
        v_counter <= 0;
      end else begin
        v_counter <= v_counter + 1;
      end
    end else begin
      h_counter <= h_counter + 1;
    end
  end

  assign hsync_n = ~(h_counter < H_SYNC_CYCLES);
  assign vsync_n = ~(v_counter < V_SYNC_CYCLES);
  assign blank_n = ~(h_counter < H_ACTIVE_VIDEO) || ~(v_counter < V_ACTIVE_VIDEO);

  always @(posedge clk_vga) begin
    if (~blank_n) begin
      red <= 8'b00000000;
      green <= 8'b00000000;
      blue <= 8'b00000000;
    end else begin
      // Genera rayas de colores
      if (h_counter[8] == 1) begin
        red <= 8'b11111111;
        green <= 8'b00000000;
        blue <= 8'b00000000;
      end else begin
        red <= 8'b00000000;
        green <= 8'b00000000;
        blue <= 8'b11111111;
      end
    end
  end

  assign xpos = h_counter[9:6];
  assign ypos = v_counter[9:6];

endmodule


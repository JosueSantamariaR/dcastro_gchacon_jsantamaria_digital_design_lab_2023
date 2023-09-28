module VGA_Controller (
  input wire clk,        // Frecuencia de reloj del sistema
  output wire hsync,     // Sincronización horizontal
  output wire vsync,     // Sincronización vertical
  output wire [9:0] rgb, // Señal de color RGB de 10 bits (3 bits R, 3 bits G, 3 bits B, 1 bit de sincronización)
  output wire [3:0] xpos, // Posición horizontal actual
  output wire [3:0] ypos  // Posición vertical actual
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

  always @(posedge clk) begin
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

  assign hsync = (h_counter < H_SYNC_CYCLES);
  assign vsync = (v_counter < V_SYNC_CYCLES);

  always @(posedge clk) begin
    if (hsync || vsync) begin
      rgb <= 10'b000_000_0000; // Color negro durante los pulsos de sincronización
    end else begin
      // Genera un patrón de colores simple (cambia según la posición)
      rgb <= {h_counter[9:7], v_counter[9:7], h_counter[9:7] & v_counter[9:7]};
    end
  end

  assign xpos = h_counter[9:6];
  assign ypos = v_counter[9:6];

endmodule

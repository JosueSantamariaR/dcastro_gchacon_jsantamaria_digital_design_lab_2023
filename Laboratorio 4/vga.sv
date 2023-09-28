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

  // Tamaño del texto y posición
  parameter TEXT_WIDTH = 160;
  parameter TEXT_HEIGHT = 40;
  parameter TEXT_X = (640 - TEXT_WIDTH) / 2;
  parameter TEXT_Y = (480 - TEXT_HEIGHT) / 2;

  // Colores
  logic [7:0] background_color = 8'b00000000; // Negro
  logic [7:0] text_color = 8'b11111111; // Blanco

  always_comb begin
    // Fondo negro
    if (x >= TEXT_X && x < TEXT_X + TEXT_WIDTH &&
        y >= TEXT_Y && y < TEXT_Y + TEXT_HEIGHT) begin
      red = text_color;
      green = text_color;
      blue = text_color;
    end else begin
      red = background_color;
      green = background_color;
      blue = background_color;
    end
  end

endmodule

module vga(
  input logic clk,
  output logic vgaclk, // 25.175 MHz VGA clock
  output logic hsync, vsync,
  output logic sync_b, blank_b,
  output logic [7:0] red, green, blue
);

  logic [9:0] x, y;

  // Use a PLL to create the 25.175 MHz VGA pixel clock (Insert the code for PLL instantiation here)
  ClockDivider divider (
    .clk(clk),
    .vgaclk(vgaclk)
  );

  vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);
  videoGen videoGen(x, y, red, green, blue);

endmodule



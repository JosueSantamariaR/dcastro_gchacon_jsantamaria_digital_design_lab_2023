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
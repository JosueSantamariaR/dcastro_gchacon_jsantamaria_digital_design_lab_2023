module minesweeper(
  input logic clk, btn0, btn1,btn2, sel_flag,
  input wire rst,
  input logic [5:0] total_mines,
  output logic vgaclk, gameoverdisp, // 25.175 MHz VGA clock
  output logic hsync, vsync,
  output logic sync_b, blank_b,
  output reg [7:0] red, green, blue
    
);

  logic [9:0] x, y, posx, posy, x1, y1;
  // Use a PLL to create the 25.175 MHz VGA pixel clock (Insert the code for PLL instantiation here)
  ClockDivider divider (
    .clk(clk),
    .vgaclk(vgaclk)
  );
  
  busca_minas busca_minas_inst (
    .mov_right(btn1),
	 .mov_down(btn0),
    .sel_flag(sel_flag),
    .sel(btn2),
    .clk(vgaclk),
    .rst(rst),
    .total_mines(total_mines),
	 .gameover(gameoverdisp)
);
  vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);
  videoGen videogen(x, y, btn0,btn1,btn2, red, green, blue);

endmodule




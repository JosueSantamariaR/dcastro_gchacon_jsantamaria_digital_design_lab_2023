module VGA_Controller(
    input logic clk,
    input logic reset,
    input logic [7:0] pixel,   // Valor de gris para el píxel actual
    input logic enabled,
    output reg vga_hsync,
    output reg vga_vsync,
    output reg [7:0] vga_r,
    output reg [7:0] vga_g,
    output reg [7:0] vga_b,
    output logic [10:0] DataAdrVGA // Dirección de memoria para el píxel actual
);

    // Parámetros de la imagen y sincronización
    localparam IMG_WIDTH = 100;
    localparam IMG_HEIGHT = 100;
    localparam H_SYNC_PULSE = 96;
    localparam H_BACK_PORCH = 48;
    localparam H_FRONT_PORCH = 16;
    localparam H_LINE = 800; // Total de píxeles por línea horizontal
    localparam V_SYNC_PULSE = 2;
    localparam V_BACK_PORCH = 33;
    localparam V_FRONT_PORCH = 10;
    localparam V_SCREEN = 525; // Total de líneas por pantalla

    reg [9:0] counter_x = 0;  // Contador horizontal
    reg [9:0] counter_y = 0;  // Contador vertical

    // Generación de señales de sincronización
    always @(posedge clk) begin
        if (counter_x < (H_LINE - 1))
            counter_x <= counter_x + 1;
        else begin
            counter_x <= 0;
            if (counter_y < (V_SCREEN - 1))
                counter_y <= counter_y + 1;
            else
                counter_y <= 0;
        end
    end

    assign vga_hsync = (counter_x >= H_SYNC_PULSE) ? 1'b1 : 1'b0;
    assign vga_vsync = (counter_y >= V_SYNC_PULSE) ? 1'b1 : 1'b0;

    // Determinar si estamos en la región activa de la pantalla
    wire active_pixel = (counter_x >= (H_SYNC_PULSE + H_BACK_PORCH)) && 
                        (counter_x < (H_SYNC_PULSE + H_BACK_PORCH + IMG_WIDTH)) &&
                        (counter_y >= (V_SYNC_PULSE + V_BACK_PORCH)) &&
                        (counter_y < (V_SYNC_PULSE + V_BACK_PORCH + IMG_HEIGHT));

    // Lógica para la asignación de colores y direcciones de memoria
    always @ (*) begin
        if (enabled && active_pixel) begin
            DataAdrVGA = (counter_y - (V_SYNC_PULSE + V_BACK_PORCH)) * IMG_WIDTH + 
                         (counter_x - (H_SYNC_PULSE + H_BACK_PORCH));
            vga_r = pixel;
            vga_g = pixel;
            vga_b = pixel;
        end else begin
            vga_r = 8'h00;
            vga_g = 8'h00;
            vga_b = 8'h00;
        end
    end

endmodule
module NumerosBuscaminas(
  input logic [9:0] x,
  input logic [9:0] y,
  input logic [2:0] numero, // Número a mostrar (de 1 a 8)
  output logic [7:0] red,
  output logic [7:0] green,
  output logic [7:0] blue
);

  always_comb begin
    // Inicializa los colores como el fondo
    red = 8'b10101010; // Gris en formato binario
    green = 8'b10101010; // Gris en formato binario
    blue = 8'b10101010; // Gris en formato binario

    // Define los colores para cada número en formato binario
    case (numero)
      3'b001: // Número 1 (Rojo)
        begin
          red = 8'b11111111; // Rojo
          green = 8'b00000000; // Negro
          blue = 8'b00000000; // Negro
        end
      3'b010: // Número 2 (Verde)
        begin
          red = 8'b00000000; // Negro
          green = 8'b11111111; // Verde
          blue = 8'b00000000; // Negro
        end
      3'b011: // Número 3 (Azul)
        begin
          red = 8'b00000000; // Negro
          green = 8'b00000000; // Negro
          blue = 8'b11111111; // Azul
        end
      // Agrega casos para los números restantes aquí

      default: // Por defecto, muestra el fondo
        begin
          red = 8'b10101010; // Gris en formato binario
          green = 8'b10101010; // Gris en formato binario
          blue = 8'b10101010; // Gris en formato binario
        end
    endcase
  end

endmodule


module Mux #(parameter N=4)
(
  input logic trigger,                   // Entrada de control para habilitar la operación ALU
  input logic reset,                     // Entrada de control para restablecer la operación ALU
  input [N-1:0] out_sum,                // Entrada de suma
  input [N-1:0] out_subs,               // Entrada de resta
  input [2*N-1:0] out_mult,             // Entrada de multiplicación (dividida en dos partes)
  input [N-1:0] out_div,                // Entrada de división
  input [N-1:0] out_mod,                // Entrada de módulo
  input [N-1:0] out_and,                // Entrada de operación AND
  input [N-1:0] out_or,                 // Entrada de operación OR
  input [N-1:0] out_xor,                // Entrada de operación XOR
  input [N-1:0] out_shiftl,             // Entrada de desplazamiento izquierdo
  input [N-1:0] out_shiftr,             // Entrada de desplazamiento derecho
  input [3:0] select,                   // Selector de operación ALU (4 bits)
  output [N-1:0] out,                   // Salida principal de la ALU
  output [N-1:0] out_aux                // Salida auxiliar de la ALU
);

  logic [N-1:0] out_alu;                // Registro para el resultado de la ALU
  logic [N-1:0] out_aluaux;             // Registro auxiliar para la ALU
  int i;                                // Variable no utilizada (sin uso aparente)

  always @ (posedge trigger or posedge reset) begin
    if (trigger == 1'b1) begin          // Verifica si el disparador está habilitado
      
      out_aluaux <= '0;                 // Inicializa la salida auxiliar
      
      case (select)                    // Realiza una operación ALU basada en el valor del selector
        4'b0000: out_alu = out_sum;     // Suma
        4'b0001: out_alu = out_subs;    // Resta
        4'b0010: begin                  // Multiplicación
          out_alu = out_mult[N-1:0];    // Parte inferior del resultado de multiplicación
          out_aluaux <= out_mult[2*N-1:N]; // Parte superior del resultado de multiplicación
        end
        4'b0011: out_alu = out_div;     // División
        4'b0100: out_alu = out_mod;     // Módulo
        4'b0101: out_alu = out_and;     // AND lógico
        4'b0110: out_alu = out_or;      // OR lógico
        4'b0111: out_alu = out_xor;     // XOR lógico
        4'b1000: out_alu = out_shiftl;  // Desplazamiento izquierdo
        4'b1001: out_alu = out_shiftr;  // Desplazamiento derecho
        default: out_alu = out_sum;     // Valor predeterminado (suma)
      endcase
    end
    if (reset) begin                   // Si hay un reinicio activado, restablece las salidas
      out_alu = 0;
      out_aluaux <= 0;
    end
  end

  assign out = out_alu;                // Asigna la salida principal a la salida de la ALU
  assign out_aux = out_aluaux;         // Asigna la salida auxiliar a la salida de la ALU

endmodule
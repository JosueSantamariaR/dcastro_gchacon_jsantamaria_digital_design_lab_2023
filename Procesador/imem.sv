module imem(
  input logic [31:0] a,
  output logic [31:0] rd
);

  logic [31:0] RAM[63:0];

  initial
    // CAMBIAR DIRECCION DEL ARCHIVO ========================
    $readmemh("C:/Users/DELL/Desktop/Digitales/jgonzalez_digital_design_lab_2023/PROYECTO/memfile.dat", RAM);
    // CAMBIAR DIRECCION DEL ARCHIVO ========================

  assign rd = RAM[a[31:2]]; // Word-aligned

endmodule
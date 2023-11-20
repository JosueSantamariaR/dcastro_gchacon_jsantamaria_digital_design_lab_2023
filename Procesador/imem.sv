module imem(
  input logic [31:0] a,
  output logic [31:0] rd
);

  logic [31:0] RAM[63:0];

  initial
    // CAMBIAR DIRECCION DEL ARCHIVO ========================
    $readmem("images.mif", RAM);
    // CAMBIAR DIRECCION DEL ARCHIVO ========================

  assign rd = RAM[a[31:2]]; // Word-aligned

endmodule
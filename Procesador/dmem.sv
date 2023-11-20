module dmem(
  input logic clk, MemWrite,
  input logic [31:0] DataAdr, WriteData,
  output logic [31:0] ReadData
);

  logic [31:0] RAM[63:0];

  // Read operation
  assign ReadData = RAM[DataAdr[31:2]]; // Word-aligned

  // Write operation
  always_ff @(posedge clk)
    if (MemWrite)
      RAM[DataAdr[31:2]] <= WriteData;

endmodule

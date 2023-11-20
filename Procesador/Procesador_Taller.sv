module Procesador_Taller(
  input logic clk, reset,
  output logic [31:0] WriteData, DataAdr,
  output logic MemWrite
);

  logic [31:0] PC, Instr, ReadData;
  logic [31:0] ALUResult;

  // Instantiate processor and memories
  arm arm_inst (
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .Instr(Instr),
    .MemWrite(MemWrite),
    .ALUResult(ALUResult),
    .WriteData(WriteData),
    .ReadData(ReadData)
  );

  imem imem_inst (
    .a(PC),
    .rd(Instr)
  );

  dmem dmem_inst (
    .clk(clk),
    .MemWrite(MemWrite),
    .DataAdr(DataAdr),
    .WriteData(WriteData),
    .ReadData(ReadData)
  );

endmodule


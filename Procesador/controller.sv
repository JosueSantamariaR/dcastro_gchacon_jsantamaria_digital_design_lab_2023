module controller (
  input logic clk, reset,
  input logic [31:12] Instr,
  input logic [3:0] ALUFlags,
  output logic [1:0] RegSrc,
  output logic RegWrite,
  output logic [1:0] ImmSrc,
  output logic ALUSrc,
  output logic [1:0] ALUControl,
  output logic MemWrite, MemtoReg,
  output logic PCSrc
);

  logic [1:0] FlagW;
  logic PCS, RegW, MemW;

  // Decoder instantiation
  decoder dec (
    .Instr(Instr),
    .FlagW(FlagW),
    .PCS(PCS),
    .RegW(RegW),
    .MemW(MemW),
    .MemtoReg(MemtoReg),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegSrc(RegSrc),
    .ALUControl(ALUControl)
  );

  // Conditional logic instantiation
  condlogic cl (
    .clk(clk),
    .reset(reset),
    .Instr(Instr),
    .ALUFlags(ALUFlags),
    .FlagW(FlagW),
    .PCS(PCS),
    .RegW(RegW),
    .MemW(MemW),
    .PCSrc(PCSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite)
  );

endmodule

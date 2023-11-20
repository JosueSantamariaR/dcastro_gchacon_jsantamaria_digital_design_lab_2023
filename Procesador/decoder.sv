module decoder(
  input logic [1:0] Op,
  input logic [5:0] Funct,
  input logic [3:0] Rd,
  output logic [1:0] FlagW,
  output logic PCS, RegW, MemW,
  output logic MemtoReg, ALUSrc,
  output logic [1:0] ImmSrc, RegSrc, ALUControl
);

  logic [9:0] controls;
  logic Branch, ALUOp;

  // Main Decoder
  always_comb begin
    case(Op)
      // Data-processing immediate
      2'b00: controls = Funct[5] ? 10'b0000101001 : 10'b0000001001;
      // LDR
      2'b01: controls = Funct[0] ? 10'b0001111000 : 10'b1001110100;
      // B
      2'b10: controls = 10'b0110100010;
      // Unimplemented
      default: controls = 10'bx;
    endcase
  end

  // ALU Decoder
  always_comb begin
    if (ALUOp) begin // which DP Instr?
      case(Funct[4:1])
        4'b0100: ALUControl = 2'b00; // ADD
        4'b0010: ALUControl = 2'b01; // SUB
        4'b0000: ALUControl = 2'b10; // AND
        4'b1100: ALUControl = 2'b11; // ORR
        default: ALUControl = 2'bx; // unimplemented
      endcase

      // update flags if S bit is set (C & V only for arith)
      FlagW[1] = Funct[0];
      FlagW[0] = Funct[0] & (ALUControl == 2'b00 | ALUControl == 2'b01);
    end else begin
      ALUControl = 2'b00; // add for non-DP instructions
      FlagW = 2'b00; // don't update Flags
    end
  end

  // PC Logic
  assign PCS = ((Rd == 4'b1111) & RegW) | Branch;

  // Assign decoded controls to outputs
  assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp} = controls;

endmodule


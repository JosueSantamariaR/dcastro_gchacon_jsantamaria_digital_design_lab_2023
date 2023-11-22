module Datapath(input  logic 		   clk, reset,
					 input  logic [1:0]  RegSrc, 
					 input  logic	 	   RegWrite,
					 input  logic [1:0]  ImmSrc,
					 input  logic 	      ALUSrc,
					 input  logic [3:0]  ALUControl,
					 input  logic 		   MemToReg,
					 input  logic 		   PCSrc,
					 output logic [3:0]  ALUFlags,
					 output logic [31:0] PC, 
					 input  logic [31:0] Instr, 
					 output logic [31:0] ALUResult, WriteData, 
					 input  logic [31:0] ReadData,
					 output logic [1:0]  MemorySelector,
					 output logic			Finished
					 );
	
	logic [31:0] PCNext, PCPlus4, PCPlus8;
	logic [31:0] ExtImm, SrcA, SrcB, Result;
	logic [3:0]  RA1, RA2;
	
	// Next PC
	Multiplexer_2 #(32)  pcmux(PCPlus4, Result, PCSrc, PCNext);
	Width_FlipFlop #(32) pcreg(clk, reset, PCNext, PC);
	Adder #(32) pcadd1(PC, 32'b100, PCPlus4);
	Adder #(32) pcadd2(PCPlus4, 32'b100, PCPlus8);
	
	// Register file
	Multiplexer_2 #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1);
	Multiplexer_2 #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2);
	Regfile   rf(clk, RegWrite, RA1, RA2, Instr[15:12], Result, PCPlus8, SrcA, WriteData);
	
	Multiplexer_2 #(32) resmux(ALUResult, ReadData, MemToReg, Result);
	Extend    ext(Instr[23:0], ImmSrc, ExtImm, MemorySelector);
	
	// ALU
	Multiplexer_2 #(32) srcbmux(WriteData, ExtImm, ALUSrc, SrcB);
	//alu #(32) ownALU(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);
	//chavarria ownALU(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);
	ALU_m2 ownALU(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);
					 
endmodule
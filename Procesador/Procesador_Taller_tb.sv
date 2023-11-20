//vsim -L altera_mf_ver -L lpm_ver rom_top_tb
module Procesador_Taller_tb;
  logic clk;
  logic reset;
  logic [31:0] WriteData, DataAdr;
  logic MemWrite;

  // instantiate device to be tested
  Procesador_Taller proc(clk, reset, WriteData, DataAdr, MemWrite);

  // initialize test
  initial
  begin
    reset <= 1;
    #22;
    reset <= 0;
  end

  // generate clock to sequence tests
  always
  begin
    clk <= 1;
    #50;
    clk <= 0;
    #50;
  end

  // check that 7 gets written to address 0x64
  // at the end of the program
  always @(negedge clk)
  begin
    if (MemWrite)
    begin
      if ((DataAdr === 100) && (WriteData === 7))
      begin
        $display("Simulation succeeded");
        $stop;
      end
      else if (DataAdr !== 96)
      begin
        $display("Simulation failed");
        $stop;
      end
    end
  end
endmodule

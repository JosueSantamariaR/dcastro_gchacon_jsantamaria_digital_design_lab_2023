module flopr #(parameter WIDTH = 8)
  (input logic clk, reset,
   input logic [WIDTH-1:0] d,
   output logic [WIDTH-1:0] q);

  always_ff @(posedge clk or posedge reset)
    if (reset)
      q <= '0; // Reset the output to 0 on the rising edge of reset
    else
      q <= d; // Update the output on the rising edge of the clock

endmodule

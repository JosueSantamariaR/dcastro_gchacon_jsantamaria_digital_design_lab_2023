//TopModule

module topModule(
						input logic clk, rst,
						input logic [2:0] btn,
						output [7:0] q,
						output [7:0] address);
						
logic wren, seconds;

logic [7:0] data, addr_wr, addr_cont;

ram1 mem(address, seconds, data, wren, q);
counter cont(seconds, rst, 1'b1, adr_cont);
hhClock div(seconds, clk);
writeMem write(btn, wren, addr_wr, data);
mux21 muxAddr(addr_wr, addr_cont, rst, address);

endmodule
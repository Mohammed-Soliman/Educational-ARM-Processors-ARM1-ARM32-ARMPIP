// top module
module arm1_top (
input logic clk,
input logic reset
);
arm1_datapath processor (
.clk(clk),
.reset(reset)
);
endmodule

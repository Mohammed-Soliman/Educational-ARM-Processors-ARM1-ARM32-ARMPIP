// flip-flop with enable, async reset, sync clear
module flopenrc #(parameter WIDTH = 8) (
input logic clk,
input logic reset,
input logic en,
input logic clear,
input logic [WIDTH-1:0] d,
output logic [WIDTH-1:0] q
);
always_ff @(posedge clk or posedge reset)
if (reset) q <= {WIDTH{1'b0}};
else if (clear) q <= {WIDTH{1'b0}};
else if (en) q <= d;
endmodule

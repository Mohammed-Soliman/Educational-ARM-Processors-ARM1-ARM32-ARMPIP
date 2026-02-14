// flip-flop with async reset
module flopr #(parameter WIDTH = 8) (
input logic clk,
input logic reset,
input logic [WIDTH-1:0] d,
output logic [WIDTH-1:0] q
);
always_ff @(posedge clk or posedge reset)
if (reset) q <= {WIDTH{1'b0}};
else q <= d;
endmodule

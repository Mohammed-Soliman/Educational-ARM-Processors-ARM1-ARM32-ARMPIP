// output register
module o (
input logic clk, reset,
input logic o_write,
input logic [7:0] o_in,
output logic [7:0] o_out
);
always_ff @(posedge clk or posedge reset) begin
if (reset)
o_out <= 8'h00;
else if (o_write)
o_out <= o_in;
end
endmodule

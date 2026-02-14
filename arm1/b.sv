// b register
module b (
input logic clk, reset,
input logic b_write,
input logic [7:0] b_in,
output logic [7:0] b_out
);
always_ff @(posedge clk or posedge reset) begin
if (reset)
b_out <= 8'h00;
else if (b_write)
b_out <= b_in;
end
endmodule

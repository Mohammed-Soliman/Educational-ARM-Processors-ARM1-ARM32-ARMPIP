// accumulator
module ac (
input logic clk, reset,
input logic ac_write,
input logic [7:0] ac_in,
output logic [7:0] ac_out
);
always_ff @(posedge clk or posedge reset) begin
if (reset)
ac_out <= 8'h00;
else if (ac_write)
ac_out <= ac_in;
end
endmodule

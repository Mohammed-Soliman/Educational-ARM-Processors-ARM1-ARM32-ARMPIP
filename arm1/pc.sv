// program counter
module pc (
input logic clk, reset,
input logic pc_write,
input logic [3:0] next_pc,
output logic [3:0] pc_value
);
always_ff @(posedge clk or posedge reset) begin
if (reset)
pc_value <= 4'h0;
else if (pc_write)
pc_value <= next_pc;
end
endmodule

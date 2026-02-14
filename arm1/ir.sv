// instruction register
module ir (
input logic clk, reset,
input logic ir_write,
input logic [7:0] instruction_in,
output logic [3:0] opcode,
output logic [3:0] address_field
);
always_ff @(posedge clk or posedge reset) begin
if (reset) begin
opcode <= 4'h0;
address_field <= 4'h0;
end else if (ir_write) begin
opcode <= instruction_in[7:4];
address_field <= instruction_in[3:0];
end
end
endmodule

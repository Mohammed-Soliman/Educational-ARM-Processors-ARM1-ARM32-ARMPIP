// alu
module alu (
input logic [31:0] a, b,
input logic [2:0] ALUControl,
output logic [31:0] Result,
output logic [3:0] ALUFlags
);
logic neg, zero, carry, overflow;
logic [31:0] condinvb;
logic [32:0] sum;

assign condinvb = ALUControl[0] ? ~b : b;
assign sum = {1'b0, a} + {1'b0, condinvb} + {32'b0, ALUControl[0]};

always_comb begin
case(ALUControl)
3'b000: Result = sum[31:0];
3'b001: Result = sum[31:0];
3'b010: Result = a & b;
3'b011: Result = a | b;
3'b100: Result = a & ~b;
3'b101: Result = a ^ b;
3'b110: Result = b;
default: Result = sum[31:0];
endcase
end

assign neg = Result[31];
assign zero = (Result == 32'b0);
assign carry = (ALUControl == 3'b000 || ALUControl == 3'b001) ? sum[32] : 1'b0;
assign overflow = (ALUControl == 3'b000 || ALUControl == 3'b001) ?
(~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31])) : 1'b0;
assign ALUFlags = {neg, zero, carry, overflow};
endmodule

// alu
module alu (
input logic [31:0] SrcA,
input logic [31:0] SrcB,
input logic [1:0] ALUControl,
output logic [31:0] ALUResult,
output logic [3:0] ALUFlags
);
logic [32:0] sum;
logic neg, zero, carry, overflow;
logic [31:0] result;

always_comb begin
case(ALUControl)
2'b00: begin
sum = {1'b0, SrcA} + {1'b0, SrcB};
result = sum[31:0];
carry = sum[32];
overflow = (SrcA[31] == SrcB[31]) && (result[31] != SrcA[31]);
end
2'b01: begin
sum = {1'b0, SrcA} - {1'b0, SrcB};
result = sum[31:0];
carry = ~sum[32];
overflow = (SrcA[31] != SrcB[31]) && (result[31] != SrcA[31]);
end
2'b10: begin
result = SrcA & SrcB;
carry = 1'b0;
overflow = 1'b0;
end
2'b11: begin
result = SrcA | SrcB;
carry = 1'b0;
overflow = 1'b0;
end
default: begin
result = SrcA + SrcB;
carry = 1'b0;
overflow = 1'b0;
end
endcase
end

assign ALUResult = result;
assign neg = result[31];
assign zero = (result == 32'b0);
assign ALUFlags = {neg, zero, carry, overflow};
endmodule

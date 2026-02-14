// alu
module alu (
input logic [7:0] a, b,
input logic [2:0] alu_control,
output logic [7:0] result,
output logic zero_flag,
output logic carry_flag,
output logic negative_flag,
output logic overflow_flag
);
logic [8:0] extended_result;

always_comb begin
extended_result = 9'h000;
case (alu_control)
3'b000: begin
extended_result = {1'b0, a} + {1'b0, b};
result = extended_result[7:0];
end
3'b001: begin
extended_result = {1'b0, a} - {1'b0, b};
result = extended_result[7:0];
end
3'b010: result = a | b;
3'b011: result = a & b;
default: result = a;
endcase
zero_flag = (result == 8'h00);
carry_flag = extended_result[8];
negative_flag = result[7];
overflow_flag = (a[7] & b[7] & ~result[7]) | (~a[7] & ~b[7] & result[7]);
end
endmodule

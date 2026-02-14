// 32-bit adder
module adder_32bit (
input logic [31:0] a,
input logic [31:0] b,
output logic [31:0] y
);
assign y = a + b;
endmodule

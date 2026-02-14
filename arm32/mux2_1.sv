// 2-to-1 mux 32-bit
module mux2_1 (
input logic [31:0] d0,
input logic [31:0] d1,
input logic s,
output logic [31:0] y
);
assign y = s ? d1 : d0;
endmodule

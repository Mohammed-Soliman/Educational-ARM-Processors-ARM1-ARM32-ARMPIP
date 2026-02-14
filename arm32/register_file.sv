// register file
module register_file (
input logic clk,
input logic reset,
input logic [3:0] A1,
input logic [3:0] A2,
input logic [3:0] A3,
input logic [31:0] WD3,
input logic [31:0] R15,
input logic WE3,
output logic [31:0] RD1,
output logic [31:0] RD2
);
logic [31:0] registers [0:14];
logic [31:0] r15_value;

always_comb begin
RD1 = (A1 == 4'd15) ? r15_value : registers[A1];
RD2 = (A2 == 4'd15) ? r15_value : registers[A2];
end

always_ff @(posedge clk or posedge reset) begin
if (reset) begin
for (int i = 0; i < 15; i++)
registers[i] <= 32'b0;
end else if (WE3) begin
if (A3 != 4'd15)
registers[A3] <= WD3;
end
end

always_comb begin
r15_value = R15;
end
endmodule

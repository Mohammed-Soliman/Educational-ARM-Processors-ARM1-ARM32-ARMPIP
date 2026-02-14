// data memory
module data_memory (
input logic clk,
input logic [31:0] A,
input logic [31:0] WD,
input logic WE,
output logic [31:0] RD
);
logic [31:0] mem [0:1023];

assign RD = mem[A[31:2]];

always_ff @(posedge clk) begin
if (WE)
mem[A[31:2]] <= WD;
end
endmodule

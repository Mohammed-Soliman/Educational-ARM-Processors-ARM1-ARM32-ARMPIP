// instruction memory
module instruction_memory (
input logic [31:0] A,
output logic [31:0] RD
);
logic [31:0] mem [0:1023];
assign RD = mem[A[31:2]];
endmodule

// conditional logic
module conditional_logic (
input logic clk,
input logic reset,
input logic [3:0] Cond,
input logic [3:0] ALUFlags,
input logic [1:0] FlagW,
input logic PCS,
input logic RegW,
input logic MemW,
input logic Branch,
output logic [3:0] Flags,
output logic PCSrc,
output logic RegWrite,
output logic MemWrite
);
logic [1:0] FlagWrite;
logic CondEx;

always_ff @(posedge clk or posedge reset) begin
if (reset) begin
Flags <= 4'b0000;
end else begin
if (FlagWrite[1]) Flags[3:2] <= ALUFlags[3:2];
if (FlagWrite[0]) Flags[1:0] <= ALUFlags[1:0];
end
end

always_comb begin
case(Cond)
4'b0000: CondEx = Flags[2];
4'b0001: CondEx = ~Flags[2];
4'b0010: CondEx = Flags[1];
4'b0011: CondEx = ~Flags[1];
4'b0100: CondEx = Flags[3];
4'b0101: CondEx = ~Flags[3];
4'b0110: CondEx = Flags[0];
4'b0111: CondEx = ~Flags[0];
4'b1000: CondEx = Flags[1] & ~Flags[2];
4'b1001: CondEx = ~Flags[1] | Flags[2];
4'b1010: CondEx = (Flags[3] == Flags[0]);
4'b1011: CondEx = (Flags[3] != Flags[0]);
4'b1100: CondEx = ~Flags[2] & (Flags[3] == Flags[0]);
4'b1101: CondEx = Flags[2] | (Flags[3] != Flags[0]);
4'b1110: CondEx = 1'b1;
default: CondEx = 1'b0;
endcase
end

assign FlagWrite = FlagW & {2{CondEx}};
assign RegWrite = RegW & CondEx;
assign MemWrite = MemW & CondEx;
assign PCSrc = (PCS & CondEx) | (Branch & CondEx);
endmodule

// decoder
module decoder (
input logic [1:0] Op,
input logic [5:0] Funct,
input logic [3:0] Rd,
output logic [1:0] FlagW,
output logic PCS,
output logic RegW,
output logic MemW,
output logic MemtoReg,
output logic ALUSrc,
output logic [1:0] ImmSrc,
output logic [1:0] RegSrc,
output logic [1:0] ALUControl,
output logic Branch
);
logic [9:0] controls;
logic ALUOp;

always_comb begin
case(Op)
2'b00: begin
if (Funct[5])
controls = 10'b0000101001;
else
controls = 10'b0000001001;
end
2'b01: begin
if (Funct[0])
controls = 10'b0001111000;
else
controls = 10'b1001110100;
end
2'b10: controls = 10'b0110100010;
default: controls = 10'b0000000000;
endcase
end

assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp} = controls;

always_comb begin
if (ALUOp) begin
case(Funct[4:1])
4'b0100: ALUControl = 2'b00;
4'b0010: ALUControl = 2'b01;
4'b0000: ALUControl = 2'b10;
4'b1100: ALUControl = 2'b11;
default: ALUControl = 2'b00;
endcase
FlagW[1] = Funct[0];
FlagW[0] = Funct[0] & (ALUControl == 2'b00 | ALUControl == 2'b01);
end else begin
ALUControl = 2'b00;
FlagW = 2'b00;
end
end

assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
endmodule

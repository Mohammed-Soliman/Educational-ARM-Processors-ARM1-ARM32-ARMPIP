// decoder
module decoder (
input logic [1:0] Op,
input logic [5:0] Funct,
input logic [3:0] Rd,
output logic [1:0] FlagW,
output logic PCS, RegW, MemW,
output logic MemtoReg, ALUSrc,
output logic [1:0] ImmSrc, RegSrc,
output logic [2:0] ALUControl
);
logic [9:0] controls;
logic Branch, ALUOp;

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
4'b0100: ALUControl = 3'b000;
4'b0010: ALUControl = 3'b001;
4'b0000: ALUControl = 3'b010;
4'b1100: ALUControl = 3'b011;
4'b1110: ALUControl = 3'b100;
4'b0001: ALUControl = 3'b101;
4'b1101: ALUControl = 3'b110;
4'b1111: ALUControl = 3'b110;
4'b1010: ALUControl = 3'b001;
default: ALUControl = 3'b000;
endcase
FlagW[1] = Funct[0];
FlagW[0] = Funct[0] & ((ALUControl == 3'b000) | (ALUControl == 3'b001));
end else begin
ALUControl = 3'b000;
FlagW = 2'b00;
end
end

assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
endmodule

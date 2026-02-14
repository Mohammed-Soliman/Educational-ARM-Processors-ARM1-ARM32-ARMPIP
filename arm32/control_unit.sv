// control unit
module control_unit (
input logic clk,
input logic reset,
input logic [31:0] Instr,
input logic [3:0] ALUFlags,
output logic [1:0] RegSrc,
output logic RegWrite,
output logic [1:0] ImmSrc,
output logic ALUSrc,
output logic [1:0] ALUControl,
output logic MemWrite,
output logic MemtoReg,
output logic PCSrc
);
logic [1:0] FlagW;
logic PCS, RegW, MemW;
logic Branch;
logic [3:0] Flags;

logic [3:0] Cond;
logic [1:0] Op;
logic [5:0] Funct;
logic [3:0] Rd;

assign Cond = Instr[31:28];
assign Op = Instr[27:26];
assign Funct = Instr[25:20];
assign Rd = Instr[15:12];

decoder main_decoder (
.Op(Op),
.Funct(Funct),
.Rd(Rd),
.FlagW(FlagW),
.PCS(PCS),
.RegW(RegW),
.MemW(MemW),
.MemtoReg(MemtoReg),
.ALUSrc(ALUSrc),
.ImmSrc(ImmSrc),
.RegSrc(RegSrc),
.ALUControl(ALUControl),
.Branch(Branch)
);

conditional_logic cond_logic (
.clk(clk),
.reset(reset),
.Cond(Cond),
.ALUFlags(ALUFlags),
.FlagW(FlagW),
.PCS(PCS),
.RegW(RegW),
.MemW(MemW),
.Branch(Branch),
.Flags(Flags),
.PCSrc(PCSrc),
.RegWrite(RegWrite),
.MemWrite(MemWrite)
);
endmodule

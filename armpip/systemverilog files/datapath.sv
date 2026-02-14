// datapath
module datapath (
input logic clk, reset,
input logic [1:0] RegSrcD,
input logic [1:0] ImmSrcD,
output logic [31:0] InstrD,
input logic ALUSrcE,
input logic [2:0] ALUControlE,
output logic [3:0] ALUFlagsE,
output logic [3:0] RA1E, RA2E,
output logic [3:0] WA3E,
output logic [31:0] ALUResultM,
output logic [31:0] WriteDataM,
input logic [31:0] ReadDataM,
output logic [3:0] WA3M,
output logic [3:0] WA3W,
input logic [1:0] ForwardAE, ForwardBE,
input logic StallF, StallD,
input logic FlushD, FlushE,
input logic RegWriteW,
input logic MemtoRegW,
input logic PCSrcW,
input logic [31:0] InstrF,
output logic [31:0] PCF
);
logic [31:0] PCPlus4F, PCNextF;
logic [31:0] PCPlus4D, PCPlus8D;
logic [31:0] RD1D, RD2D, ExtImmD;
logic [3:0] RA1D, RA2D, WA3D;
logic [31:0] PCPlus8E;
logic [31:0] RD1E, RD2E, ExtImmE;
logic [31:0] SrcAE, SrcBE, WriteDataE;
logic [31:0] ALUResultE;
logic [31:0] ALUOutM;
logic [31:0] ALUOutW, ReadDataW;
logic [31:0] ResultW;
logic [31:0] BranchTargetE, BranchTargetM, BranchTargetW;

// fetch
mux2 #(32) pcmux (
.d0(PCPlus4F),
.d1(BranchTargetW),
.s(PCSrcW),
.y(PCNextF)
);

flopenr #(32) pcreg (
.clk(clk),
.reset(reset),
.en(~StallF),
.d(PCNextF),
.q(PCF)
);

adder #(32) pcadd4 (
.a(PCF),
.b(32'd4),
.y(PCPlus4F)
);

// fetch to decode
flopenrc #(32) instrreg (
.clk(clk),
.reset(reset),
.en(~StallD),
.clear(FlushD),
.d(InstrF),
.q(InstrD)
);

flopenrc #(32) pcplus4Dreg (
.clk(clk),
.reset(reset),
.en(~StallD),
.clear(FlushD),
.d(PCPlus4F),
.q(PCPlus4D)
);

// decode
adder #(32) pcadd8 (
.a(PCPlus4D),
.b(32'd4),
.y(PCPlus8D)
);

mux2 #(4) ra1mux (
.d0(InstrD[19:16]),
.d1(4'b1111),
.s(RegSrcD[0]),
.y(RA1D)
);

mux2 #(4) ra2mux (
.d0(InstrD[3:0]),
.d1(InstrD[15:12]),
.s(RegSrcD[1]),
.y(RA2D)
);

assign WA3D = InstrD[15:12];

regfile rf (
.clk(clk),
.we3(RegWriteW),
.ra1(RA1D),
.ra2(RA2D),
.wa3(WA3W),
.wd3(ResultW),
.r15(PCPlus8D),
.rd1(RD1D),
.rd2(RD2D)
);

extend ext (
.Instr(InstrD[23:0]),
.ImmSrc(ImmSrcD),
.ExtImm(ExtImmD)
);

// decode to execute
floprc #(32) rd1Ereg (clk, reset, FlushE, RD1D, RD1E);
floprc #(32) rd2Ereg (clk, reset, FlushE, RD2D, RD2E);
floprc #(32) extimmEreg (clk, reset, FlushE, ExtImmD, ExtImmE);
floprc #(4) ra1Ereg (clk, reset, FlushE, RA1D, RA1E);
floprc #(4) ra2Ereg (clk, reset, FlushE, RA2D, RA2E);
floprc #(4) wa3Ereg (clk, reset, FlushE, WA3D, WA3E);
floprc #(32) pcplus8Ereg (clk, reset, FlushE, PCPlus8D, PCPlus8E);

// execute
mux3 #(32) srcamux (
.d0(RD1E),
.d1(ResultW),
.d2(ALUOutM),
.s(ForwardAE),
.y(SrcAE)
);

mux3 #(32) wdmux (
.d0(RD2E),
.d1(ResultW),
.d2(ALUOutM),
.s(ForwardBE),
.y(WriteDataE)
);

mux2 #(32) srcbmux (
.d0(WriteDataE),
.d1(ExtImmE),
.s(ALUSrcE),
.y(SrcBE)
);

alu alu_unit (
.a(SrcAE),
.b(SrcBE),
.ALUControl(ALUControlE),
.Result(ALUResultE),
.ALUFlags(ALUFlagsE)
);

adder #(32) branchadd (
.a(PCPlus8E),
.b(ExtImmE),
.y(BranchTargetE)
);

flopr #(32) branchtargetMreg (clk, reset, BranchTargetE, BranchTargetM);
flopr #(32) branchtargetWreg (clk, reset, BranchTargetM, BranchTargetW);

// execute to memory
flopr #(32) aluresultMreg (clk, reset, ALUResultE, ALUResultM);
flopr #(32) writedataMreg (clk, reset, WriteDataE, WriteDataM);
flopr #(4) wa3Mreg (clk, reset, WA3E, WA3M);

assign ALUOutM = ALUResultM;

// memory to writeback
flopr #(32) aluoutWreg (clk, reset, ALUResultM, ALUOutW);
flopr #(32) readdataWreg (clk, reset, ReadDataM, ReadDataW);
flopr #(4) wa3Wreg (clk, reset, WA3M, WA3W);

// writeback
mux2 #(32) resultmux (
.d0(ALUOutW),
.d1(ReadDataW),
.s(MemtoRegW),
.y(ResultW)
);
endmodule

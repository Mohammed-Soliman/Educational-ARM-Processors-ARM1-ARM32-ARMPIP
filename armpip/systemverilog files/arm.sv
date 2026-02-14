// arm processor
module arm (
input logic clk, reset,
output logic [31:0] PCF,
input logic [31:0] InstrF,
output logic MemWriteM,
output logic [31:0] ALUResultM, WriteDataM,
input logic [31:0] ReadDataM
);
logic [1:0] RegSrcD, ImmSrcD;
logic ALUSrcE;
logic [2:0] ALUControlE;
logic MemtoRegE, MemtoRegM, MemtoRegW;
logic PCSrcD, PCSrcE, PCSrcM, PCSrcW;
logic RegWriteE, RegWriteM, RegWriteW;
logic BranchTakenE;

logic [31:0] InstrD;
logic [3:0] ALUFlagsE;
logic [3:0] RA1E, RA2E;
logic [3:0] RA1D, RA2D;
logic [3:0] WA3E, WA3M, WA3W;

logic [1:0] ForwardAE, ForwardBE;
logic StallF, StallD;
logic FlushD, FlushE;

assign RA1D = RegSrcD[0] ? 4'b1111 : InstrD[19:16];
assign RA2D = RegSrcD[1] ? InstrD[15:12] : InstrD[3:0];

controller ctrl (
.clk(clk),
.reset(reset),
.InstrD(InstrD[31:12]),
.ALUFlagsE(ALUFlagsE),
.RegSrcD(RegSrcD),
.ImmSrcD(ImmSrcD),
.ALUSrcE(ALUSrcE),
.ALUControlE(ALUControlE),
.MemWriteM(MemWriteM),
.MemtoRegE(MemtoRegE),
.MemtoRegM(MemtoRegM),
.MemtoRegW(MemtoRegW),
.PCSrcD(PCSrcD),
.PCSrcE(PCSrcE),
.PCSrcM(PCSrcM),
.PCSrcW(PCSrcW),
.RegWriteE(RegWriteE),
.RegWriteM(RegWriteM),
.RegWriteW(RegWriteW),
.BranchTakenE(BranchTakenE),
.FlushE(FlushE)
);

datapath dp (
.clk(clk),
.reset(reset),
.RegSrcD(RegSrcD),
.ImmSrcD(ImmSrcD),
.InstrD(InstrD),
.ALUSrcE(ALUSrcE),
.ALUControlE(ALUControlE),
.ALUFlagsE(ALUFlagsE),
.RA1E(RA1E),
.RA2E(RA2E),
.WA3E(WA3E),
.ALUResultM(ALUResultM),
.WriteDataM(WriteDataM),
.ReadDataM(ReadDataM),
.WA3M(WA3M),
.WA3W(WA3W),
.ForwardAE(ForwardAE),
.ForwardBE(ForwardBE),
.StallF(StallF),
.StallD(StallD),
.FlushD(FlushD),
.FlushE(FlushE),
.RegWriteW(RegWriteW),
.MemtoRegW(MemtoRegW),
.PCSrcW(PCSrcW),
.InstrF(InstrF),
.PCF(PCF)
);

hazard hzd (
.RA1E(RA1E),
.RA2E(RA2E),
.RA1D(RA1D),
.RA2D(RA2D),
.WA3E(WA3E),
.WA3M(WA3M),
.WA3W(WA3W),
.RegWriteE(RegWriteE),
.RegWriteM(RegWriteM),
.RegWriteW(RegWriteW),
.MemtoRegE(MemtoRegE),
.PCSrcD(PCSrcD),
.PCSrcE(PCSrcE),
.PCSrcM(PCSrcM),
.PCSrcW(PCSrcW),
.BranchTakenE(BranchTakenE),
.ForwardAE(ForwardAE),
.ForwardBE(ForwardBE),
.StallF(StallF),
.StallD(StallD),
.FlushD(FlushD),
.FlushE(FlushE)
);
endmodule

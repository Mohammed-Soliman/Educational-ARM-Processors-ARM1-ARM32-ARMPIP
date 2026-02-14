// controller
module controller (
input logic clk, reset,
input logic [31:12] InstrD,
input logic [3:0] ALUFlagsE,
output logic [1:0] RegSrcD,
output logic [1:0] ImmSrcD,
output logic ALUSrcE,
output logic [2:0] ALUControlE,
output logic MemWriteM,
output logic MemtoRegE, MemtoRegM, MemtoRegW,
output logic PCSrcD, PCSrcE, PCSrcM, PCSrcW,
output logic RegWriteE, RegWriteM, RegWriteW,
output logic BranchTakenE,
input logic FlushE
);
logic [1:0] FlagWD;
logic PCSD, RegWD, MemWD;
logic MemtoRegD, ALUSrcD;
logic [2:0] ALUControlD;

logic [1:0] FlagWE;
logic PCSE, RegWE, MemWE;
logic [3:0] CondE;
logic CondExE;
logic [3:0] FlagsE;
logic [1:0] FlagWriteE;

decoder dec (
.Op(InstrD[27:26]),
.Funct(InstrD[25:20]),
.Rd(InstrD[15:12]),
.FlagW(FlagWD),
.PCS(PCSD),
.RegW(RegWD),
.MemW(MemWD),
.MemtoReg(MemtoRegD),
.ALUSrc(ALUSrcD),
.ImmSrc(ImmSrcD),
.RegSrc(RegSrcD),
.ALUControl(ALUControlD)
);

assign PCSrcD = PCSD;

floprc #(1) regwE_reg (clk, reset, FlushE, RegWD, RegWE);
floprc #(1) memwE_reg (clk, reset, FlushE, MemWD, MemWE);
floprc #(1) pcsE_reg (clk, reset, FlushE, PCSD, PCSE);
floprc #(1) memtoregE_reg (clk, reset, FlushE, MemtoRegD, MemtoRegE);
floprc #(1) alusrcE_reg (clk, reset, FlushE, ALUSrcD, ALUSrcE);
floprc #(3) aluctrlE_reg (clk, reset, FlushE, ALUControlD, ALUControlE);
floprc #(2) flagwE_reg (clk, reset, FlushE, FlagWD, FlagWE);
floprc #(4) condE_reg (clk, reset, FlushE, InstrD[31:28], CondE);

flopenr #(2) flagreg1 (clk, reset, FlagWriteE[1], ALUFlagsE[3:2], FlagsE[3:2]);
flopenr #(2) flagreg0 (clk, reset, FlagWriteE[0], ALUFlagsE[1:0], FlagsE[1:0]);

condcheck cc (
.Cond(CondE),
.Flags(FlagsE),
.CondEx(CondExE)
);

assign FlagWriteE = FlagWE & {2{CondExE}};
assign RegWriteE = RegWE & CondExE;
assign PCSrcE = PCSE & CondExE;
assign BranchTakenE = PCSrcE;

flopr #(1) regwM_reg (clk, reset, RegWriteE, RegWriteM);
flopr #(1) memwM_reg (clk, reset, MemWE & CondExE, MemWriteM);
flopr #(1) pcsM_reg (clk, reset, PCSrcE, PCSrcM);
flopr #(1) memtoregM_reg (clk, reset, MemtoRegE, MemtoRegM);

flopr #(1) regwW_reg (clk, reset, RegWriteM, RegWriteW);
flopr #(1) pcsW_reg (clk, reset, PCSrcM, PCSrcW);
flopr #(1) memtoregW_reg (clk, reset, MemtoRegM, MemtoRegW);
endmodule

// datapath
module datapath (
input logic clk,
input logic reset,
input logic [1:0] RegSrc,
input logic RegWrite,
input logic [1:0] ImmSrc,
input logic ALUSrc,
input logic [1:0] ALUControl,
input logic MemWrite,
input logic MemtoReg,
input logic PCSrc,
output logic [31:0] PC,
input logic [31:0] Instr,
output logic [31:0] ALUResult,
output logic [31:0] WriteData,
input logic [31:0] ReadData,
output logic [3:0] ALUFlags
);
logic [31:0] PCNext, PCPlus4, PCPlus8;
logic [31:0] ExtImm, SrcA, SrcB;
logic [31:0] Result;
logic [3:0] RA1, RA2;
logic [31:0] RD1, RD2;
logic [31:0] SrcB_mux_out;
logic [31:0] Result_mux_out;

adder_32bit pc_plus4_adder (
.a(PC),
.b(32'd4),
.y(PCPlus4)
);

adder_32bit pc_plus8_adder (
.a(PCPlus4),
.b(32'd4),
.y(PCPlus8)
);

mux2_1 pcnext_mux (
.d0(PCPlus4),
.d1(Result),
.s(PCSrc),
.y(PCNext)
);

program_counter pc_reg (
.clk(clk),
.reset(reset),
.PC_next(PCNext),
.PC(PC)
);

assign RA1 = RegSrc[0] ? 4'd15 : Instr[19:16];
assign RA2 = RegSrc[1] ? Instr[15:12] : Instr[3:0];

register_file rf (
.clk(clk),
.reset(reset),
.A1(RA1),
.A2(RA2),
.A3(Instr[15:12]),
.WD3(Result),
.R15(PCPlus8),
.WE3(RegWrite),
.RD1(RD1),
.RD2(RD2)
);

extend ext (
.Instr(Instr[23:0]),
.ImmSrc(ImmSrc),
.ExtImm(ExtImm)
);

mux2_1 srcb_mux (
.d0(RD2),
.d1(ExtImm),
.s(ALUSrc),
.y(SrcB_mux_out)
);

assign SrcA = RD1;
assign SrcB = SrcB_mux_out;

alu alu_inst (
.SrcA(SrcA),
.SrcB(SrcB),
.ALUControl(ALUControl),
.ALUResult(ALUResult),
.ALUFlags(ALUFlags)
);

assign WriteData = RD2;

mux2_1 result_mux (
.d0(ALUResult),
.d1(ReadData),
.s(MemtoReg),
.y(Result_mux_out)
);

assign Result = Result_mux_out;
endmodule

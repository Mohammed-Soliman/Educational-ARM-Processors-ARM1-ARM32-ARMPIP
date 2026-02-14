// arm processor
module arm_processor (
input logic clk,
input logic reset,
output logic [31:0] PC
);
logic [31:0] Instr;
logic [31:0] ALUResult;
logic [31:0] WriteData;
logic [31:0] ReadData;
logic [3:0] ALUFlags;

logic [1:0] RegSrc;
logic RegWrite;
logic [1:0] ImmSrc;
logic ALUSrc;
logic [1:0] ALUControl;
logic MemWrite;
logic MemtoReg;
logic PCSrc;

instruction_memory instr_mem (
.A(PC),
.RD(Instr)
);

data_memory data_mem (
.clk(clk),
.A(ALUResult),
.WD(WriteData),
.WE(MemWrite),
.RD(ReadData)
);

control_unit control_unit_inst (
.clk(clk),
.reset(reset),
.Instr(Instr),
.ALUFlags(ALUFlags),
.RegSrc(RegSrc),
.RegWrite(RegWrite),
.ImmSrc(ImmSrc),
.ALUSrc(ALUSrc),
.ALUControl(ALUControl),
.MemWrite(MemWrite),
.MemtoReg(MemtoReg),
.PCSrc(PCSrc)
);

datapath datapath_inst (
.clk(clk),
.reset(reset),
.RegSrc(RegSrc),
.RegWrite(RegWrite),
.ImmSrc(ImmSrc),
.ALUSrc(ALUSrc),
.ALUControl(ALUControl),
.MemWrite(MemWrite),
.MemtoReg(MemtoReg),
.PCSrc(PCSrc),
.PC(PC),
.Instr(Instr),
.ALUResult(ALUResult),
.WriteData(WriteData),
.ReadData(ReadData),
.ALUFlags(ALUFlags)
);
endmodule

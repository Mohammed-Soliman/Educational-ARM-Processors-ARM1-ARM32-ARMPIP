// top module
module top (
input logic clk, reset,
output logic [31:0] WriteDataM,
output logic [31:0] DataAdrM,
output logic MemWriteM
);
logic [31:0] PCF, InstrF, ReadDataM;

arm arm_proc (
.clk(clk),
.reset(reset),
.PCF(PCF),
.InstrF(InstrF),
.MemWriteM(MemWriteM),
.ALUResultM(DataAdrM),
.WriteDataM(WriteDataM),
.ReadDataM(ReadDataM)
);

imem imem_unit (
.a(PCF),
.rd(InstrF)
);

dmem dmem_unit (
.clk(clk),
.we(MemWriteM),
.a(DataAdrM),
.wd(WriteDataM),
.rd(ReadDataM)
);
endmodule

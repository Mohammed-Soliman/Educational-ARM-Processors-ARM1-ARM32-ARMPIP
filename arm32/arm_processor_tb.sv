// testbench
module arm_processor_tb();
logic clk;
logic reset;
logic [31:0] PC;
integer cycle_count = 0;

arm_processor dut (
.clk(clk),
.reset(reset),
.PC(PC)
);

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
for (int i = 0; i < 1024; i++)
dut.instr_mem.mem[i] = 32'h00000000;

dut.instr_mem.mem[0] = 32'hE3A01005;  // MOV R1, #5
dut.instr_mem.mem[1] = 32'hE3A0200A;  // MOV R2, #10
dut.instr_mem.mem[2] = 32'hE0813002;  // ADD R3, R1, R2
dut.instr_mem.mem[3] = 32'hE0424001;  // SUB R4, R2, R1
dut.instr_mem.mem[4] = 32'hE0015002;  // AND R5, R1, R2
dut.instr_mem.mem[5] = 32'hE1816002;  // ORR R6, R1, R2
dut.instr_mem.mem[6] = 32'hE2817001;  // ADD R7, R1, #1
dut.instr_mem.mem[7] = 32'hEA000001;  // B #4
dut.instr_mem.mem[8] = 32'hE2818002;  // ADD R8, R1, #2 (skipped)
dut.instr_mem.mem[9] = 32'hE2819003;  // ADD R9, R1, #3
dut.instr_mem.mem[10] = 32'hEAFFFFFE; // B . (loop)

for (int i = 0; i < 64; i++)
dut.data_mem.mem[i] = i * 4;
end

initial begin
$display("=== ARM32 Single-Cycle Processor Testbench ===");
reset = 1;
#10 reset = 0;

for (int i = 0; i < 20; i++) begin
#10;
cycle_count++;
$display("Cycle %0d: PC=0x%08h, Instr=0x%08h", cycle_count, PC, dut.Instr);
if (PC > 32'h00000040) break;
end

$display("\n=== Final Register Values ===");
for (int i = 0; i < 10; i++)
$display("R%0d = %0d", i, dut.datapath_inst.rf.registers[i]);

#10 $finish;
end
endmodule

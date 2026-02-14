// testbench
module testbench();
logic clk;
logic reset;
logic [31:0] WriteDataM, DataAdrM;
logic MemWriteM;

top dut (
.clk(clk),
.reset(reset),
.WriteDataM(WriteDataM),
.DataAdrM(DataAdrM),
.MemWriteM(MemWriteM)
);

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
$display("=== ARM Pipelined Processor Test ===");
reset = 1;
#22;
reset = 0;
$display("Reset released at time %0t", $time);
end

always @(negedge clk) begin
if (MemWriteM) begin
$display("MEM[%3d] = %3d (0x%h) at time %0t",
DataAdrM, WriteDataM, WriteDataM, $time);
if (DataAdrM == 32'd100 && WriteDataM == 32'd7) begin
$display("SUCCESS! Value 7 written to address 100");
#50;
$stop;
end
end
end

initial begin
#5000;
$display("TIMEOUT");
$stop;
end
endmodule

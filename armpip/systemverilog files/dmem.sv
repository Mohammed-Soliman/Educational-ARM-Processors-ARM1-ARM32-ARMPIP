// data memory
module dmem (
input logic clk, we,
input logic [31:0] a, wd,
output logic [31:0] rd
);
reg [31:0] RAM[0:63];
integer i;

initial begin
for (i = 0; i < 64; i = i + 1)
RAM[i] = 32'd0;
end

assign rd = RAM[a[31:2]];

always @(posedge clk)
if (we) RAM[a[31:2]] <= wd;
endmodule

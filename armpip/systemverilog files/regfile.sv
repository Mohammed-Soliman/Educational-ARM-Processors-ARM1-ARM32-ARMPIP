// register file
module regfile (
input logic clk,
input logic we3,
input logic [3:0] ra1, ra2, wa3,
input logic [31:0] wd3, r15,
output logic [31:0] rd1, rd2
);
reg [31:0] rf[0:14];
integer i;

initial begin
for (i = 0; i < 15; i = i + 1)
rf[i] = 32'd0;
end

always @(posedge clk)
if (we3) rf[wa3] <= wd3;

assign rd1 = (ra1 == 4'b1111) ? r15 : rf[ra1];
assign rd2 = (ra2 == 4'b1111) ? r15 : rf[ra2];
endmodule

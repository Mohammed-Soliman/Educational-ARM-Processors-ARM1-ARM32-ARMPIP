// memory
module memory (
input logic clk,
input logic mem_write,
input logic [3:0] address,
input logic [7:0] write_data,
output logic [7:0] read_data
);
logic [7:0] mem [0:15];

initial begin
mem[0] = 8'b11001100;  // LDA 12
mem[1] = 8'b11011101;  // LDB 13
mem[2] = 8'b00000000;  // ADD
mem[3] = 8'b00100000;  // OR
mem[4] = 8'b11101110;  // STR 14
mem[5] = 8'b10100000;  // OUT
mem[6] = 8'b11110000;  // HLT
mem[7] = 8'b00000000;
mem[8] = 8'b00000000;
mem[9] = 8'b00000000;
mem[10] = 8'b00000000;
mem[11] = 8'b00000000;
mem[12] = 8'h05;
mem[13] = 8'h03;
mem[14] = 8'h00;
mem[15] = 8'h00;
end

assign read_data = mem[address];

always @(posedge clk) begin
if (mem_write)
mem[address] <= write_data;
end
endmodule

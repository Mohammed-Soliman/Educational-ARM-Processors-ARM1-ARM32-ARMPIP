// control unit
module control_unit (
input logic clk, reset,
input logic [3:0] opcode,
output logic pc_write,
output logic pc_sel,
output logic res_sel,
output logic mem_write,
output logic ir_write,
output logic ac_write,
output logic b_write,
output logic o_write,
output logic [2:0] alu_control,
output logic [1:0] state
);
logic [1:0] current_state, next_state;
logic halted;

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

always_ff @(posedge clk or posedge reset) begin
if (reset) begin
current_state <= S0;
halted <= 1'b0;
end else begin
if (!halted)
current_state <= next_state;
if (current_state == S1 && opcode == 4'b1111)
halted <= 1'b1;
end
end

always_comb begin
if (halted) begin
next_state = current_state;
end else begin
case (current_state)
S0: next_state = S1;
S1: begin
if (opcode == 4'b1111)
next_state = S0;
else
next_state = S2;
end
S2: begin
if (opcode inside {4'b0000, 4'b0001, 4'b0010, 4'b0011})
next_state = S3;
else
next_state = S0;
end
S3: next_state = S0;
default: next_state = S0;
endcase
end
end

always_comb begin
pc_write = 1'b0;
pc_sel = 1'b0;
res_sel = 1'b0;
mem_write = 1'b0;
ir_write = 1'b0;
ac_write = 1'b0;
b_write = 1'b0;
o_write = 1'b0;
alu_control = 3'b000;

if (halted) begin
end else begin
case (current_state)
S0: begin
pc_sel = 1'b0;
ir_write = 1'b1;
end
S1: begin
pc_write = 1'b1;
end
S2: begin
case (opcode)
4'b1100: begin
pc_sel = 1'b1;
res_sel = 1'b1;
ac_write = 1'b1;
end
4'b1101: begin
pc_sel = 1'b1;
b_write = 1'b1;
end
4'b1110: begin
pc_sel = 1'b1;
mem_write = 1'b1;
end
4'b0000: alu_control = 3'b000;
4'b0001: alu_control = 3'b001;
4'b0010: alu_control = 3'b010;
4'b0011: alu_control = 3'b011;
4'b1010: o_write = 1'b1;
default: ;
endcase
end
S3: begin
res_sel = 1'b0;
if (opcode inside {4'b0000, 4'b0001, 4'b0010, 4'b0011})
ac_write = 1'b1;
end
endcase
end
end

assign state = current_state;
endmodule

// datapath
module arm1_datapath (
input logic clk, reset
);
logic [3:0] pc_value, next_pc;
logic [7:0] mem_data;
logic [3:0] opcode, address_field;
logic [7:0] ac_value, b_value, o_value;
logic [7:0] alu_result;

logic pc_write, pc_sel, res_sel;
logic mem_write, ir_write;
logic ac_write, b_write, o_write;
logic [2:0] alu_control;
logic [1:0] state;

logic zero_flag, carry_flag, negative_flag, overflow_flag;

logic [3:0] mem_address;
assign mem_address = pc_sel ? address_field : pc_value;

logic [7:0] ac_input;
assign ac_input = res_sel ? mem_data : alu_result;

logic [7:0] b_input;
assign b_input = mem_data;

assign next_pc = pc_value + 4'h1;

pc PC (
.clk(clk),
.reset(reset),
.pc_write(pc_write),
.next_pc(next_pc),
.pc_value(pc_value)
);

memory MEM (
.clk(clk),
.mem_write(mem_write),
.address(mem_address),
.write_data(ac_value),
.read_data(mem_data)
);

ir IR (
.clk(clk),
.reset(reset),
.ir_write(ir_write),
.instruction_in(mem_data),
.opcode(opcode),
.address_field(address_field)
);

ac AC (
.clk(clk),
.reset(reset),
.ac_write(ac_write),
.ac_in(ac_input),
.ac_out(ac_value)
);

b B (
.clk(clk),
.reset(reset),
.b_write(b_write),
.b_in(b_input),
.b_out(b_value)
);

o O (
.clk(clk),
.reset(reset),
.o_write(o_write),
.o_in(ac_value),
.o_out(o_value)
);

alu ALU (
.a(ac_value),
.b(b_value),
.alu_control(alu_control),
.result(alu_result),
.zero_flag(zero_flag),
.carry_flag(carry_flag),
.negative_flag(negative_flag),
.overflow_flag(overflow_flag)
);

control_unit CTRL (
.clk(clk),
.reset(reset),
.opcode(opcode),
.pc_write(pc_write),
.pc_sel(pc_sel),
.res_sel(res_sel),
.mem_write(mem_write),
.ir_write(ir_write),
.ac_write(ac_write),
.b_write(b_write),
.o_write(o_write),
.alu_control(alu_control),
.state(state)
);
endmodule

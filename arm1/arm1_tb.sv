// testbench
module arm1_tb;
logic clk, reset;

arm1_top processor (.clk(clk), .reset(reset));

initial begin
clk = 0;
forever #10 clk = ~clk;
end

initial begin
reset = 1;
$display("=== ARM1 Processor Testbench ===");
#25;
reset = 0;
#1000;
$display("=== Final Results ===");
$display("AC: %h (%0d)", processor.processor.AC.ac_out, processor.processor.AC.ac_out);
$display("B:  %h (%0d)", processor.processor.B.b_out, processor.processor.B.b_out);
$display("O:  %h (%0d)", processor.processor.O.o_out, processor.processor.O.o_out);
$display("Memory[14]: %h (%0d)", processor.processor.MEM.mem[14], processor.processor.MEM.mem[14]);
$finish;
end

function string get_state_name(logic [1:0] state);
case(state)
2'b00: return "S0";
2'b01: return "S1";
2'b10: return "S2";
2'b11: return "S3";
default: return "??";
endcase
endfunction

function string get_opcode_name(logic [3:0] opcode);
case(opcode)
4'b1100: return "LDA";
4'b1101: return "LDB";
4'b1110: return "STR";
4'b1111: return "HLT";
4'b0000: return "ADD";
4'b0001: return "SUB";
4'b0010: return "OR ";
4'b0011: return "AND";
4'b1010: return "OUT";
default: return "NOP";
endcase
endfunction
endmodule

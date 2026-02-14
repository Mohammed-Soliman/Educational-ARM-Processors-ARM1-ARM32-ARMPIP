// condition check logic
module condcheck (
input logic [3:0] Cond,
input logic [3:0] Flags,
output logic CondEx
);
logic neg, zero, carry, overflow, ge;

assign {neg, zero, carry, overflow} = Flags;
assign ge = (neg == overflow);

always_comb begin
case(Cond)
4'b0000: CondEx = zero;
4'b0001: CondEx = ~zero;
4'b0010: CondEx = carry;
4'b0011: CondEx = ~carry;
4'b0100: CondEx = neg;
4'b0101: CondEx = ~neg;
4'b0110: CondEx = overflow;
4'b0111: CondEx = ~overflow;
4'b1000: CondEx = carry & ~zero;
4'b1001: CondEx = ~(carry & ~zero);
4'b1010: CondEx = ge;
4'b1011: CondEx = ~ge;
4'b1100: CondEx = ~zero & ge;
4'b1101: CondEx = ~(~zero & ge);
4'b1110: CondEx = 1'b1;
4'b1111: CondEx = 1'b0;
endcase
end
endmodule

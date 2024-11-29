module condcheck (
	input wire [3:0] CondE, FlagsE,
	output reg CondExE
);
	wire neg, zero, carry, overflow, ge;

	assign {neg, zero, carry, overflow} = FlagsE;
	assign ge = neg == overflow;
	
	always @(*)
		case (CondE)
			4'b0000: CondExE = zero;
			4'b0001: CondExE = ~zero;
			4'b0010: CondExE = carry;
			4'b0011: CondExE = ~carry;
			4'b0100: CondExE = neg;
			4'b0101: CondExE = ~neg;
			4'b0110: CondExE = overflow;
			4'b0111: CondExE = ~overflow;
			4'b1000: CondExE = carry & ~zero;
			4'b1001: CondExE = ~(carry & ~zero);
			4'b1010: CondExE = ge;
			4'b1011: CondExE = ~ge;
			4'b1100: CondExE = ~zero & ge;
			4'b1101: CondExE = ~(~zero & ge);
			4'b1110: CondExE = 1'b1;
			default: CondExE = 1'bx;
		endcase
endmodule
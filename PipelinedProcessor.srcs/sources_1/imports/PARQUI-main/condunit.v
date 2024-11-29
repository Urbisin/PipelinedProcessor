module condunit (
	input wire clk, reset,

	input wire [3:0] CondE, FlagsE, ALUFlags,
	input wire [1:0] FlagWriteE,

	output wire CondExE,
	output wire [3:0] Flags
);
	wire [1:0] FlagWrite;
    
	flopenr #(2) flagreg1(
		.clk(clk),
		.reset(reset),
		.en(FlagWrite[1]),
		.d(ALUFlags[3:2]),
		.q(Flags[3:2])
	);

	flopenr #(2) flagreg0(
		.clk(clk),
		.reset(reset),
		.en(FlagWrite[0]),
		.d(ALUFlags[1:0]),
		.q(Flags[1:0])
	);
	
	condcheck cc(
		.CondE(CondE),
		.FlagsE(FlagsE),
		.CondExE(CondExE)
	);
    
    assign FlagWrite = FlagWriteE & {2 {CondExE}};
endmodule
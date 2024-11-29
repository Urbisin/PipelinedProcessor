module top (
	input wire clk, reset,

	output wire [31:0] WriteDataM, DataAdr,
	output wire MemWriteM
);
	wire [31:0] PCF, InstrF, ReadDataM;
	
	arm arm(
		.clk(clk),
		.reset(reset),
        .InstrF(InstrF),
        .ReadDataM(ReadDataM),
		.PCF(PCF),
		.MemWriteM(MemWriteM),
		.ALUResultM(DataAdr),
		.WriteDataM(WriteDataM)
	);

	imem imem(
		.a(PCF),
		.rd(InstrF)
	);
	
	dmem dmem(
		.clk(clk),
		.we(MemWriteM),
		.a(DataAdr),
		.wd(WriteDataM),
		.rd(ReadDataM)
	);
endmodule
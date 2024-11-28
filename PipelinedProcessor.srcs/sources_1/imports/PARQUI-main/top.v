module top (
	clk,
	reset,
	WriteDataM,
	DataAdr,
	MemWriteM
);
	input wire clk;
	input wire reset;
	
	output wire [31:0] WriteDataM;
	output wire [31:0] DataAdr;
	output wire MemWriteM;
	
	wire [31:0] PCF;
	wire [31:0] InstrF;
	wire [31:0] ReadDataM;
	
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
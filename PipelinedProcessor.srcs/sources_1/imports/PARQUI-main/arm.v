module arm (
	input wire clk, reset,
	input wire [31:0] InstrF, ReadDataM,
	output wire [31:0] PCF, ALUResultM, WriteDataM,
	output wire MemWriteM
);
	wire [31:0] InstrD; //
	wire [3:0] ALUFlags; //
	wire RegWriteW, ALUSrcE, MemtoRegW, PCSrcW; //
	wire [1:0] RegSrcD, ImmSrcD, ALUControlE; //
	
	reg1 registerarm1(
	    .clk(clk),
	    .reset(reset),
        .InstrF(InstrF),
        .InstrD(InstrD)
	);
	
	controller c(
		.clk(clk),
		.reset(reset),
		.InstrD(InstrD[31:12]),
		.ALUFlags(ALUFlags),
		.ImmSrcD(ImmSrcD),
		.RegSrcD(RegSrcD),
		.MemWriteM(MemWriteM),
		.PCSrcW(PCSrcW),
		.RegWriteW(RegWriteW),
		.MemtoRegW(MemtoRegW),
		.ALUSrcE(ALUSrcE),
		.ALUControlE(ALUControlE)
	);
	
	datapath dp(
		.clk(clk),
		.reset(reset),
		.InstrD(InstrD),
		.RegSrcD(RegSrcD),
		.ImmSrcD(ImmSrcD),
		.ALUControlE(ALUControlE),
		.ALUSrcE(ALUSrcE),
		.PCSrcW(PCSrcW),
		.RegWriteW(RegWriteW),
		.MemtoRegW(MemtoRegW),
		.ReadDataM(ReadDataM),
		.PCF(PCF),
		.ALUFlags(ALUFlags),
		.ALUResultM(ALUResultM),
		.WriteDataM(WriteDataM)
	);
endmodule
module arm (
	clk,
	reset,
	InstrF,
    ReadDataM,
    PCF,
	MemWriteM,
	ALUResultM,
	WriteDataM
);
	input wire clk; //
	input wire reset; //
	input wire [31:0] InstrF; //
	input wire [31:0] ReadDataM; //
	
	output wire [31:0] PCF; //
	output wire MemWriteM; //
	output wire [31:0] ALUResultM; //
	output wire [31:0] WriteDataM; //
	
	wire [31:0] InstrD; //
	wire [3:0] ALUFlags; //
	wire RegWriteW; //
	wire ALUSrcE; //
	wire MemtoRegW; //
	wire PCSrcW; //
	wire [1:0] RegSrcD; //
	wire [1:0] ImmSrcD; //
	wire [1:0] ALUControlE; //
	
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
		.MemtoRegW(MemtoRegW)
	);
	
	datapath dp(
		.clk(clk),
		.reset(reset),
		.InstrD(InstrD),
		.RegSrcD(RegSrcD),
		.ImmSrcD(ImmSrcD),
		.ALUControlE(ALUControlE),
		.ALUSrcE(ALUSrcE),
		.MemWriteM(MemWriteM),
		.PCSrcW(PCSrcW),
		.RegWriteW(RegWriteW),
		.MemtoRegW(MemtoRegW),
		.ReadDataM(ReadDataM),
		.PCF(PCF),
		.ALUFlags(ALUFlags),
		.ALUResultM(ALUResultM),
		.WriteDataM(WriteDataM)
	);
	
	reg1 registerarm1(
	    .clk(clk),
	    .reset(reset),
        .InstrF(InstrF),
        .InstrD(InstrD)
	);
endmodule
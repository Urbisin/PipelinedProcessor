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

	// Hazard Unit
	wire StallF, StallD, FlushE, FlushD;
	wire [1:0] ForwardAE, ForwardBE;
	wire BranchTakenE;

	wire [3:0] RA1D, RA2D, WA3E, WA3M;
	wire RegWriteE, RegWriteM, MemtoRegE,  PCSrcD, PCSrcE, PCSrcM;

	hazard_unit hunit(
		.RA1D(RA1D),
		.RA2D(RA2D),
		.WA3E(WA3E),
		.WA3M(WA3M),
		.RegWriteE(RegWriteE),
		.RegWriteM(RegWriteM),
		.MemtoRegE(MemtoRegE),
		.PCSrcD(PCSrcD),
		.PCSrcE(PCSrcE),
		.PCSrcM(PCSrcM),
		.PCSrcW(PCSrcW),
		.BranchTakenE(BranchTakenE),
		.StallF(StallF),
		.StallD(StallD),
		.FlushE(FlushE),
		.FlushD(FlushD),
		.ForwardAE(ForwardAE),
		.ForwardBE(ForwardBE)
	);

	reg1 registerarm1(
	    .clk(clk),
	    .reset(reset),
		.StallD(~StallD),
		.FlushD(FlushD),
        .InstrF(InstrF),
        .InstrD(InstrD)
	);

	controller c(
		.clk(clk),
		.reset(reset),
		.FlushE(FlushE),
		.RegWriteE(RegWriteE),
		.RegWriteM(RegWriteM),
		.MemtoRegE(MemtoRegE),
		.PCSrcD(PCSrcD),
		.PCSrcE(PCSrcE),
		.PCSrcM(PCSrcM),
		.BranchD(BranchD),
		.BranchTakenE(BranchTakenE),
		.MemWriteM(MemWriteM),
		.InstrD(InstrD[31:12]),
		.ALUFlags(ALUFlags),
		.ImmSrcD(ImmSrcD),
		.RegSrcD(RegSrcD),
		.PCSrcW(PCSrcW),
		.RegWriteW(RegWriteW),
		.MemtoRegW(MemtoRegW),
		.ALUSrcE(ALUSrcE),
		.ALUControlE(ALUControlE)
	);
	
	datapath dp(
		.clk(clk),
		.reset(reset),
		.StallF(StallF),
		.FlushE(FlushE),
		.RA1D(RA1D),
		.RA2D(RA2D),
		.WA3E(WA3E),
		.WA3M(WA3M),
		.BranchTakenE(BranchTakenE),
		.ForwardAE(ForwardAE),
		.ForwardBE(ForwardBE),
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
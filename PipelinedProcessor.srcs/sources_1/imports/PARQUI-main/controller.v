module controller (
	clk,
	reset,
	InstrD,
	ALUFlags,
    ImmSrcD,
    RegSrcD,
    MemWriteM,
    PCSrcW,
    RegWriteW,
    MemtoRegW
);
	input wire clk;
	input wire reset;
	input wire [31:12] InstrD;
	input wire [3:0] ALUFlags;
	
	output wire [1:0] ImmSrcD;
	output wire [1:0] RegSrcD;
	output wire MemWriteM;
	output wire PCSrcW;
	output wire RegWriteW;
	output wire MemtoRegW;
	
	wire PCSrcD;
	wire RegWriteD;
	wire MemtoRegD;
	wire MemWriteD;
	wire [1:0] ALUControlD;
	wire BranchD;
	wire ALUSrcD;
	wire [1:0] FlagWriteD;
	wire [3:0] Flags;
	
	wire PCSrcE;
	wire RegWriteE;
	wire MemtoRegE;
	wire MemWriteE;
	wire [1:0] ALUControlE;
	wire BranchE;
	wire ALUSrcE;
	wire [1:0] FlagWriteE;
	wire [3:0] CondE;
	wire [3:0] FlagsE;
	
	wire CondExE;
	wire PCSrcEA;
	wire RegWriteEA;
	wire MemWriteEA;
	wire BranchEA;
	
	wire PCSrcM;
	wire RegWriteM;
	wire MemtoRegM;
	
	controlunit cut(
		.Op(InstrD[27:26]),
		.Funct(InstrD[25:20]),
		.Rd(InstrD[15:12]),
		.PCSrcD(PCSrcD),
		.RegWriteD(RegWriteD),
		.MemtoRegD(MemtoRegD),
		.MemWriteD(MemWriteD),
		.ALUControlD(AluControlD),
		.BranchD(BranchD),
		.AluSrcD(AluSrcD),
	    .FlagWriteD(FlagWriteD),
		.ImmSrcD(ImmSrcD),
		.RegSrcD(RegSrcD)	
	);
	
	reg2 registerc1(
	    .clk(clk),
	    .reset(reset),
	    .PCSrcD(PCSrcD),
	    .RegWriteD(RegWriteD),
		.MemtoRegD(MemtoRegD),
		.MemWriteD(MemWriteD),
		.ALUControlD(AluControlD),
		.BranchD(BranchD),
		.AluSrcD(AluSrcD),
	    .FlagWriteD(FlagWriteD),
	    .CondD(InstrD[31:28]),
	    .Flags(Flags),
	    .PCSrcE(PCSrcE),
	    .RegWriteE(RegWriteE),
		.MemtoRegE(MemtoRegE),
		.MemWriteE(MemWriteE),
		.ALUControlE(AluControlE),
		.BranchE(BranchE),
		.AluSrcE(AluSrcE),
	    .FlagWriteE(FlagWriteE),
	    .CondE(CondE),
	    .FlagsE(FlagsE)
	);
	
	condunit cu(
		.clk(clk),
		.reset(reset),
		.CondE(CondE),
		.FlagsE(FlagsE),
		.ALUFlags(ALUFlags),
		.FlagWriteE(FlagWriteE),
		.CondExE(CondExE),
		.Flags(Flags)
	);
	
	assign BranchEA = BranchE & CondExE;
	assign PCSrcEA = (PCSrcE & CondExE) | BranchEA;
	assign RegWriteEA = RegWriteE & CondExE;
	assign MemWriteEA = MemWriteE % CondExE;
	
	reg3 registerc2(
	    .clk(clk),
		.reset(reset),
		.PCSrcEA(PCSrcEA),
		.RegWriteEA(RegWriteEA),
		.MemtoRegE(MemtoRegE),
		.MemWriteEA(MemWriteEA),
		.PCSrcM(PCSrcM),
		.RegWriteM(RegWriteM),
		.MemtoRegM(MemtoRegM),
		.MemWriteM(MemWriteM)
	);
	
	reg4 registerc4(
        .clk(clk),
		.reset(reset),
		.PCSrcM(PCSrcM),
		.RegWriteM(RegWriteM),
		.MemtoRegM(MemtoRegM),
		.PCSrcW(PCSrcW),
		.RegWriteW(RegWriteW),
		.MemtoRegW(MemtoRegW)
	);
endmodule
module controller (
	input wire clk, reset

	input wire [31:12] InstrD,
	input wire [3:0] ALUFlags,

	output wire [1:0] ImmSrcD, RegSrcD,
	output wire MemWriteM, PCSrcW, RegWriteW, MemtoRegW
);
	wire PCSrcD, RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD;
	wire [1:0] ALUControlD, FlagWriteD;
	wire [3:0] Flags;
	
	wire PCSrcE, RegWriteE, MemtoRegE, MemWriteE, BranchE, ALUSrcE, CondExE;
	wire [1:0] ALUControlE, FlagWriteE;
	wire [3:0] CondE, FlagsE;
	
	wire PCSrcEA, RegWriteEA, MemWriteEA, BranchEA;
	wire PCSrcM, RegWriteM, MemtoRegM;
	
	controlunit cut(
		.Op(InstrD[27:26]),
		.Funct(InstrD[25:20]),
		.Rd(InstrD[15:12]),
		.PCSrcD(PCSrcD),
		.RegWriteD(RegWriteD),
		.MemtoRegD(MemtoRegD),
		.MemWriteD(MemWriteD),
		.ALUControlD(ALUControlD),
		.BranchD(BranchD),
		.ALUSrcD(ALUSrcD),
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
		.ALUControlD(ALUControlD),
		.BranchD(BranchD),
		.ALUSrcD(ALUSrcD),
	    .FlagWriteD(FlagWriteD),
	    .CondD(InstrD[31:28]),
	    .Flags(Flags),
	    .PCSrcE(PCSrcE),
	    .RegWriteE(RegWriteE),
		.MemtoRegE(MemtoRegE),
		.MemWriteE(MemWriteE),
		.ALUControlE(ALUControlE),
		.BranchE(BranchE),
		.ALUSrcE(ALUSrcE),
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
	
    assign BranchEA = BranchE & CondExE;
	assign PCSrcEA = (PCSrcE & CondExE) | BranchEA;
	assign RegWriteEA = RegWriteE & CondExE;
	assign MemWriteEA = MemWriteE % CondExE;
endmodule
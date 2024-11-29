module datapath (
	input wire clk, reset,
	
	input wire [31:0] InstrD, ReadDataM,
	input wire [1:0] RegSrcD, ImmSrcD, ALUControlE,
	input wire RegWriteW, ALUSrcE, PCSrcW, MemtoRegW,

	output wire [31:0] PCF, ALUResultM, WriteDataM,
	output wire [3:0] ALUFlags
); 
	// Declare internal signals for all pipeline stages
	wire [31:0] PCNext, PCPlus4F;
	
    wire [3:0] RA1D, RA2D;
    wire [31:0] RD1D, RD2D, ExtImmD;
    
	// EX (Execute) stage signals
    wire [31:0] RD2E, ExtImmE;
	
    wire [3:0] WA3E;
    wire [31:0] SrcAE, SrcBE, ALUResultE, WriteDataE;
    
    // MEM (Memory) stage signals
    wire [3:0] WA3M;
    
    // WB (Writeback) stage signals
    wire [31:0] ALUResultW, ReadDataW, ResultW;
    wire [3:0] WA3W;
	  
	// Hazard Unit
	// TODO
	
	mux2 #(32) pcmux(
		.d0(PCPlus4F),
		.d1(ResultW),
		.s(PCSrcW),
		.y(PCNext)
	);
	
	flopr #(32) pcreg(
		.clk(clk),
		.reset(reset),
		.d(PCNext),
		.q(PCF)
	);
	
	adder #(32) pcadd1(
		.a(PCF),
		.b(32'b100),
		.y(PCPlus4F)
	);
	
	//=============== ID Stage ===============//
	
	mux2 #(4) ra1mux(
		.d0(InstrD[19:16]),
		.d1(4'b1111),
		.s(RegSrcD[0]),
		.y(RA1D)
	);
	
	mux2 #(4) ra2mux(
		.d0(InstrD[3:0]),
		.d1(InstrD[15:12]),
		.s(RegSrcD[1]),
		.y(RA2D)
	);
	
	regfile rf(
		.clk(clk),
		.we3(RegWriteW),
		.ra1(RA1D),
		.ra2(RA2D),
		.wa3(WA3W),
		.wd3(ResultW),
		.r15(PCPlus4F),
		.rd1(RD1D),
		.rd2(RD2D)
	);
	
	extend ext(
        .Instr(InstrD[23:0]),
        .ImmSrc(ImmSrcD),
        .ExtImm(ExtImmD)
    );
    
    reg5 registerd1(
        .clk(clk),
        .reset(reset),
        .rd1D(RD1D),
		.rd2D(RD2D),
		.ExtImmD(ExtImmD),
		.wa3D(InstrD[15:12]),
		.rd1E(SrcAE),
		.rd2E(RD2E),
		.ExtImmE(ExtImmE),
		.wa3E(WA3E)
    );
    
	mux2 #(32) srcbmux(
        .d0(RD2E),
        .d1(ExtImmE),
        .s(ALUSrcE),
        .y(SrcBE)
    );
	
	alu alu(
        .a(SrcAE),
        .b(SrcBE),
        .ALUControl(ALUControlE),
        .Result(ALUResultE),
        .ALUFlags(ALUFlags)
    );
    
    reg6 registerd2(
		.clk(clk),
		.reset(reset),
		.ALUResultE(ALUResultE),
		.WriteDataE(WriteDataE),
		.WA3E(WA3E),
		.ALUResultM(ALUResultM),
		.WriteDataM(WriteDataM),
		.WA3M(WA3M)
	);

	reg7 registerd3(
		.clk(clk),
		.reset(reset),
		.ReadDataM(ReadDataM),
		.ALUOutM(ALUResultM),
		.WA3M(WA3M),
		.ReadDataW(ReadDataW),
		.ALUOutW(ALUResultW),
		.WA3W(WA3W)
	);

	mux2 #(32) resultmux(
		.d0(ALUResultW),
		.d1(ReadDataW),
		.s(MemtoRegW),
		.y(ResultW)
	);
endmodule
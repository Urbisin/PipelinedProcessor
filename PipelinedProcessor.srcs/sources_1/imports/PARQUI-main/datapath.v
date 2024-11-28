module datapath (
	clk,
	reset,
	InstrD,
	RegSrcD,
	ImmSrcD,
	ALUControlE,
	ALUSrcE,
	MemWriteM,
	PCSrcW,
	RegWriteW,
	MemtoRegW,
	ReadDataM,
	PCF,
	ALUFlags,
	ALUResultM,
	WriteDataM,
); 
	input wire clk;
	input wire reset;

    input wire [31:0] InstrD;
	input wire [1:0] RegSrcD;
	input wire [1:0] ImmSrcD;
	input wire RegWriteW;
	input wire [1:0] ALUControlE;
	input wire ALUSrcE;
	input wire MemWriteM;
	input wire PCSrcW;
	input wire MemtoRegW;
	input wire [31:0] ReadDataM;
    
    output wire [31:0] PCF;
	output wire [3:0] ALUFlags;
	output wire [31:0] ALUResultM;
	output wire [31:0] WriteDataM;
	
// Declare internal signals for all pipeline stages
	wire [31:0] PCNext;
	wire [31:0] PCPlus4F;
	
	wire [31:0] PCPlus4D;
    wire [3:0] RA1D, RA2D, WA3D;
    wire [31:0] RD1D, RD2D, ExtImmD;
    
	// EX (Execute) stage signals
    wire [31:0] RD1E, RD2E, ExtImmE;
    wire [3:0] WA3E;
    wire [31:0] SrcAE, SrcBE, ALUResultE, WriteDataE;
    
    // MEM (Memory) stage signals
    wire RegWriteM, MemtoRegM;
    wire [3:0] WA3M;
    
    // WB (Writeback) stage signals
    wire [31:0] ALUResultW, ReadDataW, ResultW;
    wire [3:0] WA3W;
    wire PCSrcM;
    
    // Forwarding control signals
    wire [1:0] ForwardAE, ForwardBE;
	  
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
		.clk(~clk),
		.we3(RegWriteW),
		.ra1(RA1D),
		.ra2(RA2D),
		.wa3(WA3W),
		.wd3(ResultW),
		.r15(PCPlus4D),
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
        .
    );
    
	mux2 #(32) srcbmux(
        .d0(WriteDataE),
        .d1(ExtImmE),
        .s(ALUSrcE),
        .y(SrcBE)
    );
	
	alu alu(
        .SrcA(SrcAE),
        .SrcB(SrcBE),
        .ALUControl(ALUControlE),
        .ALUResult(ALUResultE),
        .ALUFlags(ALUFlags)
    );
    
    ex_mem_reg ex_mem(
        .clk(clk),
        .reset(reset),
        .PCSrcE(PCSrcE),
        .RegWriteE(RegWriteE),
        .MemtoRegE(MemtoRegE),
        .MemWriteE(MemWriteE),
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .WA3E(WA3E),
        .PCSrcM(PCSrcM),
        .RegWriteM(RegWriteM),
        .MemtoRegM(MemtoRegM),
        .MemWriteM(MemWriteM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .WA3M(WA3M)
    );
    
    mem_wb_reg mem_wb(
        .clk(clk),
        .reset(reset),
        .PCSrcM(PCSrcM),
        .RegWriteM(RegWriteM),
        .MemtoRegM(MemtoRegM),
        .ReadDataM(ReadDataM),
        .ALUResultM(ALUResultM),
        .WA3M(WA3M),
        .RegWriteW(RegWriteW),
        .MemtoRegW(MemtoRegW),
        .ReadDataW(ReadDataW),
        .ALUResultW(ALUResultW),
        .WA3W(WA3W)
    );
endmodule
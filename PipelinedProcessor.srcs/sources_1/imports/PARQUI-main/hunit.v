module hazard_unit(
    input wire reset,

    input wire [3:0] RA1D, RA2D, WA3E, WA3M,
    input wire RegWriteE, RegWriteM, MemtoRegE, BranchTakenE, PCSrcD, PCSrcE, PCSrcM, PCSrcW,

    output wire StallF, StallD, FlushD, FlushE,
    output wire [1:0] ForwardAE, ForwardBE
);
    wire LDRStall;
    wire PCWrPendingF;

    wire Match_12D_E;

    assign Match_12D_E = (RA1D == WA3E) || (RA2D == WA3E);

    assign PCWrPendingF = PCSrcD + PCSrcE + PCSrcM;
    assign LDRStall = Match_12D_E & MemtoRegE;
    
    assign StallF = reset ? 0 : (LDRStall || PCWrPendingF);
    assign StallD = reset ? 0 : LDRStall;
    assign FlushE = reset ? 0 : (LDRStall || BranchTakenE);
    assign FlushD = reset ? 0 : (PCWrPendingF || PCSrcW || BranchTakenE);
endmodule
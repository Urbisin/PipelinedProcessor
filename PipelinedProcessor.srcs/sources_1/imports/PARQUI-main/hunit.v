module hazard_unit(
    input wire RegWriteM, RegWriteM, MemtoRegE,
    input wire [3:0] RA1E, RA2E, WA3M,
    output wire Match_1E_M, Match_2E_M, Match_1E_W, Match_2E_W,
    output wire ForwardAE,

    input wire [3:0] RA1D, RA2D, WA3E,
    output wire Match_12D_E,
    output wire StallF, StallD, StallE, FlushE
);
    wire ldrstall;

    assign Match_1E_M = (RA1E == WA3M);
    assign Match_2E_M = (RA2E == WA3M);

    assign Match_1E_W = (RA1E == WA3M);
    assign Match_2E_W = (RA2E == WA3M);
    
    if (Match_1E_M & RegWriteM) begin
        assign ForwardAE = 10;
    end
    else if (Match_1E_W & RegWriteW) begin
        assign ForwardAE = 01;
    end
    else begin
        assign ForwardAE = 00;
    end

    assign Match_12D_E = (RA1D == WA3E) | (RA2D == WA3E);
    assign ldrstall = Match_12D_E & MemtoRegE;

    assign StallF = ldrstall;
    assign StallD = ldrstall;
    assign StallE = ldrstall;
    assign FlushE = ldrstall;
endmodule

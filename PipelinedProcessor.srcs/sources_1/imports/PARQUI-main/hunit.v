module hazard_unit(
    input wire RegWriteM, RegWriteM
    input wire [3:0] RA1E, RA2E, WA3M
    output wire Match_1E_M, Match_2E_M, Match_1E_W, Match_2E_W,
    output wire ForwardAE
);
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
endmodule

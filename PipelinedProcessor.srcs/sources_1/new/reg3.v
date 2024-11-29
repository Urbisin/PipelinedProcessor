module reg3(
    input wire clk, reset,

    input wire PCSrcEA, RegWriteEA, MemtoRegE, MemWriteEA,

    output reg PCSrcM, RegWriteM, MemtoRegM, MemWriteM
);
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            PCSrcM <= 0;
            RegWriteM <= 0;
            MemtoRegM <= 0;
            MemWriteM <= 0;
        end
        else begin
            PCSrcM <= PCSrcEA;
            RegWriteM <= RegWriteEA;
            MemtoRegM <= MemtoRegE;
            MemWriteM <= MemWriteEA;
        end
    end
endmodule

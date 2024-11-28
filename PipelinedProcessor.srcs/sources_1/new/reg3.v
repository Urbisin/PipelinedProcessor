module reg3(
    clk,
    reset,
    PCSrcEA,
    RegWriteEA,
    MemtoRegE,
    MemWriteEA,
    PCSrcM,
    RegWriteM,
    MemtoRegM,
    MemWriteM
);
    input wire clk;
    input wire reset;
    
    input wire PCSrcEA;
    input wire RegWriteEA;
    input wire MemtoRegE;
    input wire MemWriteEA;
    
    output reg PCSrcM;
    output reg RegWriteM;
    output reg MemtoRegM;
    output reg MemWriteM;
    
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

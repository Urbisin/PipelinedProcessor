module reg4(
    input wire clk, reset,
    input wire PCSrcM, RegWriteM, MemtoRegM,

    output reg PCSrcW, RegWriteW, MemtoRegW
);
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            PCSrcW <= 0;
            RegWriteW <= 0;
            MemtoRegW <= 0;
        end
        else begin
            PCSrcW <= PCSrcM;
            RegWriteW <= RegWriteM;
            MemtoRegW <= MemtoRegM;
        end
    end
endmodule

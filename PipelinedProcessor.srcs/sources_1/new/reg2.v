module reg2(
    input wire clk, reset,
    input wire PCSrcD, RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD, isMOVD,
    input wire [2:0] ALUControlD,
    input wire [1:0] FlagWriteD,
    input wire [3:0] CondD, Flags,
    output reg PCSrcE, RegWriteE, MemtoRegE, MemWriteE, BranchE, ALUSrcE, isMOVE,
    output reg [2:0] ALUControlE,
    output reg [1:0] FlagWriteE,
    output reg [3:0] CondE, FlagsE
);	
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            PCSrcE <= 0;
            RegWriteE <= 0;
            MemtoRegE <= 0;
            MemWriteE <= 0;
            ALUSrcE <= 0;
            BranchE <= 0;
            FlagWriteE <= 2'b00;
            FlagsE <= 4'b0000;
            ALUControlE <= 3'b000;
            CondE <= 4'b0000;
            isMOVE <= 0;
        end
        else begin
            PCSrcE <= PCSrcD;
            RegWriteE <= RegWriteD;
            MemtoRegE <= MemtoRegD;
            MemWriteE <= MemWriteD;
            ALUSrcE <= ALUSrcD;
            BranchE <= BranchD;
            FlagWriteE <= FlagWriteD;
            FlagsE <= Flags;
            ALUControlE <= ALUControlD;
            CondE <= CondD;
            isMOVE <= isMOVD;
        end
    end
endmodule

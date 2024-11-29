module reg2(
    input wire clk, reset,

    input wire PCSrcD, RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD
    input wire [1:0] ALUControlD, FlagWriteD,
    input wire [3:0] CondD, Flags,

    output reg PCSrcE, RegWriteE, MemtoRegE, MemWriteE, BranchE, ALUSrcE
    output reg [1:0] ALUControlE, FlagWriteE,
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
            ALUControlE <= 2'b00;
            CondE <= 4'b0000;
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
        end
    end
endmodule

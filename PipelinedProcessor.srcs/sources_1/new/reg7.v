module reg7(
    input wire clk,
    input wire reset,

    input wire [31:0] ReadDataM,
    input wire [31:0] ALUOutM,
    input wire [3:0] WA3M,

    output reg [31:0] ReadDataW,
    output reg [31:0] ALUOutW,
    output reg [3:0] WA3W
);
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            ReadDataW <= 32'b0;
            ALUOutW <= 32'b0;
            WA3W <= 4'b0;
        end
        else begin
            ReadDataW <= ReadDataM;
            ALUOutW <= ALUOutM;
            WA3W <= WA3M;
        end
    end

endmodule
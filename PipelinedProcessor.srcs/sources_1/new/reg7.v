module reg7(
    input wire clk, reset

    input wire [31:0] ReadDataM, ALUOutM,
    input wire [3:0] WA3M,

    output reg [31:0] ReadDataW, ALUOutW,
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
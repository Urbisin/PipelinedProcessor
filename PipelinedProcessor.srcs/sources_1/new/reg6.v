module reg6(
    input wire clk,
    input wire reset,

    input wire [31:0] ALUResultE,
    input wire [31:0] WriteDataE,
    input wire [4:0] WA3E,

    output wire [31:0] ALUResultM,
    output wire [31:0] WriteDataM,
    output wire [4:0] WA3M
);
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            ALUResultM <= 32'b0;
            WriteDataM <= 32'b0;
            WA3M <= 5'b0;
        end
        else begin
            ALUResultM <= ALUResultE;
            WriteDataM <= WriteDataE;
            WA3M <= WA3E;
        end
    end

endmodule
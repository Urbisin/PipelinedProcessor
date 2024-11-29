module reg6(
    input wire clk, reset,

    input wire [31:0] ALUResultE, WriteDataE,
    input wire [3:0] WA3E,

    output reg [31:0] ALUResultM, WriteDataM,
    output reg [3:0] WA3M
);
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            ALUResultM <= 32'b0;
            WriteDataM <= 32'b0;
            WA3M <= 4'b0;
        end
        else begin
            ALUResultM <= ALUResultE;
            WriteDataM <= WriteDataE;
            WA3M <= WA3E;
        end
    end

endmodule
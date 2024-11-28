module reg5(
    input wire clk,
    input wire reset,

    input wire [31:0] rd1E,
    input wire [31:0] rd2E,
    input wire [31:0] ExtImmE,

    output wire [31:0] rd1D,
    output wire [31:0] rd2E,
    output wire [31:0] ExtImmD
);
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            rd1E <= 32'b0;
            rd2E <= 32'b0;
            ExtImmE <= 32'b0;
        end
        else begin
            rd1D <= rd1E;
            rd2D <= rd2E;
            ExtImmD <= ExtImmE;
        end
    end
endmodule
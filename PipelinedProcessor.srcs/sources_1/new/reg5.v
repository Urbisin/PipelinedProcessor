module reg5(
    input wire clk,
    input wire reset,

    input wire [31:0] rd1D, 
    input wire [31:0] rd2D,
    input wire [31:0] ExtImmD,

    output wire [31:0] rd1E,
    output wire [31:0] rd2E,
    output wire [31:0] ExtImmE
);
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            rd1E <= 32'b0;
            rd2E <= 32'b0;
            ExtImmE <= 32'b0;
        end
        else begin
            rd1E <= rd1D;
            rd2E <= rd2D;
            ExtImmD <= ExtImmE;
        end
    end
endmodule
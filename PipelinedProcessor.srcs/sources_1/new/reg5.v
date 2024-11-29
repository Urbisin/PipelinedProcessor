module reg5(
    input wire clk, reset,

    input wire [31:0] rd1D, rd2D, ExtImmD,
    
    output reg [31:0] rd1E, rd2E, ExtImmE,
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
            ExtImmE <= ExtImmD;
        end
    end
endmodule
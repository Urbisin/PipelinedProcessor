module reg5(
    input wire clk, reset,

    input wire FlushE,
    input wire [31:0] rd1D, rd2D, ExtImmD, 
    input wire [3:0] wa3D,
    
    output reg [31:0] rd1E, rd2E, ExtImmE,
    output reg [3:0] wa3E
);
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            rd1E <= 32'b0;
            rd2E <= 32'b0;
            ExtImmE <= 32'b0;
            wa3E <= 4'b0;
        end
        else begin
            if (FlushE) begin
                rd1E <= 32'b0;
                rd2E <= 32'b0;
                ExtImmE <= 32'b0;
                wa3E <= 4'b0;
            end
            else begin
                rd1E <= rd1D;
                rd2E <= rd2D;
                ExtImmE <= ExtImmD;
                wa3E <= wa3D;
            end
        end
    end
endmodule
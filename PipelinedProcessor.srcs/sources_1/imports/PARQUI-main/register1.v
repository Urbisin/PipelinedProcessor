module register1 (
    clk,
    reset,
    InstrF,
    InstrD
);
    input wire clk;
    input wire reset;
    
    input wire [31:0] InstrF;
    
    output reg [31:0] InstrD;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            InstrD <= 32'b0;
        end
        else begin
            InstrD <= InstrF;
        end
    end
endmodule
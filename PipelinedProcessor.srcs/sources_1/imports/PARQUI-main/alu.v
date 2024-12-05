module alu(
    input [31:0] a, b,
    input [2:0] ALUControl,
    input isMOVE,                // Señal para identificar MOV
    
    output reg [31:0] Result,
    output wire [3:0] ALUFlags
);
    wire neg, zero, carry, overflow;
    wire [31:0] condinvb;
    wire [32:0] sum;

    // Ajuste para manejar resta correctamente
    assign condinvb = ALUControl[0] ? ~b : b; // Complemento solo para SUB
    assign sum = a + condinvb + ALUControl[0]; // Añadir 1 solo para SUB

    always @(*) begin
        casex (ALUControl[2:0])
            3'b000: Result = isMOVE ? b : sum;               // ADD
            3'b001: Result = sum;               // SUB
            3'b010: Result = a & b;            // AND
            3'b011: Result = a | b;            // ORR
            default: Result = 32'bx;           // Indefinido
        endcase
    end    

    // Cálculo de banderas
    assign neg = Result[31];
    assign zero = (Result == 32'b0);
    assign carry = (ALUControl[1] == 1'b0) & sum[32];
    assign overflow = (ALUControl[1] == 1'b0) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);
    assign ALUFlags = {neg, zero, carry, overflow};
endmodule

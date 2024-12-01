module controlunit (
    input wire [1:0] Op,
    input wire [5:0] Funct,
    input wire [3:0] Rd,

    output wire PCSrcD, RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD,
    output reg isMOVD,               // Señal para MOV
    output reg [2:0] ALUControlD,    // Control de la ALU
    output reg [1:0] FlagWriteD,     // Escritura de banderas
    output wire [1:0] ImmSrcD, RegSrcD
);
    reg [9:0] controls;
    wire Branch, ALUOp;

    // Control principal basado en Op y Funct
    always @(*) begin
        casex (Op)
            2'b00: // Data Processing Instructions
                case (Funct[4:1])
                    4'b1101: // MOV (Shift o Immediate)
                        if (Funct[5]) // I = 1 (Immediate)
                            controls = 10'b0001101001; // ALUSrcD = 1, RegWriteD = 1
                        else
                            controls = 10'b0000101001; // ALUSrcD = 0, RegWriteD = 1
                    4'b1010: // CMP
                        if (Funct[5]) // I = 1 (Immediate)
                            controls = 10'b0000100011; // ALUSrcD = 1, RegWriteD = 0, FlagWriteD = 1
                        else
                            controls = 10'b0000000011; // ALUSrcD = 0, RegWriteD = 0, FlagWriteD = 1
                    default:
                        if (Funct[5]) // Otras DP
                            controls = 10'b0000101001;
                        else
                            controls = 10'b0000001001;
                endcase
            2'b01: // Memory Instructions
                if (Funct[0])
                    controls = 10'b0001111000;
                else
                    controls = 10'b1001110100;
            2'b10: // Branch Instructions
                controls = 10'b0110100010;
            default:
                controls = 10'bxxxxxxxxxx;
        endcase
    end

    // Desempaquetar señales de control
    assign {RegSrcD, ImmSrcD, ALUSrcD, MemtoRegD, RegWriteD, MemWriteD, BranchD, ALUOp} = controls;

    // Configuración de ALUControlD, FlagWriteD, y isMOVD
    always @(*) begin
        if (ALUOp) begin
            case (Funct[4:1])
                4'b0100: begin
                    ALUControlD = 3'b000; // ADD
                    isMOVD = 0;
                    FlagWriteD[1] = Funct[0]; // S = 1 para actualizar las banderas
                    FlagWriteD[0] = Funct[0];
                end
                4'b0010: begin
                    ALUControlD = 3'b001; // SUB
                    isMOVD = 0;
                    FlagWriteD[1] = Funct[0]; // S = 1 para actualizar las banderas
                    FlagWriteD[0] = Funct[0];
                end
                4'b0000: begin
                    ALUControlD = 3'b010; // AND
                    isMOVD = 0;
                    FlagWriteD[1] = Funct[0];
                    FlagWriteD[0] = Funct[0];
                end
                4'b1100: begin
                    ALUControlD = 3'b011; // ORR
                    isMOVD = 0;
                    FlagWriteD[1] = Funct[0];
                    FlagWriteD[0] = Funct[0];
                end
                4'b1101: begin
                    ALUControlD = 3'b000; // MOV
                    isMOVD = 1;           // Activar señal para MOV
                    FlagWriteD = 2'b00;  // MOV no actualiza banderas
                end
                4'b1010: begin
                    ALUControlD = 3'b000; // CMP (usando SUB)
                    isMOVD = 0;
                    FlagWriteD = 2'b11;  // CMP siempre actualiza todas las banderas
                end
                4'b1001: begin
                    ALUControlD = 3'b100; // MUL
                    isMOVD = 0;
                    FlagWriteD = 2'b00;  // MUL no actualiza banderas
                end
                4'b1110: begin
                    ALUControlD = 3'b101; // UDIV
                    isMOVD = 0;
                    FlagWriteD = 2'b00;  // UDIV no actualiza banderas
                end
                default: begin
                    ALUControlD = 3'bxxx;
                    isMOVD = 0;
                    FlagWriteD = 2'b00;
                end
            endcase
        end else begin
            ALUControlD = 3'b000;
            isMOVD = 0;
            FlagWriteD = 2'b00;
        end
    end

    // Control de Branch e instrucciones de salto
    assign PCSrcD = ((Rd == 4'b1111) & RegWriteD) | BranchD;
endmodule

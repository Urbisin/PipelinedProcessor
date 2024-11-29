module pipelined;
    reg clk;
    reg reset;
    wire [31:0] WriteDataM;
    wire [31:0] DataAdr;
    wire MemWriteM;
    
    // Se asume que el módulo `top` contiene la lógica del procesador pipelined
    top dut (
        .clk(clk),
        .reset(reset),
        .WriteDataM(WriteDataM),
        .DataAdr(DataAdr),
        .MemWriteM(MemWriteM)
    );

    // Generación de la señal de reset
    initial begin
        reset <= 1;
        #(15);
        reset <= 0;
    end

    // Generación del reloj
    always begin
        clk <= 1;
        #(5);  // Ciclo alto de 5 unidades de tiempo
        clk <= 0;
        #(5);  // Ciclo bajo de 5 unidades de tiempo
    end
    // Opcional: Mostrar el estado del pipeline en cada ciclo
    always @(posedge clk) begin
        $display("PC: %h, IF/ID.Instr: %h, ID/EX.Instr: %h", 
                 dut.PCF, dut.arm.InstrD, dut.arm.InstrF);
    end
endmodule

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
        #(20);
        reset <= 0;
    end

    // Generación del reloj
    always begin
        clk <= 1;
        #(5);  // Ciclo alto de 5 unidades de tiempo
        clk <= 0;
        #(5);  // Ciclo bajo de 5 unidades de tiempo
    end

    // Monitor de señales para validación de datos en etapas del pipeline
    always @(negedge clk) begin
        // Ejemplo de validación del acceso a memoria en la etapa MEM
        if (MemWriteM) begin
            $display("At time %0t: Memory Write - Addr: %h, Data: %h", $time, DataAdr, WriteDataM);
        end

        // Verificación de resultados en el Write Back (WB)
        if ((DataAdr === 100) & (WriteDataM === 7)) begin
            $display("Simulation succeeded at time %0t", $time);
            $stop;
        end else if (DataAdr !== 96 && reset == 0) begin
            $display("Simulation failed at time %0t", $time);
            $stop;
        end
    end

    // Opcional: Mostrar el estado del pipeline en cada ciclo
    always @(posedge clk) begin
        $display("PC: %h, IF/ID.Instr: %h, ID/EX.Instr: %h", 
                 dut.PCF, dut.arm.InstrD, dut.arm.InstrF);
    end
endmodule

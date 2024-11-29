module tb_top;
    reg clk, reset;
    wire [31:0] WriteDataM, DataAdr;
    wire MemWriteM;

    // Instancia del módulo top
    top uut (
        .clk(clk),
        .reset(reset),
        .WriteDataM(WriteDataM),
        .DataAdr(DataAdr),
        .MemWriteM(MemWriteM)
    );

    // Generación del reloj
    always #5 clk = ~clk;

    // Inicialización
    initial begin
        clk = 0;
        reset = 1;
        #15 reset = 0; // Desactiva reset después de 15 ns
        #500 $finish;  // Termina la simulación después de 500 ns
    end

    // Monitoreo de señales
    always @(posedge clk) begin
        $display("PC: %h, MemWriteM: %b, DataAdr: %h, WriteDataM: %h", 
                 uut.PCF, MemWriteM, DataAdr, WriteDataM);
    end
endmodule

module pipelined;
    reg clk;
    reg reset;
    wire [31:0] WriteDataM;
    wire [31:0] DataAdr;
    wire MemWriteM;
    
    top dut (
        .clk(clk),
        .reset(reset),
        .WriteDataM(WriteDataM),
        .DataAdr(DataAdr),
        .MemWriteM(MemWriteM)
    );

    initial begin
        reset <= 1;
        #(15);
        reset <= 0;
    end

    always begin
        clk <= 1;
        #(5);
        clk <= 0;
        #(5);
    end
    // Opcional: Mostrar el estado del pipeline en cada ciclo
    always @(posedge clk) begin
        $display("PC: %h, IF/ID.Instr: %h, ID/EX.Instr: %h", dut.PCF, dut.arm.InstrD, dut.arm.InstrF);
    end
endmodule

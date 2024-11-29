module tb_imem;
    reg [31:0] a;         // Dirección de memoria
    wire [31:0] rd;       // Instrucción leída
    
    // Instancia del módulo imem
    imem uut (
        .a(a),
        .rd(rd)
    );
    
    initial begin
        $display("Testing Instruction Memory");
        
        // Prueba de la primera instrucción
        a = 32'h00000000; #10;
        $display("Addr: %h, Data: %h (Expected: E04F000F)", a, rd);

        // Prueba de la segunda instrucción
        a = 32'h00000004; #10;
        $display("Addr: %h, Data: %h (Expected: E2802005)", a, rd);

        // Dirección fuera de rango (espera 0)
        a = 32'h00000008; #10;
        $display("Addr: %h, Data: %h (Expected: 00000000)", a, rd);

        $finish;
    end
endmodule

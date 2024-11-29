module pipelined;
	reg clk;
	reg reset;
	wire [31:0] WriteDataM;
	wire [31:0] DataAdr;
	wire MemWriteM;
	
	top dut(
		.clk(clk),
		.reset(reset),
		.WriteDataM(WriteDataM),
		.DataAdr(DataAdr),
		.MemWriteM(MemWriteM)
	);
	initial begin
		reset <= 1;
		#(20)
			;
		reset <= 0;
	end
	always begin
		clk <= 1;
		#(5)
			;
		clk <= 0;
		#(5)
			;
	end
	always @(negedge clk)
		if (MemWriteM) begin
		  $display("Maykol es gay");
		  $stop;
		end
		else begin
		  $display("At time %0t, signal = %b", $time, dut.InstrF);
		  $display("At time %0t, signal = %b", $time, dut.arm.InstrD);
		end
//			if ((DataAdr === 100) & (WriteDataM === 7)) begin
//				$display("Simulation succeeded");
//				$stop;
//			end
//			else if (DataAdr !== 96) begin
//				$display("Simulation failed");
//				$stop;
//			end

            
endmodule
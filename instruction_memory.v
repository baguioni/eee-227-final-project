// 8-bit addressing
// 8-bit word size
module instruction_memory(
	input [7:0] Address, 
	output wire [15:0] ReadData 
);

	// Fix this later to be 8 bit
	reg [15:0] memory [63:0];

	initial begin
		$display("Initializing instruction memory");
		$readmemb("instruction.dat", memory);
	end

	// reads are combinational operations
	assign ReadData = memory[Address];
	
endmodule
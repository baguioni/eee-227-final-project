// 8-bit addressing
// 8-bit word size
module data_memory(
	input CLK, 
	input [7:0] Address, 
	input [7:0] WriteData, 
	input MemWriteEnable, // write data
	output wire [7:0] ReadData 
);
	// 8-bit wide word
	// 256-bytes storage
	reg [7:0] memory [255:0];

	// initialize memory values to 0
	integer i;
	initial begin
		$display("Initializing data memory");
		for(i=0; i< 255; i=i+1) begin
			memory[i] = 7'b0;
		end
	end

	// writes are synchronous operations
	always @(posedge CLK) begin
		if (MemWriteEnable == 1'b1) begin
			$display("Address: %d Data: %d", Address, WriteData);
			memory[Address] <= WriteData;
		end
	end

	// reads are combinational operations
	assign ReadData = memory[Address];
	
endmodule
module register_file(
	input CLK, WriteEnable,
	input [3:0] ReadAddress1, ReadAddress2, // read port address
	input [3:0] WriteAddress, // write port address
    input [7:0] WriteData,
	output reg [7:0] OutData1, OutData2
);

	// 8-bit wide word
	// 8 Registers
	reg [7:0] registers [7:0];
 
	// initialize memory values to 0
	integer i;
	initial begin
		$display("Initializing register file");
		for(i=0; i< 15; i=i+1) begin
			registers[i] = i;
		end
	end

    // Writes are only during posedge of clock
	always @(posedge CLK) begin
		if (WriteEnable == 1'b1) begin
			registers[WriteAddress] <= WriteData;
			$display("Register Write Occured - WriteData: %b WriteAddress: %b", WriteData, WriteAddress);
		end
	end

	always @(*) begin
		// Read can be done at anytime
		OutData1 <= registers[ReadAddress1];
		OutData2 <= registers[ReadAddress2];
		$display("OutData1: %b OutData2: %b", OutData1, OutData2);
	end


endmodule
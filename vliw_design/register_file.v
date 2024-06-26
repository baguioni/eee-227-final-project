module register_file(
	input CLK, WriteEnable1, WriteEnable2,
	input [3:0] ReadAddress1, ReadAddress2, ReadAddress3, // read port address
	input [3:0] WriteAddress1, WriteAddress2, // write port address
    input [7:0] WriteData1, WriteData2,
	output reg [7:0] OutData1, OutData2, OutData3
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
		if (WriteEnable1 == 1'b1) begin
			registers[WriteAddress1] <= WriteData1;
			$display("Register Write 1 Occured - WriteData: %b WriteAddress: %b", WriteData1, WriteAddress1);
		end

		if (WriteEnable2 == 1'b1) begin
			registers[WriteAddress2] <= WriteData2;
			$display("Register Write 2 Occured - WriteData: %b WriteAddress: %b", WriteData2, WriteAddress2);
		end
	end

	always @(*) begin
		// Read can be done at anytime
		OutData1 = registers[ReadAddress1];
		OutData2 = registers[ReadAddress2];
		OutData3 = registers[ReadAddress3];
		$display("Register Read OutData1: %b OutData2: %b", OutData1, OutData2);
	end


endmodule
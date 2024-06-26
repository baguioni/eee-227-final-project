`timescale 1ns / 1ps

module tb_data_memory;
	reg CLK = 0;
	reg MemWriteEnable, MemRead;
	reg [7:0] Address;
	reg [7:0] WriteData;
	wire [7:0] ReadData;

	data_memory uut(
		.CLK(CLK),
		.Address(Address), 
		.WriteData(WriteData), 
		.MemWriteEnable(MemWriteEnable), 
		.ReadData(ReadData)
	);

	initial begin
		CLK = 1'b0;
		forever begin
			#10 CLK = ~CLK;
		end
	end

	initial begin
		Address= 8'b0; WriteData=8'b11111111; MemWriteEnable=1;       // write data
		$display("Write: time=%3d CLK=%b Address=%b WriteData=%b MemWrite=%b ", $time, CLK, Address, WriteData, MemWriteEnable);
		#10
		$display("Read: time=%3d CLK=%b Address=%b ReadData=%b", $time, CLK, Address, ReadData);
		#10
		Address= 8'b0; WriteData=8'b000; MemWriteEnable=0;       // cant write data
		$display("Write: time=%3d CLK=%b Address=%b WriteData=%b MemWrite=%b ", $time, CLK, Address, WriteData, MemWriteEnable);
		#10
		$display("Read: time=%3d CLK=%b Address=%b ReadData=%b", $time, CLK, Address, ReadData);

		$finish;
	end

endmodule

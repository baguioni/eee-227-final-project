`timescale 1ns / 1ps
module tb_cpu();
	reg CLK, RESET;
	reg [3:0] counter;
	wire [7:0] ALUResult, PC_in, PC_out;
	wire [31:0] Instruction;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.CLK(CLK),
		.RESET(RESET),
		.Instruction(Instruction),
		.ALUResult(ALUResult),
		.PC_in(PC_in),
		.PC_out(PC_out)
	);

	initial begin
		RESET <= 1; # 5; RESET <= 0; 
	end


	// generate clock to sequence tests always
	always
	begin
		CLK <= 1; # 5; CLK <= 0; # 5; 
	end

	integer i;
	always @(negedge CLK) begin
		$display("Instruction: %b", Instruction);
		$display("PC_in: %b", PC_in);
		$display("PC_out: %b", PC_out);
		$display("ALUResult: %b", $signed(ALUResult));

		// if (Instruction == 32'b)
		#1000;
		$finish;
	end
endmodule


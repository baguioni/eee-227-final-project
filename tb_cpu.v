`timescale 1ns / 1ps
module tb_cpu();
	reg CLK, RESET;
	reg [3:0] counter;
	wire [7:0] ALUResult;
	wire [15:0] Instruction;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.CLK(CLK),
		.RESET(RESET),
		.Instruction(Instruction),
		.ALUResult(ALUResult)
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
		$display("ALUResult: %b", $signed(ALUResult));

		#50;
		$finish;
	end
endmodule


module control_unit(
    input [2:0] OpCode, 
    output reg RegWriteEnable, MemWriteEnable, ResultSrc
);

    // Assign RegWrite
	always @(*) begin
		case(OpCode)
			3'b100: RegWriteEnable <= 1'b0; // STORE Instr
			default: RegWriteEnable <= 1'b1;
		endcase
	end

    // Assign MemWrite
	always @(*) begin
		case(OpCode)
			3'b100: MemWriteEnable <= 1'b1; // STORE Instr
			default: MemWriteEnable <= 1'b0;
		endcase
	end

	// Assign ResultSrc
	always @(*) begin
		case(OpCode)
			3'b000: ResultSrc <= 1'b0; // From Data Memory
			default: ResultSrc <= 1'b1; // From ALU
		endcase
	end

endmodule
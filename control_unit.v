module control_unit(
    input [2:0] OpCode, 
    input AddressingMode,
    input [3:0] Destination,
    input [7:0] Source,
    output reg RegWrite, MemWrite, ResultSrc
);

    // Assign RegWrite
	always @(*) begin
		case(OpCode)
			3'b100: RegWrite = 1'b0; // STORE Instr
			default: RegWrite = 1'b1;
		endcase
	end

    // Assign MemWrite
	always @(*) begin
		case(OpCode)
			3'b100: MemWrite = 1'b1; // STORE Instr
			default: MemWrite = 1'b0;
		endcase
	end

	    // Assign MemWrite
	always @(*) begin
		case(OpCode)
			3'b000: ResultSrc = 1'b0; // From Data Memory
			default: ResultSrc = 1'b1; // From ALU
		endcase
	end


endmodule
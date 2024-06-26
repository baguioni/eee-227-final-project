module control_unit(
	input [15:0] Instr1, Instr2,
    output reg RegWriteEnableA, RegWriteEnableD, MemWriteEnable
);
	// Arithmetic
    // Assign RegWrite1
	always @(*) begin
		case(Instr1[15:13])
			3'b101, // ADD
			3'b110, // SUB
			3'b111, // MUL
			3'b001, // AND
			3'b010, // OR
			3'b011: // XOR
				RegWriteEnableA <= 1'b1;
			default:
				RegWriteEnableA <= 1'b0;
		endcase
	end

	// Load & Store
    // Assign MemWrite
	always @(*) begin
		if (Instr2 == 16'b0) begin 
			MemWriteEnable <= 1'b0;
			RegWriteEnableD <= 1'b0;
		end else begin
			case(Instr2[15:13])
				3'b100: MemWriteEnable <= 1'b1; // STORE Instr
				default: MemWriteEnable <= 1'b0;
			endcase

			// LOAD ops write to register
			case(Instr2[15:13])
				3'b000: RegWriteEnableD <= 1'b1; // LOAD Instr
				default: RegWriteEnableD <= 1'b0;
			endcase
		end

	end


endmodule
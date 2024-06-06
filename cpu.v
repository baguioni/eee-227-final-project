module cpu(
    input CLK, RESET,
    output [7:0] ALUResult, 
    output [15:0] Instruction
);

    wire [7:0] PC_in, PC_out;
    wire RegWrite, MemWrite, ResultSrc;

    wire [7:0] OutData1, OutData2, Result, WriteData, MemoryData;

    program_counter program_counter(
        .CLK(CLK),
        .RST(RESET),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );

    instruction_memory instruction_memory(
        .Address(PC_out),
        .ReadData(Instruction)
    );

    control_unit control_unit(
        .OpCode(Instruction[15:13]),
        .AddressingMode(Instruction[12]),
        .Destination(Instruction[11:8]),
        .Source(Instruction[7:0]),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc)
    );

    register_file register_file(
        .CLK(CLK),
        .WriteEnable(RegWrite),
        .WriteAddress(Instruction[11:8]), 
        .ReadAddress1(Instruction[7:4]),
        .ReadAddress2(Instruction[3:0]),
        .WriteData(WriteData),
        .OutData1(OutData1),
        .OutData2(OutData2)
    );

    alu alu(
        .Control(Instruction[15:13]),
        .SrcA(OutData1),
        .SrcB(OutData2),
        .result(ALUResult)
    );

    // if 1 then b else a
    mux2x1 #(
		.WIDTH(8)
    ) mux2x1_alu_mem (
		.a(MemoryData),
		.b(ALUResult),
		.sel(ResultSrc),
		.out(Result)
	);	

    mux2x1 #(
		.WIDTH(8)
    ) mux2x1_reg (
		.a(Instruction[7:0]),
		.b(Result), // Source
		.sel(Instruction[12]), // Addressing Mode
		.out(WriteData)
	);	

    data_memory data_memory(
        .CLK(CLK),
        .Address(Instruction[7:0]),
        .WriteData(OutData1),
        .MemWriteEnable(MemWrite),
        .ReadData(MemoryData) // From Reg to Data Memory
    );
endmodule
// Focus first on arithmetic operations
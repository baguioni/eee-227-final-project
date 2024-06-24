module cpu(
    input CLK, RESET,
    output [7:0] ALUResult,PC_in, PC_out,
    output [15:0] Instruction
);

    wire [7:0] PC_plus1;
    wire RegWriteEnable, MemWriteEnable, ResultSrc, AddressingMode;

    wire [7:0] OutData1, OutData2, Result, WriteDataReg, WriteDataMem, MemoryData;

    program_counter program_counter(
        .CLK(CLK),
        .RST(RESET),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );

    adder adder_PCPlus1(
        .a(PC_out),
        .b(8'b1),
        .out(PC_plus1)
    );

    assign PC_in = PC_plus1;

    instruction_memory instruction_memory(
        .Address(PC_out),
        .ReadData(Instruction)
    );

    control_unit control_unit(
        .OpCode(Instruction[15:13]),
        .RegWriteEnable(RegWriteEnable),
        .MemWriteEnable(MemWriteEnable),
        .ResultSrc(ResultSrc)
    );

    register_file register_file(
        .CLK(CLK),
        .WriteEnable(RegWriteEnable),
        .WriteAddress(Instruction[11:8]), 
        .ReadAddress1(Instruction[7:4]),
        .ReadAddress2(Instruction[3:0]),
        .WriteData(WriteDataReg),
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
    // Data from ALU or from Memory
    mux2x1 #(
		.WIDTH(8)
    ) mux2x1_alu_mem (
		.a(MemoryData),
		.b(ALUResult),
		.sel(ResultSrc),
		.out(Result)
	);	

    // Data from ALU/Memory or Direct
    mux2x1 #(
		.WIDTH(8)
    ) mux2x1_reg (
		.a(Instruction[7:0]),
		.b(Result), // Source
		.sel(Instruction[12]), // Addressing Mode
		.out(WriteDataReg)
	);	

    data_memory data_memory(
        .CLK(CLK),
        .Address(Instruction[7:0]),
        .WriteData(OutData1), // Reg File to Data Memory
        .MemWriteEnable(MemWriteEnable),
        .ReadData(MemoryData) // Data Memory to Reg File
    );


endmodule
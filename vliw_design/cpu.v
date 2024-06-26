module cpu(
    input CLK, RESET,
    output [7:0] ALUResult, PC_in, PC_out,
    output [31:0] Instruction
);

    wire [7:0] PC_plus1;
    wire RegWriteEnableA, RegWriteEnableD, MemWriteEnable;
    wire [7:0] OutData1, OutData2, OutData3;

    wire [7:0] WriteToReg, ReadFromMem;

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
        .Instr1(Instruction[15:0]),
        .Instr2(Instruction[31:16]),
        .RegWriteEnableA(RegWriteEnableA),
        .RegWriteEnableD(RegWriteEnableD),
        .MemWriteEnable(MemWriteEnable)
    );

    register_file register_file(
        .CLK(CLK),
        .WriteEnable1(RegWriteEnableA),
        .WriteAddress1(Instruction[11:8]), 
        .ReadAddress1(Instruction[7:4]),
        .ReadAddress2(Instruction[3:0]),
        .WriteData1(ALUResult),
        .OutData1(OutData1),
        .OutData2(OutData2),
        .WriteEnable2(RegWriteEnableD),
        .WriteAddress2(Instruction[27:24]), // For load
        .ReadAddress3(Instruction[27:24]), // For store
        .WriteData2(WriteToReg),
        .OutData3(OutData3) // Only need 1 output port for store
    );
    
    alu alu(
        .Control(Instruction[15:13]),
        .SrcA(OutData1),
        .SrcB(OutData2),
        .result(ALUResult)
    );

    // Data from Memory or Immediate for Load operation
    mux2x1 #(
		.WIDTH(8)
    ) mux2x1_immediate_or_mem (
		.a(Instruction[23:16]),
		.b(ReadFromMem), // Source
		.sel(Instruction[28]), // Addressing Mode
		.out(WriteToReg)
	);	

    data_memory data_memory(
        .CLK(CLK),
        .Address(Instruction[23:16]),
        .WriteData(OutData1), // Reg File to Data Memory
        .MemWriteEnable(MemWriteEnable),
        .ReadData(ReadFromMem) // Data Memory to Reg File
    );


endmodule
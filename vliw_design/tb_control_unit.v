`timescale 1ns / 1ps

module tb_control_unit;

    // Inputs
    reg [2:0] OpCode;
    reg AddressingMode;
    reg [3:0] Destination;
    reg [7:0] Source;

    // Outputs
    wire RegWrite;
    wire MemWrite;

    // Instantiate the Unit Under Test (UUT)
    control_unit uut (
        .OpCode(OpCode), 
        .AddressingMode(AddressingMode),
        .Destination(Destination),
        .Source(Source),
        .RegWrite(RegWrite), 
        .MemWrite(MemWrite)
    );

    initial begin
        // Initialize Inputs
        OpCode = 3'b000;
        AddressingMode = 0;
        Destination = 4'b0000;
        Source = 8'b00000000;

        // Wait for global reset
        #10;
        
        // Test Case 1: OpCode = 3'b000 (Default Case)
        OpCode = 3'b000;
        #10;
        $display("Test Case 1: OpCode = 3'b000");
        $display("RegWrite = %b, MemWrite = %b", RegWrite, MemWrite);
        
        // Test Case 2: OpCode = 3'b100 (STORE Instr)
        OpCode = 3'b100;
        #10;
        $display("Test Case 2: OpCode = 3'b100");
        $display("RegWrite = %b, MemWrite = %b", RegWrite, MemWrite);

        // Test Case 3: OpCode = 3'b001 (Another Default Case)
        OpCode = 3'b001;
        #10;
        $display("Test Case 3: OpCode = 3'b001");
        $display("RegWrite = %b, MemWrite = %b", RegWrite, MemWrite);
        $finish;
    end
endmodule

module alu_tb;
    // Testbench signals
    reg [2:0] Control;
    reg [7:0] SrcA;
    reg [7:0] SrcB;
    wire [7:0] result;

    // Instantiate the ALU
    alu uut (
        .Control(Control),
        .SrcA(SrcA),
        .SrcB(SrcB),
        .result(result)
    );

    // Test cases
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;

        // Initialize inputs
        SrcA = 8'b00000000;
        SrcB = 8'b00000000;
        Control = 3'b000;

        #10;
        // Load Istruction, should do nothing
        SrcA = 8'b00000000;
        SrcB = 8'b00000000;
        Control = 3'b000;
        #10;  // Wait for the result
        $display("LOAD Operation: SrcA = %b, SrcB = %b, Result = %b", SrcA, SrcB, result);
        // Apply test cases
        // AND operation
        SrcA = 8'b00000001;
        SrcB = 8'b00000001;
        Control = 3'b001;
        #10;  // Wait for the result
        $display("AND Operation: SrcA = %b, SrcB = %b, Result = %b", SrcA, SrcB, result);

        // OR operation
        SrcA = 8'b00000001;
        SrcB = 8'b00000011;
        Control = 3'b010;
        #10;  // Wait for the result
        $display("OR Operation: SrcA = %b, SrcB = %b, Result = %b", SrcA, SrcB, result);

        // ADD operation
        SrcA = 8'b00000001;
        SrcB = 8'b00000001;
        Control = 3'b101;
        #10;  // Wait for the result
        $display("ADD Operation: SrcA = %d, SrcB = %d, Result = %d", SrcA, SrcB, result);

        // SUB operation
        SrcA = 8'b00000111;
        SrcB = 8'b00000011;
        Control = 3'b110;
        #10;  // Wait for the result
        $display("SUB Operation: SrcA = %d, SrcB = %d, Result = %d", SrcA, SrcB, result);

        // MUL operation
        SrcA = 8'b00000001;
        SrcB = 8'b00000011;
        Control = 3'b111;
        #10;  // Wait for the result
        $display("MUL Operation: SrcA = %d, SrcB = %d, Result = %d", SrcA, SrcB, result);

        // Finish simulation
        $finish;
    end
endmodule
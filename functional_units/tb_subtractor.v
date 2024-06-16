`timescale 1ns / 1ps

module tb_subtractor;

reg signed [7:0] A,B;
wire signed [7:0] D;
wire C;

subtractor uut(.A(A), .B(B), .Diff(D), .Cout(C));

initial begin
    $dumpfile("tb.vcd");
    $dumpvars();

    // Initialize inputs
    A = 0; B = 0;
    #10

    A = 8'd69; B = 8'd42;
    #10
    $display("A = %d, B = %d, Difference = %d, Cout = %d", A, B, D, C);

    A = 8'd42; B = 8'd69;
    #10
    $display("A = %d, B = %d, Difference = %d, Cout = %d", A, B, D, C);

    A = 8'd0; B = 8'd127;
    #10
    $display("A = %d, B = %d, Difference = %d, Cout = %d", A, B, D, C);

    $finish;
end
    

endmodule

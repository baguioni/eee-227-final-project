`timescale 1ns / 1ps

module tb_cla;

reg [7:0] A, B;
reg Cin;
wire [7:0] Sum;
wire Cout;

cla_8bit uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;

    // Initialize inputs
    A = 0; B = 0; Cin = 0;
    #10

    // Add w/out cin and w/out cout
    A = 8'd69; B = 8'd42; Cin = 0;
    #10
    $display("A = %d, B = %d, Cin = %d, Sum = %d, Cout = %d", A, B, Cin, Sum, Cout);

    // add w/ cin and w/out cout
    A = 8'd69; B = 8'd42; Cin = 1;
    #10
    $display("A = %d, B = %d, Cin = %d, Sum = %d, Cout = %d", A, B, Cin, Sum, Cout);
    
    // add w/out cin and w/out cout
    A = 8'd128; B = 8'd128; Cin = 0;
    #10
    $display("A = %d, B = %d, Cin = %d, Sum = %d, Cout = %d", A, B, Cin, Sum, Cout);
    
    // add w/ cin and w/ cout
    A = 8'd128; B = 8'd127; Cin = 1;
    #10
    $display("A = %d, B = %d, Cin = %d, Sum = %d, Cout = %d", A, B, Cin, Sum, Cout);
    $finish;
end
    
endmodule
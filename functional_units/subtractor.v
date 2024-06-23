module subtractor (
    input [7:0] A, B,
    output [7:0] Diff,
    output Cout
);
    wire [7:0] B1 = B ^ 8'hff;
    wire C;

    cla_8bit sub(
        .A(A),
        .B(B1),
        .Cin(1'b1),
        .Sum(Diff),
        .Cout(C)
    );

    assign Cout = C ^ 1'b1;

endmodule
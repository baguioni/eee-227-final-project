// Each is explicitly defined as a module to allow for fine-grained control on how the operation works
// Can optionally modify the adder to be ripple carry adder and so on

module adder(
    input [7:0] a, b,
    output [7:0] out
);
    cla_8bit add(
        .A(a),
        .B(b),
        .Cin(0),
        .Sum(out)
    )
endmodule

module subtractor(
    input [7:0] a, b,
    output [7:0] out
);
    assign out = a - b;
endmodule

module subtractor (
    input [7:0] a, b,
    output [7:0] out,
    // output Cout
);
    wire [7:0] b1 = b ^ 8'hff;
    // wire C;

    cla_8bit sub(
        .A(a),
        .B(b1),
        .Cin(1'b1),
        .Sum(out),
    );

    // assign Cout = C ^ 1'b1;
endmodule

module multiplier(
    input [7:0] a, b,
    output [7:0] out
);
    multiplier_unsigned mul(
        .A(a),
        .B(b),
        .Prod(out)
    )
endmodule

module bitwise_and(
    input [7:0] a, b,
    output [7:0] out
);
    assign out = a & b;
endmodule

module bitwise_or(
    input [7:0] a, b,
    output [7:0] out
);
    assign out = a | b;
endmodule

module bitwise_xor(
    input [7:0] a, b,
    output [7:0] out
);
    assign out = a ^ b;
endmodule


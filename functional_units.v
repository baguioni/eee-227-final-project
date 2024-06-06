// Each is explicitly defined as a module to allow for fine-grained control on how the operation works
// Can optionally modify the adder to be ripple carry adder and so on

module adder(
    input [7:0] a, b,
    output [7:0] out
);
    assign out = a + b;
endmodule

module subtractor(
    input [7:0] a, b,
    output [7:0] out
);
    assign out = a - b;
endmodule

module multiplier(
    input [7:0] a, b,
    output [7:0] out
);
    assign out = a * b;
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


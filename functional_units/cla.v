module cla_8bit (
    input [7:0] A, B,
    input Cin,
    output [7:0] Sum,
    output Cout
);
    wire C;

    cla_4bit adder_0 (
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(Cin),
        .Sum(Sum[3:0]),
        .Cout(C)
    );
    
    cla_4bit adder_1 (
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(C),
        .Sum(Sum[7:4]),
        .Cout(Cout)
    );

endmodule


module cla_4bit(
    input [3:0] A, B,
    input Cin,
    output [3:0] Sum,
    output Cout
);
    wire [3:0] G, P, C;
    
    assign G = A & B; // Generate
    assign P = A ^ B; // Propagate

    // C_i+1 = g_i + P_i . C_i
    assign C[0] = Cin;
    assign C[1] = G[0] | (C[0] & P[0]);
    assign C[2] = G[1] | (G[0] & P[1]) | (C[0] & P[0] & P[1]);
    assign C[3] = G[2] | (G[1] & P[2]) | (G[0] & P[1] & P[2]) | (C[0] & P[0] & P[1] & P[2]);
    assign Cout = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (C[0] & P[0] & P[1] & P[2] & P[3]);
    
    // Sum = A ^ B ^ C
    assign Sum = P ^ C;

endmodule
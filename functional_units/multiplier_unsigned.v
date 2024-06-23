module multiplier_unsigned (
    input [7:0] A, B,
    output [15:0] Prod
);
    // partial products 
    wire [ 7:0] p0,p1,p2,p3,p4,p5,p6,p7;
    // partial sums
    wire [ 7:0] s1,s2,s3,s4,s5,s6,s7;
    // carries from partial sums
    wire c1,c2,c3,c4,c5,c6,c7;

    // partial product computation
    assign p0 = {8{A[0]}} & B;
    assign p1 = {8{A[1]}} & B;
    assign p2 = {8{A[2]}} & B;
    assign p3 = {8{A[3]}} & B;
    assign p4 = {8{A[4]}} & B;
    assign p5 = {8{A[5]}} & B;
    assign p6 = {8{A[6]}} & B;
    assign p7 = {8{A[7]}} & B;
    
    // partial sums computation
    cla_8bit adder_0 ( .A({1'b0,p0[7:1]}), .B(p1), .Cin(1'b0), .Sum(s1), .Cout(c1) );
    cla_8bit adder_1 ( .A({  c1,s1[7:1]}), .B(p2), .Cin(1'b0), .Sum(s2), .Cout(c2) );
    cla_8bit adder_2 ( .A({  c2,s2[7:1]}), .B(p3), .Cin(1'b0), .Sum(s3), .Cout(c3) );
    cla_8bit adder_3 ( .A({  c3,s3[7:1]}), .B(p4), .Cin(1'b0), .Sum(s4), .Cout(c4) );
    cla_8bit adder_4 ( .A({  c4,s4[7:1]}), .B(p5), .Cin(1'b0), .Sum(s5), .Cout(c5) );
    cla_8bit adder_5 ( .A({  c5,s5[7:1]}), .B(p6), .Cin(1'b0), .Sum(s6), .Cout(c6) );
    cla_8bit adder_6 ( .A({  c6,s6[7:1]}), .B(p7), .Cin(1'b0), .Sum(s7), .Cout(c7) );

    assign Prod = {c7,s7,s6[0],s5[0],s4[0],s3[0],s2[0],s1[0],p0[0]};
endmodule
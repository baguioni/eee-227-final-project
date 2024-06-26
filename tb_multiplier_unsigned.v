`timescale 1ns / 1ps

module tb_multiplier_unsigned;

reg [7:0] A,B;
wire [15:0] P;
reg signed [7:0] A_s,B_s;
wire signed [15:0] P_s;

multiplier_unsigned uut0 (.A(A), .B(B), .Prod(P));
multiplier_signed   uut1 (.A(A), .B(B), .Prod(P_s));

initial begin
    $dumpfile("tb.vcd");
    $dumpvars();

    // Initialize inputs
    A = 0; B = 0; A_s = A; B_s = B;
    #10

    A = 8'd51; B = 8'd5; A_s = A; B_s = B;
    #10
    $display("A =  %d, B =  %d, u_Product =  %d", A, B, P);
    $display("A = %d, B = %d, s_Product = %d\n", A_s, B_s, P_s);

    A = 8'd16; B = 8'd16; A_s = A; B_s = B;
    #10
    $display("A =  %d, B =  %d, u_Product =  %d", A, B, P);
    $display("A = %d, B = %d, s_Product = %d\n", A_s, B_s, P_s);
    
    A = -8'd51; B = 8'd5; A_s = A; B_s = B;
    #10
    $display("A =  %d, B =  %d, u_Product =  %d", A, B, P);
    $display("A = %d, B = %d, s_Product = %d\n", A_s, B_s, P_s);

    A = 8'd16; B = -8'd16; A_s = A; B_s = B;
    #10
    $display("A =  %d, B =  %d, u_Product =  %d", A, B, P);
    $display("A = %d, B = %d, s_Product = %d\n", A_s, B_s, P_s);

    $finish;
end
    

endmodule

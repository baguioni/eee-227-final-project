// Written in such a way where I can make it superscalar
// can add another demux to add SrcC and SrcD thus can run 2 operations at once 
module alu(
    input [2:0] Control,
    input [7:0] SrcA,
    input [7:0] SrcB,
    output reg [7:0] result
);
    // Declare wires to connect the demux outputs to the functional units
    wire [7:0] and_in_a, or_in_a, xor_in_a, add_in_a, sub_in_a, mul_in_a;
    wire [7:0] and_in_b, or_in_b, xor_in_b, add_in_b, sub_in_b, mul_in_b;

    // Outputs of functional unit
    wire [7:0] and_out, or_out, xor_out, add_out, sub_out, mul_out;

    // Demux logic to route input to appropriate functional unit
    demux8 demux_A (
        .data_in(SrcA),
        .control(Control),
        .out0(),// Not used
        .out1(and_in_a),
        .out2(or_in_a),
        .out3(xor_in_a),
        .out4(),// Not used
        .out5(add_in_a),
        .out6(sub_in_a),
        .out7(mul_in_a)
    );

    demux8 demux_B (
        .data_in(SrcB),
        .control(Control),
        .out0(),// Not used
        .out1(and_in_b),
        .out2(or_in_b),
        .out3(xor_in_b),
        .out4(),// Not used
        .out5(add_in_b),
        .out6(sub_in_b),
        .out7(mul_in_b)
    );

    // Functional unit instances
    bitwise_and and_unit (
        .a(and_in_a),
        .b(and_in_b),
        .out(and_out)
    );

    bitwise_or or_unit (
        .a(or_in_a),
        .b(or_in_b),
        .out(or_out)
    );

    bitwise_xor xor_unit (
        .a(xor_in_a),
        .b(xor_in_b),
        .out(xor_out)
    );

    adder add_unit (
        .a(add_in_a),
        .b(add_in_b),
        .out(add_out)
    );

    subtractor sub_unit (
        .a(sub_in_a),
        .b(sub_in_b),
        .out(sub_out)
    );

    multiplier mul_unit (
        .a(mul_in_a),
        .b(mul_in_b),
        .out(mul_out)
    );

    // Mux to select appropriate output of functional unit
    always @(*) begin
        case (Control)
            3'b000: result = 8'b0; // Case where instruction is empty
            3'b001: result = and_out;
            3'b010: result = or_out;
            3'b011: result = xor_out;
            3'b101: result = add_out;
            3'b110: result = sub_out;
            3'b111: result = mul_out;
            default: result = 8'b0; // Default case
        endcase
    end

endmodule

module demux8(
    input [7:0] data_in,
    input [2:0] control,
    output reg [7:0] out0,
    output reg [7:0] out1,
    output reg [7:0] out2,
    output reg [7:0] out3,
    output reg [7:0] out4,
    output reg [7:0] out5,
    output reg [7:0] out6,
    output reg [7:0] out7
);

    always @(*) begin
        out0 = 8'b0;
        out1 = 8'b0;
        out2 = 8'b0;
        out3 = 8'b0;
        out4 = 8'b0;
        out5 = 8'b0;
        out6 = 8'b0;
        out7 = 8'b0;
        
        case (control)
            3'b001: out1 = data_in;
            3'b010: out2 = data_in;
            3'b011: out3 = data_in;
            3'b100: out4 = data_in;
            3'b101: out5 = data_in;
            3'b110: out6 = data_in;
            3'b111: out7 = data_in;
        endcase
    end

endmodule


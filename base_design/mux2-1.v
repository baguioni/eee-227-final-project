module mux2x1 #(parameter WIDTH = 4) (
	input [WIDTH-1:0] a, 
	input [WIDTH-1:0] b, 
	input sel, 
	output [WIDTH-1:0] out
);
	assign out = sel ? b : a;
endmodule

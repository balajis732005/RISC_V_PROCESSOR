module adder(
    input [31:0] in_1,
    input [31:0] in_2,
    output [31:0] adder_out
);

    assign adder_out = in_1 + in_2;

endmodule
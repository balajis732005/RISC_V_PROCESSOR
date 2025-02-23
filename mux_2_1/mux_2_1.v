module mux_2_1 #(parameter N = 32) (
    input [N-1:0] in_1,
    input [N-1:0] in_2,
    input sel,
    output [N-1:0] mux_out
);

    assign mux_out = (sel == 1'b0) ? in_1 : in_2;

endmodule
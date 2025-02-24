module program_counter_plus(
    input [31:0] from_pc,
    output [31:0] next_pc
);

    assign next_pc = from_pc + 1; 

endmodule
module instruction_memory(
    input [31:0] read_address,
    output reg [31:0] inst_out
);

    reg [31:0] inst_mem [0:255];

    assign inst_out <= inst_mem[read_address];

endmodule
module instruction_memory(
    input [31:0] read_address,
    output reg [31:0] inst_out
);

    reg [31:0] inst_mem [0:255]; // 256 x 32-bit

    always @(*) begin
        inst_out = inst_mem[read_address[7:0]];
    end

endmodule

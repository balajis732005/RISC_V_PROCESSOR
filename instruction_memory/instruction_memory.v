module instruction_memory(
    input [31:0] read_address,
    output reg [31:0] inst_out
);

    reg [31:0] inst_mem [0:255]; // 256 x 32-bit

    initial begin
        $readmemb("instruction.mem",inst_mem);
        $display("INSTRUCTION : %b",inst_mem[0]);
    end

    always @(*) begin
        inst_out = inst_mem[read_address];
    end

endmodule
module instruction_memory(
    input [31:0] read_address,
    output reg [31:0] inst_out
);

    reg [31:0] inst_mem [0:255]; // 256 x 32-bit

    initial begin
        $readmemb("inst.mem",inst_mem);
        $display("Instruction : %b %b %b %b",inst_mem[0],inst_mem[1],inst_mem[2],inst_mem[3],inst_mem[4],inst_mem[5]);
    end

    always @(*) begin
        inst_out = inst_mem[read_address];
    end

endmodule

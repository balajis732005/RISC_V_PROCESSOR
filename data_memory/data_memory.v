module data_memory(
    input clock,
    input reset,
    input mem_read_enable,
    input mem_write_enable,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);

    reg [31:0] memory [0:1023]; // 1024 x 32-bit memory
    integer address_int;
    integer i;

    initial begin
        $readmemb("data.mem", memory);
    end

    always @(*) begin
        address_int = address;
        $display("Ind : %d  - Data Fetch : %b",address_int,memory[address_int]);
        if (mem_read_enable == 1'b1) begin
            read_data <= memory[address_int];
        end else begin
            read_data = 32'b0; 
        end
    end

    always @(posedge clock or posedge reset) begin
        if (reset == 1'b1) begin
            for (i = 0; i < 1024; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end else if (mem_write_enable == 1'b1) begin
            memory[address_int] <= write_data;
        end
    end

endmodule
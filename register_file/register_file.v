module register_file(
    input clock,
    input reset,
    input register_write,
    input [4:0] read_register_1,
    input [4:0] read_register_2,
    input [4:0] write_register,
    input [31:0] write_data,
    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2
);

    reg [31:0] register [31:0]; // 32 x 32-bit
    integer i;

    always @(*) begin
        read_data_1 = register[read_register_1];
        read_data_2 = register[read_register_2];
    end

    always @(posedge clock or posedge reset) begin
        if (reset==1'b1) begin
            for (i = 0; i < 32; i = i + 1) begin
                register[i] <= 32'b0; 
            end
        end
        else if (register_write==1'b1 && write_register != 5'b00000) begin
            register[write_register] <= write_data;
        end
    end

endmodule

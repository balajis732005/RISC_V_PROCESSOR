module data_memory(
    input clock,
    input reset,
    input mem_read_enable,
    input mem_write_enable,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);

    reg [31:0] memory [0:1023];

    assign read_data = (mem_read_enable==1'b1) ? memory[address] : 32'b0; 

    always(posedge clock) begin
        if(mem_write_enable) begin
            memory[address] <= write_data;
        end
    end

endmodule
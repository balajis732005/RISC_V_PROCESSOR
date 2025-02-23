module program_counter(
    input clock,
    input reset,
    input [31:0] p_in,
    output reg [31:0] p_out
);

    always @(posedge clock or posedge reset) begin
        if(reset==1'b1) begin
            p_out <= 32'b0;
        end
        else begin
            p_out <= p_in;
        end
    end

endmodule
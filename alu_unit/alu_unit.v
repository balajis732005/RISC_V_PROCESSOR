module alu_unit(
    input [31:0] in_1,
    input [31:0] in_2,
    input [3:0] alu_op,
    output reg [31:0] alu_out,
    output reg zero
);

    parameter [3:0] add = 4'b0010;
    parameter [3:0] sub = 4'b0110;
    parameter [3:0] log_and = 4'b0000;
    parameter [3:0] log_or = 4'b0001;
    parameter [3:0] log_xor = 4'b1000;
    parameter [3:0] sll = 4'b1001;
    parameter [3:0] srl = 4'b1010;
    parameter [3:0] sra = 4'b1011;
    parameter [3:0] slt = 4'b0111;

    always @(*) begin
        case(alu_op)
            add : begin
                alu_out = in_1 + in_2;
            end
            sub : begin
                alu_out = in_1 - in_2;
            end
            log_and : begin
                alu_out = in_1 & in_2;
            end
            log_or : begin
                alu_out = in_1 | in_2;
            end
            log_xor : begin
                alu_out = in_1 ^ in_2;
            end
            sll : begin
                alu_out = in_2 << in_1[4:0];
            end
            srl : begin
                alu_out = in_2 >> in_1[4:0];
            end
            sra : begin
                alu_out = $signed(in_2) >>> in_1[4:0]; 
            end
            slt : begin
                alu_out = ($signed(in_1) < $signed(in_2)) ? 32'b1 : 32'b0;
            end
            default: begin
                alu_out = 32'b0; 
            end
        endcase

        zero = (alu_out == 32'b0) ? 1'b1 : 1'b0;
    end

endmodule
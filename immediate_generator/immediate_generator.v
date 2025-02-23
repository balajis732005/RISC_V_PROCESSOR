module immediate_generator(
    input [31:0] instruction,
    output reg [31:0] imm_gen
);

    reg [6:0] opcode;
    assign opcode = instruction[6:0];
 
    parameter [6:0] i_type_alu = 7'b0010011;
    parameter [6:0] i_type_load = 7'b0000011;
    parameter [6:0] s_type = 7'b0100011;
    parameter [6:0] b_type = 7'b1100011;
    parameter [6:0] u_type_lui = 7'b0110111;
    parameter [6:0] u_type_auipc = 7'b0010111;
    parameter [6:0] j_type_jal = 7'b1101111;

    case(opcode)
        i_type_alu, i_type_load : begin
            imm_gen = {{20{instruction[31]}}, instruction[31:20]};
        end

        s_type : begin
            imm_gen = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        end

        b_type: begin
            imm_gen = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[30:25], 1'b0};
        end

        u_type_lui, u_type_auipc : begin
            imm_gen = {instruction[31:12], 12'b0};
        end

        j_type_jal : begin
            imm_gen = {{12{instruction[31]}}, insturction[19:12], instruction[20], instruction[30:21], 1'b0};
        end

        default : begin
            imm_gen = 32'b0;
        end

    endcase

endmodule
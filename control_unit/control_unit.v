module control_unit(
    input [6:0] opcode,
    output reg branch_enable,
    output reg mem_read_enable,
    output reg mem_or_alu,
    output reg [1:0] alu_control,
    output reg mem_write_enable,
    output reg imm_enable,
    output reg reg_write_enable
);

    parameter [6:0] r_type = 7'b0110011;
    parameter [6:0] i_type_alu = 7'b0010011;
    parameter [6:0] i_type_load = 7'b0000011;
    parameter [6:0] s_type = 7'b0100011;
    parameter [6:0] b_type = 7'b1100011;
    parameter [6:0] j_type_jal = 7'b1101111;
    parameter [6:0] j_type_jalr = 7'b1100111;
    parameter [6:0] u_type_lui = 7'b0110111;
    parameter [6:0] u_type_auipc = 7'b0010111;

    always @(*) begin
        case(opcode)
            r_type: begin
                branch_enable = 1'b0;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b0;
                alu_control = 2'b10; 
                mem_write_enable = 1'b0;
                imm_enable = 1'b0;
                reg_write_enable = 1'b1;
            end

            i_type_alu: begin
                branch_enable = 1'b0;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b1;
                alu_control = 2'b11;
                mem_write_enable = 1'b0;
                imm_enable = 1'b1;
                reg_write_enable = 1'b1;
            end

            i_type_load: begin
                branch_enable = 1'b0;
                mem_read_enable = 1'b1;
                mem_or_alu = 1'b0;
                alu_control = 2'b00;
                mem_write_enable = 1'b0;
                imm_enable = 1'b1;
                reg_write_enable = 1'b1;
            end

            s_type: begin
                branch_enable = 1'b0;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b0; // DON'T CARE
                alu_control = 2'b00;
                mem_write_enable = 1'b1;
                imm_enable = 1'b1;
                reg_write_enable = 1'b0;
            end

            b_type: begin
                branch_enable = 1'b1;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b0; // DON'T CARE
                alu_control = 2'b01;
                mem_write_enable = 1'b0;
                imm_enable = 1'b0;
                reg_write_enable = 1'b0;
            end

            j_type_jal: begin
                branch_enable = 1'b1;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b0;
                alu_control = 2'b00; // DON'T CARE
                mem_write_enable = 1'b0;
                imm_enable = 1'b1;
                reg_write_enable = 1'b1;
            end

            j_type_jalr: begin
                branch_enable = 1'b1;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b0;
                alu_control = 2'b00; // DON'T CARE
                mem_write_enable = 1'b0;
                imm_enable = 1'b1;
                reg_write_enable = 1'b1;
            end

            u_type_lui: begin
                branch_enable = 1'b0;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b0;
                alu_control = 2'b00; // DON'T CARE
                mem_write_enable = 1'b0;
                imm_enable = 1'b1;
                reg_write_enable = 1'b1;
            end

            u_type_auipc: begin
                branch_enable = 1'b0;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b1;
                alu_control = 2'b00; // DON'T CARE
                mem_write_enable = 1'b0;
                imm_enable = 1'b1;
                reg_write_enable = 1'b1;
            end

            default: begin
                branch_enable = 1'b0;
                mem_read_enable = 1'b0;
                mem_or_alu = 1'b0;
                alu_control = 2'b00;
                mem_write_enable = 1'b0;
                imm_enable = 1'b0;
                reg_write_enable = 1'b0;
            end
        endcase
    end

endmodule
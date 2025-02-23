module alu_control_unit(
    input [1:0] alu_control,
    input [2:0] func3,
    input [6:0] func7,
    output reg [3:0] alu_con_out
);

    parameter [1:0] load_store = 2'b00;
    parameter [1:0] branch = 2'b01;
    parameter [1:0] r_type = 2'b10;
    parameter [1:0] i_type = 2'b11;

    always @(*) begin
        case(alu_control)
            load_store: begin
                alu_con_out = 4'b0010; // ADD - LOAD/sTORE
            end

            branch: begin
                alu_con_out = 4'b0110; // SUB - BRANCH
            end

            r_type: begin
                case(func3)
                    3'b000: begin
                        alu_con_out = (func7 == 7'b0100000) ? 4'b0110 : 4'b0010; // SUB if funct7 is 0100000, else ADD
                    end
                    3'b111: alu_con_out = 4'b0000; // AND
                    3'b110: alu_con_out = 4'b0001; // OR
                    3'b100: alu_con_out = 4'b1000; // XOR
                    3'b001: alu_con_out = 4'b1001; // SLL
                    3'b101: begin
                        alu_con_out = (func7 == 7'b0100000) ? 4'b1011 : 4'b1010; // SRA if funct7 is 0100000, else SRL
                    end
                    3'b010: alu_con_out = 4'b0111; // SLT
                    3'b011: alu_con_out = 4'b1000; // SLTU 
                    default: alu_con_out = 4'b0000;
                endcase
            end

            i_type: begin
                case(func3)
                    3'b000: alu_con_out = 4'b0010; // ADDI & AUIPC & JALR
                    3'b111: alu_con_out = 4'b0000; // ANDI
                    3'b110: alu_con_out = 4'b0001; // ORI
                    3'b100: alu_con_out = 4'b1000; // XORI
                    3'b001: alu_con_out = 4'b1001; // SLLI
                    3'b101: begin
                        alu_con_out = (func7 == 7'b0100000) ? 4'b1011 : 4'b1010; // SRAI if funct7 is 0100000, else SRLI
                    end
                    3'b010: alu_con_out = 4'b0111; // SLTI
                    3'b011: alu_con_out = 4'b1000; // SLTIU 
                    default: alu_con_out = 4'b0000; 
                endcase
            end

            default: begin
                alu_con_out = 4'b0000;
            end
        endcase
    end

endmodule

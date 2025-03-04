`include "adder/adder.v"
`include "alu_control_unit/alu_control_unit.v"
`include "alu_unit/alu_unit.v"
`include "control_unit/control_unit.v"
`include "data_memory/data_memory.v"
`include "immediate_generator/immediate_generator.v"
`include "instruction_memory/instruction_memory.v"
`include "mux_2_1/mux_2_1.v"
`include "program_counter/program_counter.v"
`include "program_counter_plus/program_counter_plus.v"
`include "register_file/register_file.v"

module risc_v_processor(
    input clock,
    input reset
);

    wire [31:0] pro_con;
    wire [31:0] pro_con_plus;
    wire [31:0] next_pro_con;
    wire [31:0] instruction;
    wire [31:0] read_data_1;
    wire [31:0] read_data_2;
    wire [31:0] immediate;
    wire [31:0] alu_out;
    wire [31:0] mem_data;
    wire [31:0] write_data;
    wire [3:0] alu_op;
    wire [31:0] branch_target;
    wire [1:0] alu_control;
    wire branch_enable;
    wire mem_read_enable;
    wire mem_or_alu;
    wire mem_write_enable;
    wire imm_enable;
    wire reg_write_enable;
    
    wire zero;
    wire [31:0] alu_in_from_mux;

    program_counter ProgramCounter(
        .clock(clock),
        .reset(reset),
        .p_in(next_pro_con),
        .p_out(pro_con)
    );

    program_counter_plus ProgramCounterPlus(
        .from_pc(pro_con),
        .next_pc(pro_con_plus)
    );

    instruction_memory InstructionMemory(
        .read_address(pro_con),
        .inst_out(instruction)
    );

    control_unit ControlUnit(
        .opcode(instruction[6:0]),
        .branch_enable(branch_enable),
        .mem_read_enable(mem_read_enable),
        .mem_or_alu(mem_or_alu),
        .alu_control(alu_control),
        .mem_write_enable(mem_write_enable),
        .imm_enable(imm_enable),
        .reg_write_enable(reg_write_enable)
    );

    register_file RegisterFile(
        .clock(clock),
        .reset(reset),
        .register_write(reg_write_enable),
        .read_register_1(instruction[19:15]),
        .read_register_2(instruction[24:20]),
        .write_register(instruction[11:7]),
        .write_data(write_data),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    immediate_generator ImmediateRegister(
        .instruction(instruction),
        .imm_gen(immediate)
    );

    alu_control_unit AluControlUnit(
        .alu_control(alu_control),
        .func3(instruction[14:12]),
        .func7(instruction[31:25]),
        .alu_con_out(alu_op)
    );

    mux_2_1 #(32) MuxAluSel(
        .in_1(read_data_2),
        .in_2(immediate),
        .sel(imm_enable),
        .mux_out(alu_in_from_mux)
    );

    alu_unit AluUnit(
        .in_1(read_data_1),
        .in_2(alu_in_from_mux),
        .alu_op(alu_op),
        .alu_out(alu_out),
        .zero(zero)
    );

    data_memory DataMemory(
        .clock(clock),
        .reset(reset),
        .mem_read_enable(mem_read_enable),
        .mem_write_enable(mem_write_enable),
        .address(alu_out),
        .write_data(read_data_2),
        .read_data(mem_data)
    );

    mux_2_1 #(32) MuxMemToReg(
        .in_1(alu_out),
        .in_2(mem_data),
        .sel(mem_or_alu),
        .mux_out(write_data)
    );

    adder Adder(
        .in_1(pro_con),
        .in_2(immediate),
        .adder_out(branch_target)
    );

    mux_2_1 #(32) MuxPC(
        .in_1(pro_con_plus),
        .in_2(branch_target),
        .sel(branch_enable & zero),
        .mux_out(next_pro_con)
    );

endmodule
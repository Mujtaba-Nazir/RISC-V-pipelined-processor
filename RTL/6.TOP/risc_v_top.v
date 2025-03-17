module RISC_V_Processor (
    input i_clk, i_reset
);

    // Wires between pipeline stages
    wire [31:0] if_id_instr, if_id_pc;
    wire [31:0] id_ex_pc, id_ex_read_data1, id_ex_read_data2, id_ex_imm;
    wire [4:0] id_ex_rs1, id_ex_rs2, id_ex_rd;
    wire [3:0] id_ex_alu_control;
    wire id_ex_reg_write, id_ex_mem_read, id_ex_mem_write, id_ex_mem_to_reg, id_ex_alu_src;

    wire [31:0] ex_mem_alu_result, ex_mem_write_data;
    wire [4:0] ex_mem_rd;
    wire ex_mem_reg_write, ex_mem_mem_read, ex_mem_mem_write, ex_mem_mem_to_reg;

    wire [31:0] mem_wb_read_data, mem_wb_alu_result;
    wire [4:0] mem_wb_rd;
    wire mem_wb_reg_write, mem_wb_mem_to_reg;

    wire [31:0] write_back_data;
    wire [4:0] write_back_rd;
    wire write_back_reg_write;

    // **Instruction Fetch Stage**
    InstructionFetch IF_stage (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_if_id_instruction_out(if_id_instr),
        .o_if_id_pc_out(if_id_pc)
    );

    // **Instruction Decode Stage**
    InstructionDecode ID_stage (
        .i_clk(clk),
        .i_reset(reset),
        .i_if_id_instruction(if_id_instr),
        .i_if_id_pc(if_id_pc),
        .i_id_ex_rd(),
        .i_id_ex_mem_read(),
        .o_id_ex_pc(id_ex_pc),
        .o_id_ex_read_data1(id_ex_read_data1),
        .o_id_ex_read_data2(id_ex_read_data2),
        .o_id_ex_imm(id_ex_imm),
        .o_id_ex_rs1(id_ex_rs1),
        .o_id_ex_rs2(id_ex_rs2),
        .o_id_ex_rd(id_ex_rd),
        .id_ex_alu_control(id_ex_alu_control),
        .o_id_ex_reg_write(id_ex_reg_write),
        .o_id_ex_mem_read(id_ex_mem_read),
        .o_id_ex_mem_write(id_ex_mem_write),
        .o_id_ex_mem_to_reg(id_ex_mem_to_reg),
        .o_id_ex_alu_src(id_ex_alu_src)
    );

    // **Execute Stage**
    Execute EX_stage (
        .i_clk(clk),
        .i_reset(reset),
        .i_id_ex_pc(id_ex_pc),
        .i_id_ex_read_data1(id_ex_read_data1),
        .i_id_ex_read_data2(id_ex_read_data2),
        .i_id_ex_imm(id_ex_imm),
        .i_id_ex_rs1(id_ex_rs1),
        .i_id_ex_rs2(id_ex_rs2),
        .i_id_ex_rd(id_ex_rd),
        .i_id_ex_reg_write(id_ex_reg_write),
        .i_id_ex_alu_src(id_ex_alu_src),
        .i_id_ex_mem_read(id_ex_mem_read),
        .i_id_ex_mem_write(id_ex_mem_write),
        .i_id_ex_mem_to_reg(id_ex_mem_to_reg),
        .i_id_ex_branch(),
        .i_id_ex_alu_op(),
        .i_ex_mem_rd(),
        .i_mem_wb_rd(),
        .i_ex_mem_reg_write(),
        .i_mem_wb_reg_write(),
        .i_ex_mem_alu_result(),
        .i_mem_wb_write_data(),
        .o_ex_mem_alu_result(ex_mem_alu_result),
        .o_ex_mem_write_data(ex_mem_write_data),
        .o_ex_mem_rd(ex_mem_rd),
        .o_ex_mem_reg_write(ex_mem_reg_write),
        .o_ex_mem_mem_read(ex_mem_mem_read),
        .o_ex_mem_mem_write(ex_mem_mem_write),
        .o_ex_mem_mem_to_reg(ex_mem_mem_to_reg)
    );

    // **Memory Access Stage**
    MemoryAccess MEM_stage (
        .i_clk(clk),
        .i_reset(reset),
        .i_ex_mem_alu_result(ex_mem_alu_result),
        .i_ex_mem_write_data(ex_mem_write_data),
        .i_ex_mem_rd(ex_mem_rd),
        .i_ex_mem_reg_write(ex_mem_reg_write),
        .i_ex_mem_mem_read(ex_mem_mem_read),
        .i_ex_mem_mem_write(ex_mem_mem_write),
        .i_ex_mem_mem_to_reg(ex_mem_mem_to_reg),
        .o_mem_wb_read_data(mem_wb_read_data),
        .o_mem_wb_alu_result(mem_wb_alu_result),
        .o_mem_wb_rd(mem_wb_rd),
        .o_mem_wb_reg_write(mem_wb_reg_write),
        .o_mem_wb_mem_to_reg(mem_wb_mem_to_reg)
    );

    // **Write Back Stage**
    WriteBack WB_stage (
        .i_mem_wb_read_data(mem_wb_read_data),
        .i_mem_wb_alu_result(mem_wb_alu_result),
        .i_mem_wb_rd(mem_wb_rd),
        .i_mem_wb_reg_write(mem_wb_reg_write),
        .i_mem_wb_mem_to_reg(mem_wb_mem_to_reg),
        .o_write_back_data(write_back_data),
        .o_write_back_rd(write_back_rd),
        .o_write_back_reg_write(write_back_reg_write)
    );

endmodule

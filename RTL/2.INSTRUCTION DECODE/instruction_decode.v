module InstructionDecode (
    input i_clk, i_reset,
    
    // Inputs from IF/ID pipeline register
    input [31:0] i_if_id_pc, i_if_id_instruction,
    
    // Inputs from EX/MEM stage for hazard detection
    input [4:0] i_id_ex_rd,
    input i_id_ex_mem_read,
    
    // Outputs to ID/EX pipeline register
    output [31:0] o_id_ex_pc, o_id_ex_read_data1, o_id_ex_read_data2, o_id_ex_imm, o_id_ex_instruction,
    output [4:0] o_id_ex_rs1, o_id_ex_rs2, o_id_ex_rd,
    output o_id_ex_reg_write, o_id_ex_alu_src, o_id_ex_mem_read, o_id_ex_mem_write, o_id_ex_mem_to_reg, o_id_ex_branch,
    output [1:0] o_id_ex_alu_op
);

    // Extract fields from instruction
    wire [6:0] int_opcode = i_if_id_instruction[6:0];
    wire [4:0] int_rs1 = i_if_id_instruction[19:15];
    wire [4:0] int_rs2 = i_if_id_instruction[24:20];
    wire [4:0] int_rd = i_if_id_instruction[11:7];

    // Control signals
    wire int_reg_write, int_alu_src, int_mem_read, int_mem_write, int_mem_to_reg, int_branch;
    wire [1:0] int_alu_op;

    // Register file outputs
    wire [31:0] int_read_data1, int_read_data2;

    // Immediate generator output
    wire [31:0] int_imm_out;

    // Hazard detection signals
    wire int_pc_write, int_if_id_write, int_control_stall;

    // Instantiate Control Unit
    ControlUnit CU (
        .i_opcode(int_opcode),
        .o_reg_write(int_reg_write),
        .o_alu_src(int_alu_src),
        .o_mem_read(int_mem_read),
        .o_mem_write(int_mem_write),
        .o_mem_to_reg(int_mem_to_reg),
        .o_branch(int_branch),
        .o_alu_op(int_alu_op)
    );

    // Instantiate Register File
    RegisterFile RF (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_reg_write(int_reg_write),
        .i_rs1(int_rs1),
        .i_rs2(int_rs2),
        .i_rd(int_rd),
        .i_write_data(32'b0),  // Placeholder for now (to be connected later)
        .o_read_data1(int_read_data1),
        .o_read_data2(int_read_data2)
    );

    // Instantiate Immediate Generator
    ImmediateGenerator IG (
        .i_instruction(i_if_id_instruction),
        .o_imm_out(int_imm_out)
    );

    // Instantiate Hazard Detection Unit
    HazardDetectionUnit HDU (
        .i_id_ex_rd(i_id_ex_rd),
        .i_if_id_rs1(int_rs1),
        .i_if_id_rs2(int_rs2),
        .i_id_ex_mem_read(i_id_ex_mem_read),
        .o_pc_write(int_pc_write),
        .o_if_id_write(int_if_id_write),
        .o_control_stall(int_control_stall)
    );

    // Instantiate ID/EX Pipeline Register
    ID_EX_PipelineReg ID_EX (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_pc_in(if_id_pc),
        .i_instruction_in(i_if_id_instruction),
        .i_read_data1_in(int_read_data1),
        .i_read_data2_in(int_read_data2),
        .i_imm_in(int_imm_out),
        .i_rs1_in(int_rs1),
        .i_rs2_in(int_rs2),
        .i_rd_in(int_rd),
        .i_reg_write_in(int_reg_write),
        .i_alu_src_in(int_alu_src),
        .i_mem_read_in(int_mem_read),
        .i_mem_write_in(int_mem_write),
        .i_mem_to_reg_in(int_mem_to_reg),
        .i_branch_in(int_branch),
        .i_alu_op_in(int_alu_op),
        .o_pc_out(id_ex_pc),
        .o_instruction_out(o_id_ex_instruction),
        .o_read_data1_out(o_id_ex_read_data1),
        .o_read_data2_out(o_id_ex_read_data2),
        .o_imm_out(o_id_ex_imm),
        .o_rs1_out(o_id_ex_rs1),
        .o_rs2_out(o_id_ex_rs2),
        .o_rd_out(o_id_ex_rd),
        .o_reg_write_out(o_id_ex_reg_write),
        .o_alu_src_out(o_id_ex_alu_src),
        .o_mem_read_out(o_id_ex_mem_read),
        .o_mem_write_out(o_id_ex_mem_write),
        .o_mem_to_reg_out(o_id_ex_mem_to_reg),
        .o_branch_out(o_id_ex_branch),
        .o_alu_op_out(o_id_ex_alu_op)
    );

endmodule

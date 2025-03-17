module Execute (
    input i_clk, i_reset,

    // Inputs from ID/EX pipeline register
    input [31:0] i_id_ex_pc, i_id_ex_read_data1, i_id_ex_read_data2, i_id_ex_imm,
    input [4:0] i_id_ex_rs1, i_id_ex_rs2, i_id_ex_rd,
    input i_id_ex_reg_write, i_id_ex_alu_src, i_id_ex_mem_read, i_id_ex_mem_write, i_id_ex_mem_to_reg, i_id_ex_branch,
    input [1:0] i_id_ex_alu_op,

    // Inputs from MEM/WB stage for forwarding
    input [4:0] i_ex_mem_rd, i_mem_wb_rd,
    input i_ex_mem_reg_write, i_mem_wb_reg_write,
    input [31:0] i_ex_mem_alu_result, i_mem_wb_write_data,

    // Outputs to EX/MEM pipeline register
    output [31:0] o_ex_mem_alu_result, o_ex_mem_write_data,
    output [4:0] o_ex_mem_rd,
    output o_ex_mem_reg_write, o_ex_mem_mem_read, o_ex_mem_mem_write, o_ex_mem_mem_to_reg
);

    // Forwarding unit control signals
    wire [1:0] int_forward_a, int_forward_b;
    wire [31:0] int_alu_input_a, int_alu_input_b;

    // ALU control signal
    wire [3:0] int_alu_control;

    // ALU result and zero flag
    wire [31:0] int_alu_result;
    wire int_zero;

    // Instantiate ALU Control Unit
    ALUControlUnit ALU_CU (
        .i_alu_op(i_id_ex_alu_op),
        .i_funct7(i_id_ex_imm[31:25]),  // Funct7 from immediate field
        .i_funct3(i_id_ex_imm[14:12]),  // Funct3 from immediate field
        .o_alu_control(int_alu_control)
    );

    // Instantiate Forwarding Unit
    ForwardingUnit FU (
        .i_id_ex_rs1(i_id_ex_rs1),
        .i_id_ex_rs2(i_id_ex_rs2),
        .i_ex_mem_rd(i_ex_mem_rd),
        .i_mem_wb_rd(i_mem_wb_rd),
        .i_ex_mem_reg_write(i_ex_mem_reg_write),
        .i_mem_wb_reg_write(i_mem_wb_reg_write),
        .o_forward_a(int_forward_a),
        .o_forward_b(int_forward_b)
    );

    // Select forwarded values or original register values
    assign int_alu_input_a = (int_forward_a == 2'b10) ? i_ex_mem_alu_result :
                         (int_forward_a == 2'b01) ? i_mem_wb_write_data :
                         i_id_ex_read_data1;

    assign int_alu_input_b = (int_forward_b == 2'b10) ? i_ex_mem_alu_result :
                         (int_forward_b == 2'b01) ? i_mem_wb_write_data :
                         (i_id_ex_alu_src) ? i_id_ex_imm :
                         i_id_ex_read_data2;

    // Instantiate ALU
    ALU ALU_Unit (
        .i_A(int_alu_input_a),
        .i_B(int_alu_input_b),
        .i_ALUControl(int_alu_control),
        .o_result(int_alu_result),
        .o_zero(int_zero)
    );

    // Instantiate EX/MEM Pipeline Register
    EX_MEM_PipelineReg EX_MEM (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_alu_result_in(int_alu_result),
        .i_write_data_in(i_id_ex_read_data2),
        .i_rd_in(i_id_ex_rd),
        .i_reg_write_in(i_id_ex_reg_write),
        .i_mem_read_in(i_id_ex_mem_read),
        .i_mem_write_in(i_id_ex_mem_write),
        .i_mem_to_reg_in(i_id_ex_mem_to_reg),
        .o_alu_result_out(o_ex_mem_alu_result),
        .o_write_data_out(o_ex_mem_write_data),
        .o_rd_out(o_ex_mem_rd),
        .o_reg_write_out(o_ex_mem_reg_write),
        .o_mem_read_out(o_ex_mem_mem_read),
        .o_mem_write_out(o_ex_mem_mem_write),
        .o_mem_to_reg_out(o_ex_mem_mem_to_reg)
    );

endmodule

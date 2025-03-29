module ID_EX_PipelineReg (
    input             i_clk,
    input             i_reset,
    input      [31:0] i_pc_in,
    input      [31:0]       i_instruction_in, 
    input        [31:0]     i_read_data1_in, 
    input        [31:0]     i_read_data2_in,
    input      [31:0]        i_imm_in,
    input      [4:0]  i_rs1_in, 
    input       [4:0]      i_rs2_in, 
    input       [4:0]      i_rd_in,
    input             i_reg_write_in,
    input             i_alu_src_in,
    input             i_mem_read_in,
    input             i_mem_write_in,
    input             i_mem_to_reg_in,
    input             i_branch_in,
    input      [1:0]  i_alu_op_in,
    output reg [31:0] o_pc_out,
    output reg  [31:0]      o_instruction_out,
    output reg  [31:0]      o_read_data1_out,
    output reg   [31:0]     o_read_data2_out,
    output reg    [31:0]     o_imm_out,
    output reg [4:0]  o_rs1_out,
    output reg  [4:0]      o_rs2_out,
    output reg   [4:0]     o_rd_out,
    output reg        o_reg_write_out,
    output reg        o_alu_src_out,
    output reg        o_mem_read_out,
    output reg        o_mem_write_out,
    output reg        o_mem_to_reg_out,
    output reg        o_branch_out,
    output reg [1:0]  o_alu_op_out
);

    always @(posedge i_clk) begin
        if (i_reset) begin
            o_pc_out <= 0;
            o_instruction_out <= 0;
            o_read_data1_out <= 0;
            o_read_data2_out <= 0;
            o_imm_out <= 0;
            o_rs1_out <= 0;
            o_rs2_out <= 0;
            o_rd_out <= 0;
            o_reg_write_out <= 0;
            o_alu_src_out <= 0;
            o_mem_read_out <= 0;
            o_mem_write_out <= 0;
            o_mem_to_reg_out <= 0;
            o_branch_out <= 0;
            o_alu_op_out <= 0;
        end else begin
            o_pc_out <= i_pc_in;
            o_instruction_out <= i_instruction_in;
            o_read_data1_out <= i_read_data1_in;
            o_read_data2_out <= i_read_data2_in;
            o_imm_out <= i_imm_in;
            o_rs1_out <= i_rs1_in;
            o_rs2_out <= i_rs2_in;
            o_rd_out <= i_rd_in;
            o_reg_write_out <= i_reg_write_in;
            o_alu_src_out <= i_alu_src_in;
            o_mem_read_out <= i_mem_read_in;
            o_mem_write_out <= i_mem_write_in;
            o_mem_to_reg_out <= i_mem_to_reg_in;
            o_branch_out <= i_branch_in;
            o_alu_op_out <= i_alu_op_in;
        end
    end

endmodule

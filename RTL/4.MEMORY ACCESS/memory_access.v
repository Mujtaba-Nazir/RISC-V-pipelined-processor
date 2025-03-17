module MemoryAccess (
    input i_clk, i_reset,

    // Inputs from EX/MEM pipeline register
    input [31:0] i_ex_mem_alu_result, i_ex_mem_write_data,
    input [4:0] i_ex_mem_rd,
    input i_ex_mem_reg_write, i_ex_mem_mem_read, i_ex_mem_mem_write, i_ex_mem_mem_to_reg,

    // Outputs to MEM/WB pipeline register
    output [31:0] o_mem_wb_read_data, o_mem_wb_alu_result,
    output [4:0] o_mem_wb_rd,
    output o_mem_wb_reg_write, o_mem_wb_mem_to_reg
);

    // Data memory output
    wire [31:0] int_read_data;

    // Instantiate Data Memory
    DataMemory DM (
        .i_clk(i_clk),
        .i_mem_read(i_ex_mem_mem_read),
        .i_mem_write(i_ex_mem_mem_write),
        .i_address(i_ex_mem_alu_result),
        .i_write_data(i_ex_mem_write_data),
        .o_read_data(int_read_data)
    );

    // Instantiate MEM/WB Pipeline Register
    MEM_WB_PipelineReg MEM_WB (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_read_data_in(int_read_data),
        .i_alu_result_in(i_ex_mem_alu_result),
        .i_rd_in(i_ex_mem_rd),
        .i_reg_write_in(i_ex_mem_reg_write),
        .i_mem_to_reg_in(i_ex_mem_mem_to_reg),
        .o_read_data_out(o_mem_wb_read_data),
        .o_alu_result_out(o_mem_wb_alu_result),
        .o_rd_out(o_mem_wb_rd),
        .o_reg_write_out(o_mem_wb_reg_write),
        .o_mem_to_reg_out(o_mem_wb_mem_to_reg)
    );

endmodule

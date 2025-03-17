module WriteBack (
    // Inputs from MEM/WB pipeline register
    input [31:0] i_mem_wb_read_data, i_mem_wb_alu_result,
    input [4:0] i_mem_wb_rd,
    input i_mem_wb_reg_write, i_mem_wb_mem_to_reg,

    // Outputs to Register File
    output [31:0] o_write_back_data,
    output [4:0] o_write_back_rd,
    output o_write_back_reg_write
);

    // Instantiate Write Back Multiplexer
    WriteBackMux WB_MUX (
        .i_mem_to_reg(i_mem_wb_mem_to_reg),
        .i_alu_result(i_mem_wb_alu_result),
        .i_read_data(i_mem_wb_read_data),
        .o_write_data(o_write_back_data)
    );

    // Pass through signals
    assign o_write_back_rd = i_mem_wb_rd;
    assign o_write_back_reg_write = i_mem_wb_reg_write;

endmodule

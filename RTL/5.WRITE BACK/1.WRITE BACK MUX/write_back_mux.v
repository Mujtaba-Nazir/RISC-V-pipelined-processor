module WriteBackMux (
    input i_mem_to_reg,
    input [31:0] i_alu_result, i_read_data,
    output [31:0] o_write_data
);

    assign o_write_data = (i_mem_to_reg) ? i_read_data : i_alu_result;

endmodule

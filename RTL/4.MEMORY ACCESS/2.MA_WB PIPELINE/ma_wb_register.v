module MEM_WB_PipelineReg (
    input i_clk, i_reset,
    input [31:0] i_read_data_in, i_alu_result_in,
    input [4:0] i_rd_in,
    input i_reg_write_in, i_mem_to_reg_in,
    output reg [31:0] o_read_data_out, o_alu_result_out,
    output reg [4:0] o_rd_out,
    output reg o_reg_write_out, o_mem_to_reg_out
);

    always @(posedge i_clk) begin
        if (i_reset) begin
            o_read_data_out <= 0;
            o_alu_result_out <= 0;
            o_rd_out <= 0;
            o_reg_write_out <= 0;
            o_mem_to_reg_out <= 0;
        end else begin
            o_read_data_out <= i_read_data_in;
            o_alu_result_out <= i_alu_result_in;
            o_rd_out <= i_rd_in;
            o_reg_write_out <= i_reg_write_in;
            o_mem_to_reg_out <= i_mem_to_reg_in;
        end
    end

endmodule

module ForwardingUnit (
    input [4:0] i_id_ex_rs1, i_id_ex_rs2,
    input [4:0] i_ex_mem_rd, i_mem_wb_rd,
    input i_ex_mem_reg_write, i_mem_wb_reg_write,
    output reg [1:0] o_forward_a, o_forward_b
);
    always @(*) begin
        // Forwarding for rs1
        if (i_ex_mem_reg_write && (i_ex_mem_rd != 0) && (i_ex_mem_rd == i_id_ex_rs1))
            o_forward_a = 2'b10;
        else if (i_mem_wb_reg_write && (i_mem_wb_rd != 0) && (i_mem_wb_rd == i_id_ex_rs1))
            o_forward_a = 2'b01;
        else
            o_forward_a = 2'b00;

        // Forwarding for rs2
        if (i_ex_mem_reg_write && (i_ex_mem_rd != 0) && (i_ex_mem_rd == i_id_ex_rs2))
            o_forward_b = 2'b10;
        else if (i_mem_wb_reg_write && (i_mem_wb_rd != 0) && (i_mem_wb_rd == i_id_ex_rs2))
            o_forward_b = 2'b01;
        else
            o_forward_b = 2'b00;
    end
endmodule

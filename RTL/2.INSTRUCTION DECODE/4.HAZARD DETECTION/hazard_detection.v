module HazardDetectionUnit (
    input [4:0] i_id_ex_rd, i_if_id_rs1, i_if_id_rs2,
    input i_id_ex_mem_read,
    output reg o_pc_write, o_if_id_write, o_control_stall
);

    always @(*) begin
        if (i_id_ex_mem_read && (i_id_ex_rd == i_if_id_rs1 || i_id_ex_rd == i_if_id_rs2)) begin
            o_pc_write = 0;         // Stall PC
            o_if_id_write = 0;      // Stall IF/ID pipeline register
            o_control_stall = 1;    // Stall Control Unit
        end else begin
            o_pc_write = 1;
            o_if_id_write = 1;
            o_control_stall = 0;
        end
    end

endmodule

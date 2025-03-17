module ControlUnit (
    input [6:0] i_opcode,
    output reg o_reg_write, o_alu_src, o_mem_read, o_mem_write, o_mem_to_reg, o_branch,
    output reg [1:0] o_alu_op
);

    always @(*) begin
        case (i_opcode)
            7'b0110011: begin  // R-type
                o_reg_write = 1;
                o_alu_src = 0;
                o_mem_read = 0;
                o_mem_write = 0;
                o_mem_to_reg = 0;
                o_branch = 0;
                o_alu_op = 2'b10;
            end
            7'b0000011: begin  // Load (LW)
                o_reg_write = 1;
                o_alu_src = 1;
                o_mem_read = 1;
                o_mem_write = 0;
                o_mem_to_reg = 1;
                o_branch = 0;
                o_alu_op = 2'b00;
            end
            7'b0100011: begin  // Store (SW)
                o_reg_write = 0;
                o_alu_src = 1;
                o_mem_read = 0;
                o_mem_write = 1;
                o_mem_to_reg = 0;
                o_branch = 0;
                o_alu_op = 2'b00;
            end
            7'b1100011: begin  // Branch (BEQ)
                o_reg_write = 0;
                o_alu_src = 0;
                o_mem_read = 0;
                o_mem_write = 0;
                o_mem_to_reg = 0;
                o_branch = 1;
                o_alu_op = 2'b01;
            end
            default: begin  // Default case
                o_reg_write = 0;
                o_alu_src = 0;
                o_mem_read = 0;
                o_mem_write = 0;
                o_mem_to_reg = 0;
                o_branch = 0;
                o_alu_op = 2'b00;
            end
        endcase
    end

endmodule

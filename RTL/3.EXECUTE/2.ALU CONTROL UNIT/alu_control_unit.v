module ALUControlUnit (
    input [1:0] i_alu_op,
    input [6:0] i_funct7,
    input [2:0] i_funct3,
    output reg [3:0] o_alu_control
);
    always @(*) begin
        case (i_alu_op)
            2'b00: o_alu_control = 4'b0010;  // ADD (for LW, SW, ADDI)
            2'b01: o_alu_control = 4'b0110;  // SUB (for BEQ)
            2'b10: begin  // R-Type
                case (i_funct3)
                    3'b000: o_alu_control = (i_funct7 == 7'b0100000) ? 4'b0110 : 4'b0010;  // SUB / ADD
                    3'b111: o_alu_control = 4'b0000;  // AND
                    3'b110: o_alu_control = 4'b0001;  // OR
                    3'b010: o_alu_control = 4'b0111;  // SLT
                    default: o_alu_control = 4'b0010;
                endcase
            end
            default: o_alu_control = 4'b0010;
        endcase
    end
endmodule

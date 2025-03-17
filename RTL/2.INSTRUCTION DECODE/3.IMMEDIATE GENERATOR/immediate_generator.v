module ImmediateGenerator (
    input [31:0] i_instruction,
    output reg [31:0] o_imm_out
);

    wire [6:0] int_opcode = i_instruction[6:0];

    always @(*) begin
        case (int_opcode)
            7'b0010011:  // I-type (ADDI, ANDI, etc.)
                o_imm_out = {{20{i_instruction[31]}}, i_instruction[31:20]};
            7'b0000011:  // Load (LW)
                o_imm_out = {{20{i_instruction[31]}}, i_instruction[31:20]};
            7'b0100011:  // Store (SW)
                o_imm_out = {{20{i_instruction[31]}}, i_instruction[31:25], i_instruction[11:7]};
            7'b1100011:  // Branch (BEQ, BNE)
                o_imm_out = {{19{i_instruction[31]}}, i_instruction[31], i_instruction[7], i_instruction[30:25], i_instruction[11:8], 1'b0};
            default:
                o_imm_out = 32'b0;
        endcase
    end

endmodule

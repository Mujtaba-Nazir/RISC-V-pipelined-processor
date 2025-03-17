module ALU (
    input [31:0] i_A, i_B,
    input [3:0] i_ALUControl,
    output reg [31:0] o_result,
    output o_zero
);
    always @(*) begin
        case (i_ALUControl)
            4'b0000: o_result = i_A & i_B;  // AND
            4'b0001: o_result = i_A | i_B;  // OR
            4'b0010: o_result = i_A + i_B;  // ADD
            4'b0110: o_result = i_A - i_B;  // SUB
            4'b0111: o_result = (i_A < i_B) ? 1 : 0;  // SLT
            4'b1100: o_result = ~(i_A | i_B);  // NOR
            default: o_result = 0;
        endcase
    end
    assign o_zero = (o_result == 0) ? 1 : 0;
endmodule

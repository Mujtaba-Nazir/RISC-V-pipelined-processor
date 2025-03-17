module IF_ID_PipelineReg (
    input i_clk, i_reset,
    input [31:0] i_pc_in, i_instruction_in,
    output reg [31:0] o_pc_out, o_instruction_out
);

    always @(posedge i_clk ) begin
        if (i_reset) begin
            o_pc_out <= 32'b0;
            o_instruction_out <= 32'b0;
        end else begin
            o_pc_out <= i_pc_in;
            o_instruction_out <= i_instruction_in;
        end
    end

endmodule

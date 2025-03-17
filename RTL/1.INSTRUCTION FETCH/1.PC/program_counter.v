module ProgramCounter (
    input i_clk, i_reset,
    output reg [31:0] o_pc_out
);

    always @(posedge i_clk ) begin
        if (i_reset)
            o_pc_out <= 32'b0;  // Reset PC to 0
        else
           o_pc_out <= o_pc_out + 4; // Increment by 4 for 32-bit instructions
    end

endmodule

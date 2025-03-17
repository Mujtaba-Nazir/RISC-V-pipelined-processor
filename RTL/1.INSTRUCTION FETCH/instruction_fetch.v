module InstructionFetch (
    input i_clk, i_reset,
    output [31:0] o_if_id_pc_out, o_if_id_instruction_out
);

    wire [31:0] int_pc_current, int_instruction;

    // Instantiate Program Counter
    ProgramCounter PC (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_pc_out(int_pc_current)
    );

    // Instantiate Instruction Memory
    InstructionMemory IM (
        .i_address(int_pc_current),
        .i_instruction(int_instruction)
    );

    // Instantiate IF/ID Pipeline Register
    IF_ID_PipelineReg IF_ID (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_pc_in(int_pc_current),
        .i_instruction_in(int_instruction),
        .o_pc_out(o_if_id_pc_out),
        .o_instruction_out(o_if_id_instruction_out)
    );

endmodule

module InstructionMemory (
    input [31:0] i_address,  
    output reg [31:0] o_instruction  
);

    reg [31:0] instr_mem [0:255]; // 256-word instruction memory (each word is 32-bit)

    initial begin
        $readmemh("instructions.mem", instr_mem);
    end

    always @(*) begin
        o_instruction = instr_mem[i_address >> 2]; // Word-aligned fetch for 32-bit instructions
    end

endmodule

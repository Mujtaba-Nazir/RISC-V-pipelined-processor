`timescale 1ns / 1ps

module RISC_V_Processor_tb;

    reg clk, reset;

    // Instantiate the processor
    RISC_V_Processor DUT (
        .i_clk(clk),
        .i_reset(reset)
    );

    // Clock generation
    always #10 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize signals
        clk = 1;
        reset = 1;
        
        // Hold reset for some time
        #20;
        reset = 0;

        // Load test instructions into instruction memory
        // Assuming instruction memory is preloaded externally
        // Example operations: ADD, SUB, BEQ, LW, SW
        DUT.IF_stage.IM.instruction_memory[0] = 32'b0000000_00001_00010_000_00011_0110011; // ADD x3, x1, x2
        DUT.IF_stage.IM.instruction_memory[1] = 32'b0100000_00010_00001_000_00100_0110011; // SUB x4, x1, x2
        DUT.IF_stage.IM.instruction_memory[2] = 32'b0000000_00001_00010_000_00101_1100011; // BEQ x1, x2, label
        DUT.IF_stage.IM.instruction_memory[3] = 32'b0000000_00010_00000_010_00110_0000011; // LW x6, 2(x0)
        DUT.IF_stage.IM.instruction_memory[4] = 32'b0000000_00110_00000_010_00000_0100011; // SW x6, 2(x0)

        // Simulate for some time
        //#200;

        // End simulation
       // $stop;
    end

endmodule

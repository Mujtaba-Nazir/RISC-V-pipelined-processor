module RegisterFile (
    input i_clk, i_reset,
    input i_reg_write,  // Control signal to enable writing
    input [4:0] i_rs1, i_rs2, i_rd,  // Register addresses
    input [31:0] i_write_data,  // Data to write into rd
    output [31:0] o_read_data1, o_read_data2  // Outputs for rs1, rs2
);

    reg [31:0] int_registers [31:0]; // 32 registers, each 32-bit
    integer i;
    // Read registers
    assign o_read_data1 = int_registers[i_rs1];
    assign o_read_data2 = int_registers[i_rs2];

    // Write on positive clock edge if write is enabled
    always @(posedge i_clk) begin
        if (i_reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                int_registers[i] <= 0;  // Reset all registers to 0
            end
        end else if (i_reg_write && i_rd != 5'b00000) begin
            int_registers[i_rd] <= i_write_data; // Write data to rd
        end
    end

endmodule

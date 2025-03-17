module DataMemory (
    input i_clk,
    input i_mem_read, i_mem_write,
    input [31:0] i_address, i_write_data,
    output reg [31:0] o_read_data
);

    reg [31:0] int_memory [0:255]; // 256 words of 32-bit memory

    always @(posedge i_clk) begin
        if (i_mem_write)
            int_memory[i_address[9:2]] <= i_write_data;  // Writing to memory
    end

    always @(*) begin
        if (i_mem_read)
            o_read_data = int_memory[i_address[9:2]];  // Reading from memory
        else
            o_read_data = 32'b0;
    end

endmodule

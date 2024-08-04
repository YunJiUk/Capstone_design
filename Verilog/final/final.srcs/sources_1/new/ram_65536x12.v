module ram_65536x12(
    input clk,
    input clk_25m,
    input csn,
    input wen,
    input [15:0] addr_write,
    input [15:0] addr_read,
    input [11:0] din,
    output [11:0] dout
    );
reg [11:0] data [0:65535];
reg [15:0] addr_reg;

always@(posedge clk) begin
    if (csn == 1'b0) begin
        if (wen == 1'b0) data[addr_write] <= din;
    end
end

always@(posedge clk_25m) begin
    if (csn == 1'b0) begin
        addr_reg <= addr_read;
    end
end

assign dout = data[addr_read];
endmodule

module key_generation_top#(
  DATA_WIDTH=1024,
  RAM_ADDR_WIDTH=5,
  RAM_SIZE=32
)(   
    input logic clock,
    input logic reset,
    input logic  start, 
    output logic done,
    //p in
    input logic [DATA_WIDTH-1:0]p_din,
    input logic [RAM_ADDR_WIDTH-1:0]p_wr_addr,
    input logic p_wr_en,
    //q in
    input logic [DATA_WIDTH-1:0]q_din,
    input logic [RAM_ADDR_WIDTH-1:0]q_wr_addr,
    input logic q_wr_en,
    //out
    input logic [RAM_ADDR_WIDTH-1:0]out_rd_addr,  //same for all 
    output logic [DATA_WIDTH-1:0]u_dout,
    output logic [DATA_WIDTH-1:0]n_dout,
    output logic [DATA_WIDTH-1:0]g_dout,
    output logic [DATA_WIDTH-1:0]lambda_dout

);

logic [DATA_WIDTH-1:0]p_dout,q_dout;
logic [DATA_WIDTH-1:0]u_din,n_din,g_din,lambda_din;
logic [RAM_ADDR_WIDTH-1:0] addr_rd_out,addr_wr_out;
logic wr_en_out;
key_generation #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDRESS_WIDTH(RAM_ADDR_WIDTH)
)key_generation(
    .clk(clock),
    .rst(reset),
    .start(start),
    .done(done),
    .p(p_dout),
    .q(q_dout),
    .n_out(n_din),
    .g_out(g_din),
    .lambda_out(lambda_din),
    .u_out(u_din),
    .addr_rd_out(addr_rd_out),
    .addr_wr_out(addr_wr_out),
    .mem_wr_en(wr_en_out)
);
// input RAMs
bram #(
    .BRAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .BRAM_DATA_WIDTH(DATA_WIDTH)
) ram_p ( /* synthesis syn_preserve = 1 */ 
    .clock(clock),
    .rd_addr(addr_rd_out),
    .wr_addr(p_wr_addr),
    .wr_en(p_wr_en),
    .din(p_din),
    .dout(p_dout)
);
bram #(
    .BRAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .BRAM_DATA_WIDTH(DATA_WIDTH)
) ram_q ( /* synthesis syn_preserve = 1 */ 
    .clock(clock),
    .rd_addr(addr_rd_out),
    .wr_addr(q_wr_addr),
    .wr_en(q_wr_en),
    .din(q_din),
    .dout(q_dout)
);

// output RAMs
bram #(
    .BRAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .BRAM_DATA_WIDTH(DATA_WIDTH)
) ram_u (
    .clock(clock),
    .rd_addr(out_rd_addr),
    .wr_addr(addr_wr_out),
    .wr_en(wr_en_out),
    .din(u_din),
    .dout(u_dout)
);
bram #(
    .BRAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .BRAM_DATA_WIDTH(DATA_WIDTH)
) ram_n (
    .clock(clock),
    .rd_addr(out_rd_addr),
    .wr_addr(addr_wr_out),
    .wr_en(wr_en_out),
    .din(n_din),
    .dout(n_dout)
);
bram #(
    .BRAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .BRAM_DATA_WIDTH(DATA_WIDTH)
) ram_g (
    .clock(clock),
    .rd_addr(out_rd_addr),
    .wr_addr(addr_wr_out),
    .wr_en(wr_en_out),
    .din(g_din),
    .dout(g_dout)
);
bram #(
    .BRAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .BRAM_DATA_WIDTH(DATA_WIDTH)
) ram_lambda (
    .clock(clock),
    .rd_addr(out_rd_addr),
    .wr_addr(addr_wr_out),
    .wr_en(wr_en_out),
    .din(lambda_din),
    .dout(lambda_dout)
);
endmodule


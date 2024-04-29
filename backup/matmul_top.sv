
module Top
#(    // Parameters for the bram instance
    parameter BRAM_ADDR_WIDTH = 6,
    parameter BRAM_DATA_WIDTH = 32,
    parameter MATRIX_SIZE = 8
)
(   input logic clock,
    input logic reset,
    input logic  start,  
    input logic [BRAM_DATA_WIDTH-1:0]x_din,
    input logic [BRAM_ADDR_WIDTH-1:0]x_wr_addr,
    input logic x_wr_en,
    input logic [BRAM_DATA_WIDTH-1:0]y_din,
    input logic [BRAM_ADDR_WIDTH-1:0]y_wr_addr,
    input logic y_wr_en,
    input logic [BRAM_ADDR_WIDTH-1:0]z_rd_addr,
    output logic [BRAM_DATA_WIDTH-1:0]z_dout,
    output logic done
);

  // Signals for the matmul instance
    
    logic [BRAM_ADDR_WIDTH-1:0] x_rd_addr;
    logic [BRAM_DATA_WIDTH-1:0] x_dout;
    logic [BRAM_ADDR_WIDTH-1:0] y_rd_addr;
    logic [BRAM_DATA_WIDTH-1:0] y_dout;
    logic [BRAM_ADDR_WIDTH-1:0] z_wr_addr;
    logic [BRAM_DATA_WIDTH-1:0] z_din;
    logic z_wr_en;


    // Instantiate the matmul module
    matmul #(
        .BRAM_DATA_WIDTH(BRAM_DATA_WIDTH),
        .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH),
        .MATRIX_SIZE(MATRIX_SIZE)
    ) matmul_instance ( /* synthesis syn_preserve = 1 */ 
        .clock(clock),
        .reset(reset),
        .start(start),
        .x_rd_addr(x_rd_addr),
        .x_dout(x_dout),
        .y_rd_addr(y_rd_addr),
        .y_dout(y_dout),
        .z_wr_addr(z_wr_addr),
        .z_din(z_din),
        .z_wr_en(z_wr_en),
        .done(done)
    );
    // Instantiate the bram
    bram #(
        .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH),
        .BRAM_DATA_WIDTH(BRAM_DATA_WIDTH)
    ) ram_x ( /* synthesis syn_preserve = 1 */ 
        .clock(clock),
        .rd_addr(x_rd_addr),
        .wr_addr(x_wr_addr),
        .wr_en(x_wr_en),
        .din(x_din),
        .dout(x_dout)
    );
    bram #(
        .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH),
        .BRAM_DATA_WIDTH(BRAM_DATA_WIDTH)
    ) ram_y ( /* synthesis syn_preserve = 1 */ 
        .clock(clock),
        .rd_addr(y_rd_addr),
        .wr_addr(y_wr_addr),
        .wr_en(y_wr_en),
        .din(y_din),
        .dout(y_dout)
    );
    bram #(
        .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH),
        .BRAM_DATA_WIDTH(BRAM_DATA_WIDTH)
    ) ram_z (
        .clock(clock),
        .rd_addr(z_rd_addr),
        .wr_addr(z_wr_addr),
        .wr_en(z_wr_en),
        .din(z_din),
        .dout(z_dout)
    );

    // Clock generation, initial conditions, and other logic can be added here

endmodule
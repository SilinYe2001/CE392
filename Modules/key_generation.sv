module key_generation #(
    parameter DATA_WIDTH=256,
    parameter ADDRESS_WIDTH=64
)(
    input logic clk,
    input logic rst,
    input logic start,
    output logic done, 
    //input data
    input logic [DATA_WIDTH-1:0]p,
    input logic [DATA_WIDTH-1:0]q,
    //ram
    output logic [ADDRESS_WIDTH-1:0]addr_rd_out,
    //output logic mem_rd_en,  // not use for now
    // output
    //public key
    output logic [DATA_WIDTH-1:0]n_out,
    output logic [DATA_WIDTH-1:0]g_out,
    // private key
    output logic [DATA_WIDTH-1:0]lambda_out,
    output reg [DATA_WIDTH-1:0]u_out,
    //ram
    output logic [ADDRESS_WIDTH-1:0]addr_wr_out,
    output logic mem_wr_en
);
typedef enum logic [1:0] {WAIT,READ,CALCULATING,FINISH} state_types;
state_types state, n_state;
logic [DATA_WIDTH-1:0]lambda,n_lambda,n,n_n;
logic [ADDRESS_WIDTH-1:0] addr_rd,n_addr_rd,addr_wr,n_addr_wr;
// logic inv_start;
// logic inv_busy;
logic din_ready,din_valid,dout_ready,dout_valid;
logic [ADDRESS_WIDTH-1:0] counter,n_counter;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= WAIT;
        lambda<='0;
        n<='0;
        addr_rd<='0;
        addr_wr<='0;
        counter<='0;
    end
    else begin
        state<= n_state;
        lambda<=n_lambda;
        n<=n_n;
        addr_rd<=n_addr_rd;
        addr_wr<=n_addr_wr;
        counter<= n_counter;

    end
end


assign addr_rd_out=addr_rd;
assign addr_wr_out=addr_wr;
assign n_out=n;
assign g_out=n+'1;
assign lambda_out=lambda;
always_comb begin 
    n_state=state;
    mem_wr_en='0;
    n_lambda=lambda;
    n_n=n;
    n_addr_rd=addr_rd;
    n_addr_wr=addr_wr;
    din_valid='0;
    dout_ready='0;
    n_counter=counter;
    done='0;
    case (state)
        WAIT: begin
            n_addr_rd='0;
            n_addr_wr='0;
            n_lambda='0;
            n_n='0;
            n_counter='0;
            if (start=='1) begin
                n_state=READ;
            end
        end 
        READ: begin // one cycle read, calculate multiplication
            n_n=p*q;
            n_lambda=(p-1)*(q-1);
            din_valid='1;       // valid signal after read 
            if (din_ready=='1) begin
                n_state=CALCULATING;
                n_addr_rd=addr_rd+'1;
            end
        end
        CALCULATING: begin  //multicycle calculate modular inverse
            dout_ready='1;
            if(dout_valid=='1)begin //write
                if(counter==2**ADDRESS_WIDTH-1) begin  //running out of memory
                    n_state=FINISH;  
                end
                else begin
                    n_state=READ;
                end
                n_counter=counter+1;
                mem_wr_en='1;
                // n_out=n;
                // g_out=n+'1;
                // lambda_out=lambda;
                n_addr_wr=addr_wr+'1;
            end
        end
        FINISH: begin  //DONE
            done='1;
            n_state=WAIT;
        end
        default: begin
            
        end
    endcase
    
end


// ModInv#(
//     .DATA_WIDTH(DATA_WIDTH)
// ) modularinvert(
//     .clk(clk), 
//     .A(lambda),
//     .p(n), 
//     .start(inv_start), 
//     .B(u_out),
//     .busy(inv_busy)
// );
ModInvert ModInv (
    .clock(clk),
    .reset(rst),
    .din_ready(din_ready),
    .din_valid(din_valid),
    .din_bits_base(lambda),
    .din_bits_mod(n),
    .dout_ready(dout_ready),
    .dout_valid(dout_valid),
    .dout_bits_res(u_out)
);

// divider #(
//     .DIVIDEND_WIDTH(DATA_WIDTH),
//     .DIVISOR_WIDTH(DATA_WIDTH)
// ) div1 (
//     .clk(clk),
//     .reset(reset),
//     .start(),
//     .dividend(1),
//     input logic [DIVISOR_WIDTH-1:0] divisor,
//     output reg [DIVIDEND_WIDTH-1:0] quotient,
//     output reg [DIVISOR_WIDTH-1:0] remainder,
//     output reg overflow,
//     output reg done
// );

endmodule
module matmul
#( parameter BRAM_DATA_WIDTH = 32,
    parameter BRAM_ADDR_WIDTH = 6,
    parameter MATRIX_SIZE = 8
)
(
input logic clock,
input logic reset,
input logic start,
output logic[BRAM_ADDR_WIDTH-1:0] x_rd_addr,
input logic[BRAM_DATA_WIDTH-1:0] x_dout,
output logic[BRAM_ADDR_WIDTH-1:0] y_rd_addr,
input logic[BRAM_DATA_WIDTH-1:0] y_dout,
output logic[BRAM_ADDR_WIDTH-1:0] z_wr_addr,
output logic[BRAM_DATA_WIDTH-1:0] z_din,
output logic z_wr_en,
output logic done


);
//logic n_done, done_o;
typedef enum logic[1:0] {s0,s1} state_t;
state_t n_state, state;
logic [BRAM_DATA_WIDTH-1:0] z,n_z;  //z_cache
logic [3:0] i,n_i,j,n_j,k,n_k;      //address index  (0-16)

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
    state <= s0;
    i <='0;
    j <= '0;
    k <= '0;
    z <='0;
    end else begin
    state <= n_state;
    i <= n_i;
    j <= n_j;
    k <= n_k;
    z <= n_z;
    end
end

assign  x_rd_addr=MATRIX_SIZE*i+k;
assign  y_rd_addr=MATRIX_SIZE*k+j; 
assign  z_wr_addr=MATRIX_SIZE*i+j; 


always_comb begin
    done = 1'b0;
    z_wr_en = '0;
    n_state = state;
    n_i = i;
    n_j = j;
    n_k = k;
    n_z = z;
    case (state)
        s0: begin
                n_z='0;
                n_i='0;
                n_j='0;
                n_k='0;
            if (start == 1'b1) begin
                n_state = s1;

            end
            else begin
                n_state = state;
            end
        end
        s1: begin
            if ($unsigned(i) < $unsigned(MATRIX_SIZE)) begin
                if ($unsigned(j) < $unsigned(MATRIX_SIZE)) begin
                    if ($unsigned(k) < $unsigned(MATRIX_SIZE)) begin
                        n_k=k+1; 
                        n_z=z+ $signed(x_dout) * $signed(y_dout);
                    end
                    else begin
                        z_wr_en=1'b1;
                        n_k='0;  
                        z_din=z;
                        n_j=j+1;
                        n_z='0;
                    end   
                end
                else begin
                    n_k='0; 
                    n_j='0;
                    n_i=i+1;            
                end
            end
            else begin
                n_state = s0;
                n_k = '0;
                n_j='0;

                n_i='0;  
                done=1'b1;
            end
        end
        default: begin
            n_state = s0;
            done= 'x;
            z_wr_en= 'x;
            n_i = 'x;
            n_j = 'x;
            n_k = 'x;
            n_z = 'x;
        end
    endcase
end
endmodule
module ModPow_4096 #(
    parameter   K = 128,
    parameter   N = 4096

)(
    input       wire                    clk         ,
    input       wire                    rst_n       ,
    
    input       wire                    wr_ena      ,
    input       wire [5  -1:0]          wr_addr     ,
    input       wire [128-1:0]          wr_X        ,//low words first, 4096bits, data to be ecrpyted
    input       wire [128-1:0]          wr_N        ,//low words first, 4096bits, modulus
    input       wire [128-1:0]          wr_E        ,//low words first, 4096bits, exponent
    input       wire [128-1:0]          wr_W       , //low words first, K bits, modular inverse of N (corresponding to m1)
    // target dara: Z = X^E mod N
    // input format : ModMult( X/1/A/B, R^2/A/B/1, N, W)

    input       wire                    task_req    ,// start task
    output      wire                    task_end    ,// indicate task end
    output      wire                    task_grant  ,// indicate data write
    output      wire [128-1:0]          task_res    // result


);

logic [127:0] one = 128'h1; //

logic [4096-1: 0] big_r_square =     4096'b0;
logic [4096-1: 0] big_1 =     4096'b1;
assign big_r_square[256] = 1'b1; // 2^128^2 = 2^256
logic modmult_wr_start;




always_comb begin

modmult_wr_start = 0;


    // NO direct operations for internal block rams
    case(state)

    // default state, read data from imput to ModMults
        READIN:begin /
        
            if(~task_req)begin //not finished
                state_c = READIN;
                phase = 1;

                
            end
            else begin
                state_c = CONVERT ;
            end
        end

    // step 1: pre-calculate A=(X,R^2,N,W), and B = (1,R^2,N,W)
        CONVERT:begin     // Read from input to ModMults
            if(task_grant)begin
                state_c = IDLE;
            end
        end















        default:begin
            state <= IDLE;
        end




    endcase




end
























parameter MULT_METHOD  = "TRADITION" ;// | COMMON ? | TRADITION 10| VEDIC8    8|
parameter ADD1_METHOD  = "3-2_PIPE1" ;// | COMMON ? | 3-2_PIPE1 1 | 3-2_PIPE2 2|
parameter ADD2_METHOD  = "3-2_DELAY2";// | COMMON   | 3-2_DELAY2  |            |
parameter MULT_LATENCY = MULT_METHOD == "COMMON"      ?0 :
                         MULT_METHOD == "TRADITION"   ?10:
                         MULT_METHOD == "VEDIC8"      ?8 :'dx;
parameter ADD1_LATENCY = ADD1_METHOD == "COMMON"      ?0 :
                         ADD1_METHOD == "3-2_PIPE1"   ?1 : 
                         ADD1_METHOD == "3-2_PIPE2"   ?2 :'dx;


// Modmult modules
// sp0: pre-calculate A=(X,R^2,N,W), and (A,B,N,W)
mmp_iddmm_sp #(
    .MULT_METHOD  ( MULT_METHOD  ),
    .ADD1_METHOD  ( ADD1_METHOD  ),
    .ADD2_METHOD  ( ADD2_METHOD  ),
    .MULT_LATENCY ( MULT_LATENCY ),        
    .ADD1_LATENCY ( ADD1_LATENCY ) 
)mmp_iddmm_sp_0 (
    .clk                     ( clk                        ),
    .rst_n                   ( rst_n                      ),

    .wr_ena                  ( wr_ena_0                     ),
    .wr_addr                 ( wr_addr_0    [$clog2(N)-1:0] ),
    .wr_x                    ( wr_x_0       [K-1:0]         ),
    .wr_y                    ( wr_y_0       [K-1:0]         ),
    .wr_m                    ( wr_m_0       [K-1:0]         ),
    .wr_m1                   ( wr_m1_0      [K-1:0]         ),

    .task_req                ( task_req_0                   ),
    .task_end                ( task_end_0                   ),
    .task_grant              ( res_val_0                    ),
    .task_res                ( res_0        [K-1:0]         )
);
// output: from low words to high words, only when task_grant==1 is valid 






// sp1: pre-calculate B=(1,R^2,N,W), and (A,A,N,W)/(B,B,N,W)
mmp_iddmm_sp #(
    .MULT_METHOD  ( MULT_METHOD  ),
    .ADD1_METHOD  ( ADD1_METHOD  ),
    .ADD2_METHOD  ( ADD2_METHOD  ),
    .MULT_LATENCY ( MULT_LATENCY ),        
    .ADD1_LATENCY ( ADD1_LATENCY ) 
)mmp_iddmm_sp_1 (
    .clk                     ( clk                        ),
    .rst_n                   ( rst_n                      ),

    .wr_ena                  ( wr_ena_1                     ),
    .wr_addr                 ( wr_addr_1    [$clog2(N)-1:0] ),
    .wr_x                    ( wr_x_1       [K-1:0]         ),
    .wr_y                    ( wr_y_1       [K-1:0]         ),
    .wr_m                    ( wr_m_1       [K-1:0]         ),
    .wr_m1                   ( wr_m1_1      [K-1:0]         ),

    .task_req                ( task_req_1                   ),
    .task_end                ( task_end_1                   ),
    .task_grant              ( res_val_1                    ),
    .task_res                ( res_1        [K-1:0]         )
);



logic [2:0] phase = 0; // 4 phase mux
// Define data sequence for the ModMults and Block RAMs
always_comb begin
    // always be W for both modules
    wr_m1_0 = wr_W; //W
    wr_m1_1 = wr_W; //W, only 128bits

    case (phase)
    0: begin //pre-calculate phase

    // Write into ModMult 0
        wr_x_0 = wr_X; //X
        wr_y_0 = big_r_square[wr_addr*K +: K]; //R^2
        wr_m_0 = wr_N; //N
        wr_ena_0 = wr_ena;
        wr_addr_0 = wr_addr;
    

    // Write into ModMult 1
        wr_x_1 = big_1[wr_addr*K +: K]; //1
        wr_y_1 = big_r_square[wr_addr*K +: K]; //R^2
        wr_m_1 = wr_N; //N
        wr_ena_1 = wr_ena;
        wr_addr_1 = wr_addr;

    // Write into Block RAM A
        wr_x_A = res_0; // write to RAM A
    // Write into Block RAM B
        wr_x_B = res_1; // write to RAM B
        task_res = 0;

    end
    1: begin //calculate phase: cond 1
    // Write into ModMult 0
        wr_x_0 = Aj; //A
        wr_y_0 = Bi; //B
        wr_m_0 = wr_N; //N
        wr_addr_0 = #todo

    //Write into ModMult 1
        wr_x_1 = Aj; //A
        wr_y_1 = Aj; //A
        wr_m_1 = wr_N; //N
        wr_addr_1 = #todo
    
    //Output to Block RAM A
        wr_x_A = res_1; // write to RAM A
        task_res = 0;

    // Output to Block RAM B
        wr_x_B = res_0; // write to RAM B
    end

    2: begin //calculate phase: cond 2

    // Write into ModMult 0
        wr_x_0 = Aj; //A
        wr_y_0 = Bi; //B
        wr_m_0 = wr_N; //N
        wr_addr_0 = #todo
    

    //Write into ModMult 1
        wr_x_1 = Bi; //B
        wr_y_1 = Bi; //B
        wr_m_1 = wr_N; //N
        wr_addr_1 = #todo


    //Output to Block RAM A
        wr_x_A = res_0; // write to RAM A
    //Output to Block RAM B
        wr_x_B = res_1; // write to RAM B
        task_res = 0;

    end

    3: begin //Final Calcualtion phase
    // Z = (B,1,N,W)

    // Write into ModMult 0
        wr_x_0 = Bi; //B
        wr_y_0 = big_1[wr_addr*K +: K]; //1
        wr_m_0 = wr_N; //N
        wr_addr_1 = #todo
    

    //Write into ModMult 1
        wr_x_1 = Bi; //B
        wr_y_1 = Bi; //B
        wr_m_1 = wr_N; //N
        wr_addr_1 = #todo

    //Output to output port
        wr_x_A = 0; // write to RAM A
        task_res = res_0; // write to output

    //Output to Block RAM B
        wr_x_B = 0; // write to RAM B



    end

    default:begin
        task_res = 0;
    end
        
    endcase

end








/* Block RAMs to receive input data*/

simple_ram#(
    .width                   ( 128              ),
    .widthad                 ( 6                ),//0-63,0-32 will be used
    .deep                    ( 33               ),
    .filename                ( "../../src/A.mem"))//caution:>>>>> addr32 must be 0 <<<<<
simple_ram_A(
    .clk                     ( clk              ),
    .wraddress               ( {1'd0,wr_addr_A}   ),//0-31
    .wren                    ( wr_ena_A           ),
    .data                    ( wr_x_A             ),
    .rdaddress               ( addr_rd_A         ),//0-32 will be read out
    .q                       ( Aj               )
);

simple_ram#(
    .width                   ( 128              ),
    .widthad                 ( 6                ),//0-63,0-32 will be used
    .deep                    ( 33               ),
    .filename                ( "../../src/B.mem"))//caution:>>>>> addr32 must be 0 <<<<<
simple_ram_B(
    .clk                     ( clk              ),
    .wraddress               ( {1'd0,wr_addr_B}   ),//0-31
    .wren                    ( wr_ena_B           ),
    .data                    ( wr_x_B             ),
    .rdaddress               ( addr_rd_B         ),//0-32 will be read out
    .q                       ( Bi               )
);



endmodule
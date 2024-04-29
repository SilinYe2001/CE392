module key_generation_tb;

    localparam DATA_WIDTH =1024 ;
    localparam RAM_ADDR_WIDTH=5;
    localparam FILE_SIZE=10;
    localparam CLOCK_PERIOD=10;
    logic clock;
    logic reset;
    logic start;
    logic done;
    //p in
    logic [DATA_WIDTH/2-1:0]p_din;
    logic [RAM_ADDR_WIDTH-1:0]p_wr_addr;
    logic p_wr_en;
    //q in
    logic [DATA_WIDTH/2-1:0]q_din;
    logic [RAM_ADDR_WIDTH-1:0]q_wr_addr;
    logic q_wr_en;
    //out
    logic [RAM_ADDR_WIDTH-1:0]out_rd_addr;  //same for all 
    logic [DATA_WIDTH-1:0]u_dout;
    logic [DATA_WIDTH-1:0]n_dout;
    logic [DATA_WIDTH-1:0]g_dout;
    logic [DATA_WIDTH-1:0]lambda_dout;

key_generation_top #(
    .DATA_WIDTH(DATA_WIDTH),
    .RAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .FILE_SIZE(FILE_SIZE)
  ) u_key_generation_top (
    .clock(clock),
    .reset(reset),
    .start(start),
    .done(done),
    .p_din(p_din),
    .p_wr_addr(p_wr_addr),
    .p_wr_en(p_wr_en),
    .q_din(q_din),
    .q_wr_addr(q_wr_addr),
    .q_wr_en(q_wr_en),
    .out_rd_addr(out_rd_addr),
    .u_dout(u_dout),
    .n_dout(n_dout),
    .g_dout(g_dout),
    .lambda_dout(lambda_dout)
  );

  // File handles
  string input_file_1= "p_values.txt";
  string input_file_2="q_values.txt";
  string output_file_u = "out_u.txt";
  string output_file_n = "out_n.txt";
  string output_file_g = "out_g.txt";
  string output_file_lambda = "out_lambda.txt";

  //expect file 
  string expected_file = "private_key_ld.txt";


  logic x_write_done='0;
  logic y_write_done='0;
  logic z_store_done='0;
  //logic z_read_done='0;
  int z_errors='0;
  // Clock generation
  always begin
    #(CLOCK_PERIOD/2) clock=1'b1;
    #(CLOCK_PERIOD/2) clock=1'b0;
  end

  initial begin
    #(CLOCK_PERIOD) reset = 1'b1;
    #(CLOCK_PERIOD) reset = 1'b0;
  end
    // Testbench logic
initial begin
    time start_time,end_time;
    @(negedge reset)
    wait(x_write_done && y_write_done);
    @(posedge clock)
    #(CLOCK_PERIOD) start = 1'b1;
    #(CLOCK_PERIOD) start = 1'b0;
    $display("@ %0t:Starting the testbench",start_time);
    start_time=$time;
    wait(done);
    end_time=$time;
    $display("@ %0t:Testbench completed",end_time);

    wait(z_store_done)
    $display("Total number of cycles: %d for %d datas",(end_time-start_time)/CLOCK_PERIOD,FILE_SIZE);
    $finish;
end

  // Load memory from input text file
  initial begin:x_write

    int input_file_handle;
    int tmp;
    $display("p load start");
    //load x
    //x_write_done=0;
    input_file_handle = $fopen(input_file_1, "r");
    if (input_file_handle == 0)
      $fatal("Unable to open input p data file");
      p_wr_en='1;
    for (int i = 0; i < FILE_SIZE; i = i + 1) begin
 //     for (int j = 0; j < MATRIX_SIZE; j = j + 1) begin
      @(negedge clock)
        p_wr_addr=i;
        tmp=$fscanf(input_file_handle, "%h", p_din);
      end
 //   end
     @(negedge clock);
      p_wr_addr='0;
      p_wr_en='0;
    $fclose(input_file_handle);
    x_write_done=1;
    $display("x load completed");

  end
  initial begin:y_write
    int input_file_handle;
    int tmp;
      // load y
       $display("q load start");
     // y_write_done=0;
    input_file_handle = $fopen(input_file_2, "r");
    if (input_file_handle == 0)
      $fatal("Unable to open input q data file");
      q_wr_en='1;
    for (int i = 0; i < FILE_SIZE; i = i + 1) begin
          @(negedge clock)
   //   for (int j = 0; j < MATRIX_SIZE; j = j + 1) begin
        q_wr_addr=i;
        tmp=$fscanf(input_file_handle, "%h", q_din);
      end
 //   end
    @(negedge clock);
    q_wr_addr='0;
    q_wr_en=8'b0;
    $fclose(input_file_handle);
    y_write_done=1;
    $display("y load completed");
  end

  initial begin: z_store
    int output_file_handle_u;
    int output_file_handle_n;
    int output_file_handle_g;
    int output_file_handle_lambda;

    //compare variable 
    int expected_file_handle;
    int tmp;
    logic [DATA_WIDTH-1:0] z_data_cmp,z_data_read;
    @(negedge reset);
    wait(done);
    @(negedge clock);
    $display("@ %0t Store output data begin",$time);
    $display("@ %0t Compare lambda with %s...",$time,expected_file);
    expected_file_handle = $fopen(expected_file, "r");
    output_file_handle_u = $fopen(output_file_u, "w");
    output_file_handle_n = $fopen(output_file_n, "w");
    output_file_handle_g = $fopen(output_file_g, "w");
    output_file_handle_lambda = $fopen(output_file_lambda, "w");
    if (output_file_handle_u == 0 || output_file_handle_n == 0 || output_file_handle_g == 0 || output_file_handle_lambda == 0)
      $fatal("Unable to store output data file"); 
    if (expected_file_handle == 0)
      $fatal("Unable to open expected lambda data file");  
    for (int i = 0; i < FILE_SIZE; i = i + 1) begin
        @(posedge clock);
  //    for (int j = 0; j < MATRIX_SIZE; j = j + 1) begin
        tmp=$fscanf(expected_file_handle, "%h", z_data_cmp);
        out_rd_addr=i;
        @(posedge clock);
        z_data_read=lambda_dout;
        if (z_data_cmp != z_data_read) begin
          z_errors++;
          $display("@ %0t :output lambda contents:%h != %h at address i= %d",$time,z_data_read,z_data_cmp,i);
        end
        $fwrite(output_file_handle_u, "%h\n", u_dout);
        $fwrite(output_file_handle_n, "%h\n", n_dout);
        $fwrite(output_file_handle_g, "%h\n", g_dout);
        $fwrite(output_file_handle_lambda, "%h\n", lambda_dout);
      end
      $display("There are %d errors in total", z_errors);
  //  end
    @(posedge clock);
    out_rd_addr='0;
    $fclose(output_file_handle_u);
    $fclose(output_file_handle_n);
    $fclose(output_file_handle_g);
    $fclose(output_file_handle_lambda);
    $display("@ %0t Store output data finish",$time);
    z_store_done=1;
  end

endmodule
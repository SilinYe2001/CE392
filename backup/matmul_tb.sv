`timescale 1 ns/1 ns
module matmul_tb;


    // Parameters for the Top module
    localparam BRAM_ADDR_WIDTH = 6;
    localparam BRAM_DATA_WIDTH = 32;
    localparam MATRIX_SIZE = 8;
    localparam FILE_SIZE = 64;
    localparam CLOCK_PERIOD = 10 ;

    // Signals for the Top module instance
    logic clock;
    logic reset;
    logic start;
    logic [BRAM_DATA_WIDTH-1:0] x_din; /* synthesis syn_preserve = 1 */ 
    logic [BRAM_ADDR_WIDTH-1:0] x_wr_addr; /* synthesis syn_preserve = 1 */ 
    logic x_wr_en; /* synthesis syn_preserve = 1 */ 
    logic [BRAM_DATA_WIDTH-1:0] y_din; /* synthesis syn_preserve = 1 */ 
    logic [BRAM_ADDR_WIDTH-1:0] y_wr_addr; /* synthesis syn_preserve = 1 */ 
    logic y_wr_en; /* synthesis syn_preserve = 1 */ 
    logic [BRAM_ADDR_WIDTH-1:0] z_rd_addr; /* synthesis syn_preserve = 1 */ 
    logic [BRAM_DATA_WIDTH-1:0] z_dout;   /* synthesis syn_preserve = 1 */ 
    logic done;

    // Instantiate the Top module
    Top #(
        .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH),
        .BRAM_DATA_WIDTH(BRAM_DATA_WIDTH),
        .MATRIX_SIZE(MATRIX_SIZE)
    ) Top (
        .clock(clock),
        .reset(reset),
        .start(start),
        .x_din(x_din),
        .x_wr_addr(x_wr_addr),
        .x_wr_en(x_wr_en),
        .y_din(y_din),
        .y_wr_addr(y_wr_addr),
        .y_wr_en(y_wr_en),
        .z_rd_addr(z_rd_addr),
        .z_dout(z_dout),
        .done(done)
    );

    // Clock generation, initial conditions, and other logic can be added here



  // File handles
  string input_file_1= "x.txt";
  string input_file_2="y.txt";
  string output_file = "out_z.txt";
  string expected_file = "z.txt";
  logic x_write_done='0;
  logic y_write_done='0;
  logic z_store_done='0;
  logic z_read_done='0;
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
    wait(z_read_done)
    $display("total simulation cycle count: %0d",(end_time-start_time)/CLOCK_PERIOD);
    $finish;
    end




  // Load memory from input text file
  initial begin:x_write

    int input_file_handle;
    int tmp;
    $display("x load start");
    //load x
    //x_write_done=0;
    input_file_handle = $fopen(input_file_1, "r");
    if (input_file_handle == 0)
      $fatal("Unable to open input x data file");
      x_wr_en='1;
    for (int i = 0; i < FILE_SIZE; i = i + 1) begin
 //     for (int j = 0; j < MATRIX_SIZE; j = j + 1) begin
      @(negedge clock)
        x_wr_addr=i;
        tmp=$fscanf(input_file_handle, "%h", x_din);
      end
 //   end
     @(negedge clock);
      x_wr_addr='0;
      x_wr_en=8'b0;
    $fclose(input_file_handle);
    x_write_done=1;
    $display("x load completed");

  end




  initial begin:y_write
    int input_file_handle;
    int tmp;
      // load y
       $display("y load start");
     // y_write_done=0;
    input_file_handle = $fopen(input_file_2, "r");
    if (input_file_handle == 0)
      $fatal("Unable to open input y data file");
      y_wr_en='1;
    for (int i = 0; i < FILE_SIZE; i = i + 1) begin
          @(negedge clock)
   //   for (int j = 0; j < MATRIX_SIZE; j = j + 1) begin
    y_wr_addr=i;
        tmp=$fscanf(input_file_handle, "%h", y_din);
      end
 //   end
    @(negedge clock);
    y_wr_addr='0;
    y_wr_en=8'b0;
    $fclose(input_file_handle);
    y_write_done=1;
    $display("y load completed");
  end




  initial begin: z_store
    int output_file_handle;
    @(negedge reset);
    wait(done);
    @(negedge clock);
    $display("@ %0t Store output data begin",$time);
    output_file_handle = $fopen(output_file, "w");
    if (output_file_handle == 0)
      $fatal("Unable to store output z data file");  
    for (int i = 0; i < FILE_SIZE; i = i + 1) begin
        @(posedge clock);
  //    for (int j = 0; j < MATRIX_SIZE; j = j + 1) begin
        z_rd_addr=i;
        @(posedge clock);
        $fwrite(output_file_handle, "%h\n", z_dout);
      end
  //  end
    @(posedge clock);
    z_rd_addr='0;
    $fclose(output_file_handle);
    $display("@ %0t Store output data finish",$time);
    z_store_done=1;
  end

  initial begin:z_read
    int expected_file_handle;
    int tmp;
    logic [BRAM_DATA_WIDTH-1:0] z_data_cmp,z_data_read;
    int i,j;
    @(negedge reset);
    wait(z_store_done);

    $display("@ %0t Compare data with %s...",$time,expected_file);
    expected_file_handle = $fopen(expected_file, "r");
    if (expected_file_handle == 0)
      $fatal("Unable to open expected Z data file");   
  for (int i = 0; i < FILE_SIZE; i = i + 1) begin
 //     for (int j = 0; j < MATRIX_SIZE; j = j + 1) begin
        tmp=$fscanf(expected_file_handle, "%h", z_data_cmp);
        //@(posedge clock);
        z_rd_addr=i;
        @(posedge clock);
        z_data_read=z_dout;
  //      @(posedge clock);
        if (z_data_cmp != z_data_read) begin
          z_errors++;
          $display("@ %0t :output Z contents:%h != %h at address i= %d",$time,z_data_read,z_data_cmp,i);
      end
   // end
  end
    if (z_errors==0) begin
      $display("Memory contents comparision success !!");
    end
    $fclose(expected_file_handle);
    $display("Memory contents comparision finish at @ %0t",$time);
    z_read_done=1;
  end

endmodule
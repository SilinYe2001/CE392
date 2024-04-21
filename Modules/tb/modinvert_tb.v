`timescale 1ns / 1ps

module tb_ModInvert;

// Parameters
localparam DATA_WIDTH = 1024;

// Interface signals
reg  clock;
reg  reset;
reg  din_valid;
wire din_ready;
reg  [DATA_WIDTH-1:0] din_bits_base;
reg  [DATA_WIDTH-1:0] din_bits_mod;
reg  dout_ready;
wire dout_valid;
wire [DATA_WIDTH-1:0] dout_bits_res;

// File handles
integer base_file, mod_file, r_base, r_mod;
integer output_file;

// Module instantiation
ModInvert uut (
    .clock(clock),
    .reset(reset),
    .din_ready(din_ready),
    .din_valid(din_valid),
    .din_bits_base(din_bits_base),
    .din_bits_mod(din_bits_mod),
    .dout_ready(dout_ready),
    .dout_valid(dout_valid),
    .dout_bits_res(dout_bits_res)
);

// Clock generation
always #5 clock = ~clock; // 100 MHz clock

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_ModInvert);
end
// Test sequence
initial begin
    // Initialize
    clock = 0;
    reset = 1;
    din_valid = 0;
    dout_ready = 0;
    din_bits_base = 0;
    din_bits_mod = 0;

    // Open files
    base_file = $fopen("private_key_ld.txt", "r");
    mod_file = $fopen("public_key_n.txt", "r");
    output_file = $fopen("output_results.txt", "w");

    // Check for errors in file opening
    if (base_file == 0 || mod_file == 0) begin
        $display("Error: could not open one or more input files.");
        $finish;
    end
    if (output_file == 0) begin
        $display("Error: could not open output file.");
        $finish;
    end

    // Reset release
    #10 reset = 0;
    
    // Read from files and process
    while (!$feof(base_file) && !$feof(mod_file)) begin
        r_base = $fscanf(base_file, "%h\n", din_bits_base); // Read base
        r_mod = $fscanf(mod_file, "%h\n", din_bits_mod); // Read mod
        if (r_base != 1 || r_mod != 1) begin
            $display("Error reading from file.");
            //break;
        end
        din_valid = 1;
        dout_ready = 1;
        @(posedge clock);
        while (!din_ready || !dout_valid) begin
            @(posedge clock);
        end
        
        @(posedge clock);
        // Output results if valid data is ready
       // if (dout_valid) begin
            $fdisplay(output_file, "%h", dout_bits_res);
       // end
        din_valid = 0;
        dout_ready = 0;
    end

    // Clean up
    $fclose(base_file);
    $fclose(mod_file);
    $fclose(output_file);
    $finish;
end

endmodule

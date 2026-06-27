`timescale 1ns / 1ps

module tb_lzc_loc();

    // Inputs
    reg [15:0] in;
    reg mode;

    // Outputs
    wire [4:0] count;

    // Instantiate the Unit Under Test (UUT)
    lzc_loc_16bit uut (
        .in(in), 
        .mode(mode),
        .count(count)
    );

    // VCD Dumping for GTKWave
    initial begin
        $dumpfile("lzc_loc_waveform.vcd"); 
        $dumpvars(0, tb_lzc_loc);          
    end

    // Stimulus
    initial begin
        $display("-------------------------------------------");
        $display("Starting LZC / LOC Verification...");
        
        // --- TEST SET 1: Leading Zero Count (mode = 0) ---
        $display("\n--- Testing LZC Mode (mode=0) ---");
        mode = 1'b0;
        
        in = 16'b0000_1111_0000_1111; #10;
        $display("Input: %b | Mode: LZC | Leading Zeros: %d (Expected: 4)", in, count);
        
        in = 16'b1000_0000_0000_0000; #10;
        $display("Input: %b | Mode: LZC | Leading Zeros: %d (Expected: 0)", in, count);

        in = 16'b0000_0000_0000_0000; #10;
        $display("Input: %b | Mode: LZC | Leading Zeros: %d (Expected: 16)", in, count);

        // --- TEST SET 2: Leading One Count (mode = 1) ---
        $display("\n--- Testing LOC Mode (mode=1) ---");
        mode = 1'b1;

        in = 16'b1111_0000_1111_0000; #10;
        $display("Input: %b | Mode: LOC | Leading Ones:  %d (Expected: 4)", in, count);

        in = 16'b0111_1111_1111_1111; #10;
        $display("Input: %b | Mode: LOC | Leading Ones:  %d (Expected: 0)", in, count);

        in = 16'b1111_1111_1111_1111; #10;
        $display("Input: %b | Mode: LOC | Leading Ones:  %d (Expected: 16)", in, count);

        $display("-------------------------------------------");
        $finish; 
    end
endmodule

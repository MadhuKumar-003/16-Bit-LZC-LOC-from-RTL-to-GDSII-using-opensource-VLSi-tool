module lzc_loc_16bit (
    input  [15:0] in,
    input         mode,  // 0 for Leading Zero Count (LZC), 1 for Leading One Count (LOC)
    output reg [4:0] count
);

    wire [15:0] process_data;
    
    // HARDWARE TRICK: If LOC mode is high, invert the input. 
    // This allows us to reuse the exact same zero-counting logic for both operations, saving 50% die area!
    assign process_data = mode ? ~in : in;

    // Using casez for strict Verilator compliance and optimal priority tree synthesis
    always @(*) begin
        casez (process_data)
            16'b1???_????_????_????: count = 5'd0;
            16'b01??_????_????_????: count = 5'd1;
            16'b001?_????_????_????: count = 5'd2;
            16'b0001_????_????_????: count = 5'd3;
            16'b0000_1???_????_????: count = 5'd4;
            16'b0000_01??_????_????: count = 5'd5;
            16'b0000_001?_????_????: count = 5'd6;
            16'b0000_0001_????_????: count = 5'd7;
            16'b0000_0000_1???_????: count = 5'd8;
            16'b0000_0000_01??_????: count = 5'd9;
            16'b0000_0000_001?_????: count = 5'd10;
            16'b0000_0000_0001_????: count = 5'd11;
            16'b0000_0000_0000_1???: count = 5'd12;
            16'b0000_0000_0000_01??: count = 5'd13;
            16'b0000_0000_0000_001?: count = 5'd14;
            16'b0000_0000_0000_0001: count = 5'd15;
            16'b0000_0000_0000_0000: count = 5'd16;
            default: count = 5'd0;
        endcase
    end

endmodule

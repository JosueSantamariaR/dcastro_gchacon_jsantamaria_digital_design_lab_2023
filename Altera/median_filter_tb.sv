
`timescale 1ns / 1ps

module median_filter_tb;

    // Testbench uses a 3x3 window of pixels
    logic clk, rst;
    logic[7:0] pixel_window[0:2][0:2];
    logic[7:0] pixel_out;

    // Instance of the median filter module
    median_filter uut (
        .clk(clk),
        .rst(rst),
        .pixel_window(pixel_window),
        .pixel_out(pixel_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = !clk; // Toggle clock every 5ns
    end

    // Test sequence
    initial begin
        // Initialize reset
        rst = 1;
        #10;
        rst = 0;

        // Apply test values to the pixel window
        pixel_window[0][0] = 8'd10;
        pixel_window[0][1] = 8'd15;
        pixel_window[0][2] = 8'd20;
        pixel_window[1][0] = 8'd25;
        pixel_window[1][1] = 8'd30; // This should be the median
        pixel_window[1][2] = 8'd35;
        pixel_window[2][0] = 8'd40;
        pixel_window[2][1] = 8'd45;
        pixel_window[2][2] = 8'd50;

        // Wait for a few clock cycles to allow the filter to process the pixels
        #100;

        // Check if the output is the expected median value
        if (pixel_out == 8'd30) begin
            $display("Test Passed: Median is correct.");
        end else begin
            $display("Test Failed: Median is incorrect.");
        end

        // Finish the simulation
        $finish;
    end

endmodule

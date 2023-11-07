
module median_filter(
    input logic clk,  // Clock signal
    input logic rst,  // Reset signal
    input logic[7:0] pixel_window[0:2][0:2],  // 3x3 window of pixels
    output logic[7:0] pixel_out  // Output pixel value after applying median filter
);

    // Internal signal to store the sorted values for median calculation
    logic[7:0] sorted[8:0];

    // Combinational logic to sort the pixels and find the median
    always_comb begin
        // Copy input pixels to the sorted array
        sorted[0] = pixel_window[0][0];
        sorted[1] = pixel_window[0][1];
        sorted[2] = pixel_window[0][2];
        sorted[3] = pixel_window[1][0];
        sorted[4] = pixel_window[1][1];
        sorted[5] = pixel_window[1][2];
        sorted[6] = pixel_window[2][0];
        sorted[7] = pixel_window[2][1];
        sorted[8] = pixel_window[2][2];
        
        // Bubble sort (naive sorting algorithm for demonstration purposes)
        // Normally you would use a more efficient sorting algorithm
        logic[7:0] temp;
        for (int i = 0; i < 8; i++) begin
            for (int j = 0; j < 8 - i; j++) begin
                if (sorted[j] > sorted[j + 1]) begin
                    // Swap elements
                    temp = sorted[j];
                    sorted[j] = sorted[j + 1];
                    sorted[j + 1] = temp;
                end
            end
        end
    end

    // Assign the median value to pixel_out (the fifth element of the sorted array)
    always_ff @(posedge clk) begin
        if (rst) begin
            pixel_out <= 0;
        end else begin
            pixel_out <= sorted[4];
        end
    end

endmodule

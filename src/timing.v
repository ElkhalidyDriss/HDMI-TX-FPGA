/**
 * @file timing.v
 * @brief Generic Timing Generator for Video Signals
 * 
 * @details 
 * This module generates horizontal and vertical synchronization signals (hSync and vSync), 
 * screen coordinates (counterX and counterY), and a Video Data Enable (VDE) signal for a 
 * configurable video resolution and timing parameters. The design supports generic configurations 
 * through parameters, enabling flexibility for various display standards.

 * @Author Idriss ELKHALIDY 

 * @param TOTAL_X    Total number of pixels in a horizontal line(including blanking intervals).
 * @param TOTAL_Y    Total number of lines in a frame(including blanking intervals).
 * @param H_SYNC_START Start position of the horizontal sync pulse.
 * @param H_SYNC_END   End position of the horizontal sync pulse.
 * @param V_SYNC_START Start position of the vertical sync pulse.
 * @param V_SYNC_END   End position of the vertical sync pulse.
 * @param ACTIVE_X     Number of active video pixels per line.
 * @param ACTIVE_Y     Number of active video lines per frame.
 * 
 * @inputs
 *   - pixel_clk: Clock signal for timing generation.
 *   - reset: Active-high reset signal to reset counters.
 * 
 * @outputs
 *   - hSync: Horizontal synchronization signal.
 *   - vSync: Vertical synchronization signal.
 *   - counterX, counterY: Current X and Y coordinates on the screen.
 *   - VDE: Video Data Enable signal, high during active video regions.
 * 
 */

module timing(
    input wire pixel_clk,
    input wire reset_n,
    output reg hSync, 
    output reg vSync,
    output reg [9:0] counterX,       // Current horizontal pixel position
    output reg [9:0] counterY,       // Current vertical line position
    output reg vde                  // Video Data Enable signal
);

    always @(posedge pixel_clk or negedge reset_n) begin
        if (!reset_n) begin
            counterX <= 0;
            counterY <= 0;
            hSync <= 0;
            vSync <= 0;
            vde <= 0;
        end else begin
            counterX <= (counterX == 799) ? 10'b0 : counterX + 1'b1;
            if (counterX == 799) begin
                counterY <= (counterY == 524) ? 10'b0 : counterY + 1'b1;
            end
            vde <= (counterX < 640) & (counterY < 480);
            hSync <= (counterX >= 656) & (counterX < 752);
            vSync <= (counterY >= 490) & (counterY < 492);
        end
    end

endmodule

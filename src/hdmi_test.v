/**
 * @file hdmi_test.v
 * @brief HDMI Test Module
 * @Author Idriss ELKHALIDY
 * @details 
 * This module is a top-level test design for an HDMI TMDS transmitter. 
 * It generates an HDMI-compatible video signal by combining clock generation, 
 * a timing controller, and the HDMI TMDS encoding process. The design is suitable 
 * for generating simple test patterns and verifying HDMI transmission functionality.
 * 
 * @inputs
 *   - sys_clk: System clock input (e.g., 24 MHz). Used as a reference for generating pixel and TMDS clocks.
 *   - reset_n: Active-low reset signal.
 */
module hdmi_test (
    input wire sys_clk,            // System clock (e.g., 24 MHz)
    input wire reset_n,              // Reset signal
    output wire [2:0] tmds_d_p,    // TMDS data signals (positive)
    output wire [2:0] tmds_d_n,    // TMDS data signals (negative)
    output wire tmds_clk_p,        // TMDS clock signal (positive)
    output wire tmds_clk_n        // TMDS clock signal (negative)
);
  
    /*Clock generation*/
    wire pixel_clk;  // Pixel clock (e.g., 25.175 MHz for 640x480)
    wire clk_x5;     // 5x pixel clock
    wire pll_lock;   // PLL lock signal
    Gowin_rPLL u_pll (
        .clkin(sys_clk),  // System clock
        .clkout(clk_x5),  // 5x pixel clock
        .lock(pll_lock)   // Lock signal
    );

    Gowin_CLKDIV u_div_5 (
        .clkout(pixel_clk),  // Pixel clock
        .hclkin(clk_x5),     // High-speed clock input
        .resetn(pll_lock)    // Reset signal (active low)
    );

    //timing controller
    wire hSync , vSync;
    wire [9:0] counterX , counterY;// Current horizontal and vertical pixel position
    wire vde;
    timing timing_controller(
         .pixel_clk(pixel_clk),
         .reset_n(reset_n),
         .hSync(hSync), 
         .vSync(vSync),
         .counterX(counterX),       // Current horizontal pixel position
         .counterY(counterY),       // Current vertical line position
         .vde(vde));
    //Video generation
   wire [7:0] red , green , blue;
   video_generator video_generator_instance(
       .pixel_clk(pixel_clk),
       .reset_n(reset_n),
       .counterX(counterX),
       .counterY(counterY),
       .red(red),
       .blue(blue),
       .green(green)
       );
    // TMDS encoder instance
    hdmi_tmds hdmi_tmds_instance (
        .clk(pixel_clk),        // Pixel clock
        .clk_x5(clk_x5),        // 5x pixel clock
        .reset_n(reset_n),      // Reset signal
        .blue(blue),            // Blue color component
        .green(green),          // Green color component
        .red(red),              // Red color component
        .aux_data_0(4'b0000),   // Auxiliary data for channel 0
        .aux_data_1(4'b0000),   // Auxiliary data for channel 1
        .aux_data_2(4'b0000),   // Auxiliary data for channel 2
        .hSync(hSync),          // Horizontal sync signal
        .vSync(vSync),          // Vertical sync signal
        .VDE(vde),              // Video Data Enable
        .ADE(1'b0),             // Auxiliary Data Enable , we are not going to use it for the moment 
        .tmds_d_p(tmds_d_p),    // TMDS data positive
        .tmds_d_n(tmds_d_n),    // TMDS data negative
        .tmds_clk_p(tmds_clk_p), // TMDS clock positive
        .tmds_clk_n(tmds_clk_n)  // TMDS clock negative
    );
   endmodule
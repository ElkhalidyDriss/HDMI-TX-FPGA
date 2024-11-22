
module hdmi_test (
    input wire sys_clk,            // System clock (e.g., 24 MHz)
    input wire reset_n,              // Reset signal
    output wire [2:0] tmds_d_p,    // TMDS data signals (positive)
    output wire [2:0] tmds_d_n,    // TMDS data signals (negative)
    output wire tmds_clk_p,        // TMDS clock signal (positive)
    output wire tmds_clk_n,         // TMDS clock signal (negative)
    output wire led[3:0]
);

    // Clock generation
    wire pixel_clk;  // Pixel clock (e.g., 25.175 MHz for 640x480)
    wire clk_x5;     // 5x pixel clock
    wire pll_lock;   // PLL lock signal
    wire reset;
    assign reset = ~reset_n;
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

    // VGA timing parameters for 640x480 resolution
    reg [10:0] counterX = 0, counterY = 0;  // Pixel counters
    reg hSync = 0, vSync = 0, vde = 0;         // Sync and video data enable signals
    assign led[0] = reset;
    assign led[1] = vde;
    assign led[2] = hSync;
    assign led[3] = vSync;
    always @(posedge pixel_clk or posedge reset) begin
        if (reset) begin
            counterX <= 0;
            counterY <= 0;
            hSync <= 0;
            vSync <= 0;
            vde <= 0;
        end else begin
            // Horizontal and vertical counters
            counterX <= (counterX == 799) ? 11'b0 : counterX + 1'b1;
            if (counterX == 799) begin
                counterY <= (counterY == 524) ? 11'b0 : counterY + 1'b1;
            end

            // Video Data Enable
            vde <= (counterX < 640) & (counterY < 480);

            // Horizontal Sync
            hSync <= (counterX >= 656) & (counterX < 752);

            // Vertical Sync
            vSync <= (counterY >= 490) & (counterY < 492);
        end
    end

    // Simple gradient test pattern
    reg [7:0] red, green, blue;
    wire [7:0] W = {8{counterX[7:0]==counterY[7:0]}};
    wire [7:0] A = {8{counterX[7:5]==3'h2 && counterY[7:5]==3'h5}};
    reg [7:0] red, green, blue;
    always @(posedge pixel_clk) red <= ({counterX[5:0] & {6{counterY[4:3]==~counterX[4:3]}}, 2'b00} | W) & ~A;
    always @(posedge pixel_clk) green <= (counterX[7:0] & {8{counterY[6]}} | W) & A;
    always @(posedge pixel_clk) blue <= counterY[7:0] | W | A;
 /*   always @(posedge pixel_clk) begin
        if (vde) begin
            red   <= counterX[7:0] ;  // Red gradient based on X position
            green <= counterY[7:0];  // Green gradient based on Y position
            blue  <= (counterX[7:0] ^ counterY[7:0]);  // Blue gradient (XOR pattern)
        end else begin
            red   <= 8'b0;
            green <= 8'b0;
            blue  <= 8'b0;
        end
    end
*/
    // TMDS encoder instance
    hdmi_tmds hdmi_tmds_instance (
        .clk(pixel_clk),        // Pixel clock
        .clk_x5(clk_x5),        // 5x pixel clock
        .reset(reset),          // Reset signal
        .blue(blue),            // Blue color component
        .green(green),          // Green color component
        .red(red),              // Red color component
        .aux_data_0(4'b0000),   // Auxiliary data for channel 0
        .aux_data_1(4'b0000),   // Auxiliary data for channel 1
        .aux_data_2(4'b0000),   // Auxiliary data for channel 2
        .hSync(hSync),          // Horizontal sync signal
        .vSync(vSync),          // Vertical sync signal
        .VDE(vde),              // Video Data Enable
        .ADE(1'b0),             // Auxiliary Data Enable (not used)
        .tmds_d_p(tmds_d_p),    // TMDS data positive
        .tmds_d_n(tmds_d_n),    // TMDS data negative
        .tmds_clk_p(tmds_clk_p), // TMDS clock positive
        .tmds_clk_n(tmds_clk_n)  // TMDS clock negative
    );

endmodule


/*
module hdmi_test (
       input wire sys_clk , //system clock clock 24MHz
       input wire reset, //reset 
       output wire[2:0] tmds_d_p,//tmds serialized signals (channel 0 , 1 and 2) positive
       output wire[2:0] tmds_d_n,
       output tmds_clk_p ,
       output tmds_clk_n
      // output hdmi_hpd //hdmi hot plug
       );
   
     //  assign hdmi_hpd = 1'b1;
       //Clock Generation
       wire pixel_clk;
       wire clk_x5;
       Gowin_rPLL u_pll (
  .clkin(sys_clk),
  .clkout(clk_x5),
  .lock(pll_lock)
);
Gowin_CLKDIV u_div_5 (
    .clkout(pixel_clk),
    .hclkin(clk_x5),
    .resetn(pll_lock)
);

       //
       reg [9:0] counterX , counterY;
       reg hSync , vSync , vde ; //vde : video data enable 
always @(posedge pixel_clk or posedge reset)
begin
    if (reset) begin
        vde <= 1'b0;
        counterX <= 0;
        counterY <= 0;
    end else begin
        vde <= (counterX < 640) && (counterY < 480);
        counterX <= (counterX == 799) ? 10'd0 : counterX + 1'b1;
        
        if (counterX == 799) begin
            counterY <= (counterY == 524) ? 10'd0 : counterY + 1'b1;
        end
        hSync <= (counterX>=656) && (counterX<752);
        vSync <= (counterY>=490) && (counterY<492);
    end
end

       //video generator for testing
        wire [7:0] W = {8{counterX[7:0]==counterY[7:0]}};
        wire [7:0] A = {8{counterX[7:5]==3'h2 && counterY[7:5]==3'h2}};
        reg [7:0] red , green , blue;
       always @(posedge pixel_clk) begin
            red   <=  ({counterX[5:0] & {6{counterY[4:3]==~counterX[4:3]}}, 2'b00} | W) & ~A;
            green <=  (counterX[7:0] & {8{counterY[6]}} | W) & ~A;
            blue  <= counterY[7:0] | W | A;
       end 
       
    wire [2:0] tmds_p_internal ;
       hdmi_tmds hdmi_tmds_instance
    (
    .clk(pixel_clk),//pixel clock
    .clk_x5(clk_x5),//5 times pixel clock 
    .reset(reset),
    .blue(blue) ,
    .green(green),
    .red(red), //pixel components
    .aux_data_0(4'b0000),
    .aux_data_1(4'b0000), 
    .aux_data_2(4'b0000), //auxilary data for channel 0 to 2
    .hSync(hSync) , 
    .vSync(vSync),
    .VDE(vde), //Video Data enable , indicates that we are on the data period 
    .ADE(1'b0), //Auxiliary data enable
    .tmds_d_p(tmds_d_p),//output of the serializer
    .tmds_d_n(tmds_d_n),
	.tmds_clk_n(tmds_clk_n),
	.tmds_clk_p(tmds_clk_p)
    ); 
endmodule
       */
       
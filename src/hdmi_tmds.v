




module hdmi_tmds
    (
    input wire clk,//pixel clock
    input wire clk_x5,//5 times pixel clock 
    input wire reset,
    input wire [7:0] blue , green , red, //pixel components
    input wire [3:0] aux_data_0 , aux_data_1 , aux_data_2, //auxilary data for channel 0 to 2
    input wire hSync , vSync,
    input wire VDE, //Video Data enable , indicates that we are on the data period 
    input wire ADE, //Auxiliary data enable
    output wire[2:0] tmds_d_p,//output of the serializer
    output wire[2:0] tmds_d_n,
	output       tmds_clk_n,
	output       tmds_clk_p
    );
    //Preamble
    reg c0 , c1 , c2 , c3;
    always @(posedge clk) 
    begin
         if(VDE) //video preamble
            {c0 , c1 , c2 , c3} <= 4'b1000;
         else if (ADE) //data island preamble
            {c0 , c1 , c2 , c3} <= 4'b1010;
         else //no control
            {c0 , c1 , c2 , c3} <= 4'b0000;
    end 
    /*10 Taps of Delay*/
    wire [7:0] blue_dly , green_dly ,  red_dly;//delayed pixel components by 10 TAPS (clocks)
    wire ADE_dly , VDE_dly; 
    wire hSync_dly , vSync_dly;
    wire [3:0] aux_data_0_dly , aux_data_1_dly , aux_data_2_dly;//delayed auxilary data 

    shift_reg_delay #(.TAPS(10)) delay_10_taps(
       .clk(clk),
       .reset(reset),
       .data_i({blue,green,red,ADE,VDE,hSync,vSync,aux_data_0,aux_data_1,aux_data_2}),//40 bit input data to be delayed
       .data_o({blue_dly,green_dly,red_dly,ADE_dly,VDE_dly,hSync_dly,vSync_dly,aux_data_0_dly,aux_data_1_dly,aux_data_2_dly}) //output delayed data
       );
    wire [9:0] encoded_data_0 , encoded_data_1  , encoded_data_2;//encoded data outputs from each encoder 
    /*Encoder Channel 0*/
    encoder #(
        .CHANNEL(0)  
    )channel_0_encoder (
        .clk(clk),//pixel clock
        .reset(reset),
        .pixel_component(blue_dly),
        .aux_data(aux_data_0_dly),
        .c0(hSync_dly),
        .c1(vSync_dly),
        .vde(VDE_dly),
        .ade(ADE_dly),
        .encoded_data(encoded_data_0)
    );
    /*Encoder channel 1*/
    encoder #(
        .CHANNEL(1)  
    )channel_1_encoder (
        .clk(clk),//pixel clock
        .reset(reset),
        .pixel_component(green_dly),
        .aux_data(aux_data_1_dly),
        .c0(c0),
        .c1(c1),
        .vde(VDE_dly),
        .ade(ADE_dly),
        .encoded_data(encoded_data_1)
    );
    /*Encoder channel 2*/
    encoder #(
        .CHANNEL(2)  
    )channel_2_encoder (
        .clk(clk),//pixel clock
        .reset(reset),
        .pixel_component(red_dly),
        .aux_data(aux_data_2_dly),
        .c0(c2),
        .c1(c3),
        .vde(VDE_dly),
        .ade(ADE_dly),
        .encoded_data(encoded_data_2)
    );
  
    
    /*Serializer*/
    /*OSER10 is Gowin's platform serializer | https://cdn.gowinsemi.com.cn/UG289E.pdf (page 92)*/
    wire[2:0] tmds_d;   
    OSER10 channel_0_serializer(
            .Q(tmds_d[0]),
            .D0(encoded_data_0[0]),
            .D1(encoded_data_0[1]),
            .D2(encoded_data_0[2]),
            .D3(encoded_data_0[3]),
            .D4(encoded_data_0[4]),
            .D5(encoded_data_0[5]),
            .D6(encoded_data_0[6]),
            .D7(encoded_data_0[7]),
            .D8(encoded_data_0[8]),
            .D9(encoded_data_0[9]),
            .PCLK(clk),
            .FCLK(clk_x5),
            .RESET(reset));
     defparam channel_0_serializer.GSREN="false";
     defparam channel_0_serializer.LSREN ="true";
    OSER10 channel_1_serializer(
            .Q(tmds_d[1]),
            .D0(encoded_data_1[0]),
            .D1(encoded_data_1[1]),
            .D2(encoded_data_1[2]),
            .D3(encoded_data_1[3]),
            .D4(encoded_data_1[4]),
            .D5(encoded_data_1[5]),
            .D6(encoded_data_1[6]),
            .D7(encoded_data_1[7]),
            .D8(encoded_data_1[8]),
            .D9(encoded_data_1[9]),
            .PCLK(clk),
            .FCLK(clk_x5),
            .RESET(reset));
     defparam channel_1_serializer.GSREN="false";
     defparam channel_1_serializer.LSREN ="true";
    OSER10 channel_2_serializer(
            .Q(tmds_d[2]),
            .D0(encoded_data_2[0]),
            .D1(encoded_data_2[1]),
            .D2(encoded_data_2[2]),
            .D3(encoded_data_2[3]),
            .D4(encoded_data_2[4]),
            .D5(encoded_data_2[5]),
            .D6(encoded_data_2[6]),
            .D7(encoded_data_2[7]),
            .D8(encoded_data_2[8]),
            .D9(encoded_data_2[9]),
            .PCLK(clk),
            .FCLK(clk_x5),
            .RESET(reset));
     
     defparam channel_2_serializer.GSREN="false";
     defparam channel_2_serializer.LSREN ="true";
     ELVDS_OBUF tmds_bufds [3:0] (
		.I({clk, tmds_d}),
		.O({tmds_clk_p, tmds_d_p}),
		.OB({tmds_clk_n, tmds_d_n})
	 );
   endmodule
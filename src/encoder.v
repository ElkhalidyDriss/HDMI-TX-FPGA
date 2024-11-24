/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * *
 * @file encoder.v                                                                              *
 * @brief TMDS Encoder for HDMI Transmission                                                    *
 *                                                                                              *         
 * @details This module implements the HDMI TMDS (Transition Minimized Differential Signaling)  *
 * encoding scheme as defined in HDMI Specification 1.3. It encodes video, auxiliary,           *
 * and control data into a 10-bit TMDS format suitable for HDMI transmission.                   *
 *                                                                                              *
 * @author Idriss ELKHALIDY                                                                     *
 * @date   November 2024                                                                        *
 *                                                                                              *
 * @param CHANNEL Configures the HDMI channel number (0, 1, or 2).                              *
 *                                                                                              * 
 * @inputs                                                                                      *
 *   - clk: Pixel clock signal.                                                                 *
 *   - reset_n: Active-low asynchronous reset signal.                                           *
 *   - pixel_component: 8-bit pixel component value (Red, Green, or Blue).                      *
 *   - aux_data: 4-bit auxiliary data (e.g., audio or control signals).                         *
 *   - c0, c1: Control bits (Hsync, Vsync for Channel 0).                                       *
 *   - vde: Video Data Enable signal; high when we are in the video data period.                *
 *   - ade: Auxiliary Data Enable signal; high when we are in data island period.               *
 * @outputs                                                                                     *
 *   - encoded_data: 10-bit TMDS-encoded output data.                                           *
 *                                                                                              *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * */


module encoder #(parameter  CHANNEL = 0)(
  input wire clk,                   //Pixel clock signal
  input wire reset_n,               //Active low asynchronous reset
  input wire [7:0] pixel_component, //pixel component could be the value of Blue , Green or Red colors
  input wire [3:0] aux_data,        //audio/auxilary data
  input wire c0,                    //C0  control bit (Hsync in case of Channel 0 )
  input wire c1,                    //C1 control bit (Vsync for channel 0)
  input wire vde,                   //video enable signal , indicates that encoded pixel component should be placed in the output 
  input  wire ade,                  // audio/auxilary data enable signal , indicares that encoded aux_data should be placed at the output
  output reg [9:0]  encoded_data    //encoded  data outputs 
);
  /*!Naming conventions are based on @HDMI Specification 1.3*/
  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
   *                        TMDS encoding scheme                             *
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    reg [3:0] pixel_comp_ones_count; //number of ones in pix_component
    reg [7:0] pixel_component_q;     //pixel_component register 
    reg[8:0] q_m;                   //Intermediate value (Transition Minimization stage output)
 
  //pixelc_components ones counter 
  always @(posedge clk)
  begin
       pixel_comp_ones_count <= pixel_component[0] + pixel_component[1] + pixel_component[2] + pixel_component[3] + pixel_component[4] + pixel_component[5] + pixel_component[6] + pixel_component[7];
       pixel_component_q <= pixel_component;
  end
  /*Transition minimization Stage */ 
  always @(*)
  begin
       q_m[0] = pixel_component_q[0];
       if (pixel_comp_ones_count > 4 | ((pixel_comp_ones_count == 4'h4) & (pixel_component_q[0] == 1'b0)))
       begin
            q_m[1] = q_m[0] ~^ pixel_component_q[1];
            q_m[2] = q_m[1] ~^ pixel_component_q[2];
            q_m[3] = q_m[2] ~^ pixel_component_q[3];
            q_m[4] = q_m[3] ~^ pixel_component_q[4];
            q_m[5] = q_m[4] ~^ pixel_component_q[5];
            q_m[6] = q_m[5] ~^ pixel_component_q[6];
            q_m[7] = q_m[6] ~^ pixel_component_q[7];
            q_m[8] = 1'b0; 
       end 
       else 
       begin
            q_m[1] = q_m[0] ^ pixel_component_q[1];
            q_m[2] = q_m[1] ^ pixel_component_q[2];
            q_m[3] = q_m[2] ^ pixel_component_q[3];
            q_m[4] = q_m[3] ^ pixel_component_q[4];
            q_m[5] = q_m[4] ^ pixel_component_q[5];
            q_m[6] = q_m[5] ^ pixel_component_q[6];
            q_m[7] = q_m[6] ^ pixel_component_q[7];
            q_m[8] = 1'b1; 
       end 
  end   
  /*DC Balance stage */
  reg [3:0] q_m_ones_count , q_m_zeros_count;
  always @(posedge clk)
  begin
        q_m_ones_count   <=  q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7];
        q_m_zeros_count <= 4'h8 - ( q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7]);
  end 

  reg vde_q , vde_reg ;//vde_q output of the first pipeline stage , vde_reg output of the second pipeline stage
  reg ade_q , ade_reg  , ade_reg_q , ade_reg_qq;//ade_q output of the first pipeline stage , ade_reg output of the second pipeline stage
  reg c0_q, c1_q , c0_reg, c1_reg;
  reg [3:0] aux_data_q , aux_data_reg;
  reg [8:0] q_m_reg;
  always @(posedge clk)
  begin
       vde_q <= vde;//fisrt Pipeline stage 
       vde_reg <= vde_q; //second pipeline stage 

       ade_q <= ade;//fisrt Pipeline stage 
       ade_reg <= ade_q;//second pipeline stage 
       ade_reg_q <= ade_reg;
       ade_reg_qq <= ade_reg_q;

       c0_q    <= c0;
       c0_reg  <= c0_q;
       c1_q    <= c1;
       c1_reg  <= c1_q;

       aux_data_q <= aux_data;
       aux_data_reg <= aux_data_q;

       q_m_reg <= q_m;       
  end 
  reg[4:0] cnt;//bit 5 holds the sign;pixel_component's disparity counter; ;Disparity of a data stream is calculated as follows : Disparity = count_of_1s - count_of_zeros
  //Video leading guardband value based on TMDS channel number 
  reg [9:0] VIDEO_GUARD_BAND;
  reg [9:0] DATA_ISLAND_GUARD_BD;
  generate 
          
          if (CHANNEL == 0) begin
            always @(*) begin
              VIDEO_GUARD_BAND = 10'b1011001100;
              DATA_ISLAND_GUARD_BD = 10'bxxxxxxxxxx;//when channel 0 , don't care because there is no guardband period for it.
            end
          end else if (CHANNEL == 1) begin
            always @(*) begin
              VIDEO_GUARD_BAND = 10'b0100110011;
              DATA_ISLAND_GUARD_BD = 10'b0100110011;
            end
          end else begin //CHANNEL 2
             always @(*) begin
              VIDEO_GUARD_BAND = 10'b1011001100;
              DATA_ISLAND_GUARD_BD = 10'b0100110011;
             end
          end 
  endgenerate
  wire ade_valid;
  wire[3:0] actual_aux_data;//actual aux data that must be sent based on the channel number 
  generate 
  if (CHANNEL == 0) begin 
      assign ade_valid = ade | ade_reg | ade_reg_qq;
      assign actual_aux_data = ((ade & !ade_reg) | (ade_reg_qq & !ade_reg)) ? {2'b11,c1_reg,c0_reg} : {aux_data[3:2],c1_reg,c0_reg}; //condition is for testing if we are on the first or final guardband period or not
  end else begin //CHANNEL 1 or 2
      assign ade_valid = ade_reg;
      assign actual_aux_data = aux_data_reg;
  end 
  endgenerate
                               
  always @(posedge clk or negedge reset_n)
  begin
       if (!reset_n) begin
           encoded_data <= 10'b0;
           cnt <=  5'b0;
       end
       else begin
            if(vde_reg) begin //Period : Video Data
               if((cnt == 5'b0) || (q_m_ones_count == q_m_zeros_count)) begin
                  encoded_data[9]   <= ~q_m_reg[8];
                  encoded_data[8]   <=  q_m_reg[8];
                  encoded_data[7:0] <= (q_m_reg[8])? q_m_reg[7:0] : ~q_m_reg[7:0];
                  cnt <= (~q_m_reg[8]) ? (cnt + q_m_zeros_count - q_m_ones_count) : (cnt + q_m_ones_count - q_m_zeros_count);
               end else begin
                   if ((~cnt[4] && (q_m_ones_count > q_m_zeros_count)) || (cnt[4] & (q_m_zeros_count > q_m_ones_count)))begin
                      encoded_data[9]   <=  1'b1;
                      encoded_data[8]   <=  q_m_reg[8];
                      encoded_data[7:0] <= ~q_m_reg[7:0];
                      cnt <= cnt + {q_m_reg[8], 1'b0} + (q_m_zeros_count - q_m_ones_count);
                    end else begin
                      encoded_data[9]   <= 1'b0;
                      encoded_data[8]   <= q_m_reg[8];
                      encoded_data[7:0] <= q_m_reg[7:0];
                      cnt <= cnt - {~q_m_reg[8], 1'b0} + (q_m_ones_count - q_m_zeros_count);  
                    end 
                end       
            end else begin
                if (vde) //Period : Video Guard 
                   encoded_data <= VIDEO_GUARD_BAND;
                else if (ade_valid) begin //Period : Auxilary data 
  /***************************************************************************
   *                        TERC encoding scheme                             *
   ***************************************************************************/
                   case (actual_aux_data)
                        4'b0000: encoded_data[9:0] = 10'b1010011100;
                        4'b0001: encoded_data[9:0] = 10'b1001100011;
                        4'b0010: encoded_data[9:0] = 10'b1011100100;
                        4'b0011: encoded_data[9:0] = 10'b1011100010;
                        4'b0100: encoded_data[9:0] = 10'b0101110001;
                        4'b0101: encoded_data[9:0] = 10'b0100011110;
                        4'b0110: encoded_data[9:0] = 10'b0110001110;
                        4'b0111: encoded_data[9:0] = 10'b0100111100;
                        4'b1000: encoded_data[9:0] = 10'b1011001100;
                        4'b1001: encoded_data[9:0] = 10'b0100111001;
                        4'b1010: encoded_data[9:0] = 10'b0110011100;
                        4'b1011: encoded_data[9:0] = 10'b1011000110;
                        4'b1100: encoded_data[9:0] = 10'b1010001110;
                        4'b1101: encoded_data[9:0] = 10'b1001110001;
                        4'b1110: encoded_data[9:0] = 10'b0101100011;
                        4'b1111: encoded_data[9:0] = 10'b1011000011;
                   endcase
                end 
                else if ((ade | ade_reg_qq) && (CHANNEL != 0)) /*Period : Data Island Guard band*/
                   encoded_data <= DATA_ISLAND_GUARD_BD;
                else begin//Period : Preamble
                   case({c1_reg , c0_reg})
                   2'b00 : encoded_data <= 10'b1101010100;
                   2'b01 : encoded_data <= 10'b0010101011;
                   2'b10 : encoded_data <= 10'b0101010100;
                   2'b11 : encoded_data <= 10'b1010101011;
                   endcase
                end
                cnt <= 5'b0;//Restting disparity counter for the next video period computation
            end 
        end 
  end 
  endmodule
  



  

/**
 * @file shift_reg_delay.v
 * @brief Shift Register Delay Module
 * 
 * @details 
 * This module implements a generic shift register to delay input data by a specified 
 * number of clock cycles (TAPS). The delay is achieved by cascading registers in series, 
 * and the module outputs the delayed data after the specified number of taps.
 * 
 * @Author Idriss ELKHALIDY
 *
 * @param TAPS Number of clock cycles to delay the input data. Default is 10.
 * 
 * @inputs
 *   - clk: Clock signal to drive the shift register.
 *   - reset_n: Active-low asynchronous reset signal to clear the registers.
 *   - data_i: 40-bit input data to be delayed.
 * 
 * @outputs
 *   - data_o: 40-bit delayed output data, available after TAPS clock cycles.
 */

module shift_reg_delay #(TAPS = 10)(
       input wire clk,
       input wire reset_n,
       input wire [39:0] data_i,//input data to be delayed
       output reg [39:0] data_o //output delayed data
       );
       integer i;
       reg [39:0] shift_reg [TAPS-1:0]; //Array of registers for TAPS taps
       always @(posedge clk , negedge reset_n)
       begin
            if (!reset_n) begin
                for (i=0;i < TAPS ; i=i+1) begin
                     shift_reg[i] <= 40'b0;
                end
            end 
            else begin 
                shift_reg[0] <= data_i;
                for (i = 1; i < TAPS; i = i + 1) begin
                    shift_reg[i] <= shift_reg[i - 1];
                end 
                data_o <= shift_reg[TAPS-1];
            end
       end
endmodule
       
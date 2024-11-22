module shift_reg_delay #(TAPS = 10)(
       input wire clk,
       input wire reset,
       input wire [39:0] data_i,//input data to be delayed
       output reg [39:0] data_o //output delayed data
       );
       integer i;
       reg [39:0] shift_reg [TAPS-1:0]; //Array of registers for TAPS taps
       always @(posedge clk , posedge reset)
       begin
            if (reset) begin
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
       



module timing 
( 
   input wire pixel_clk,
   input wire reset,
   output wire hSync , vSync,
   output reg [9:0] counterX , counterY, //Screen X,Y coordinates
   output wire VDE//Video data enable
);
   always @(posedge pixel_clk)
   begin
        counterX <= (counterX==799) ? 0 : counterX+1;  
   end
   always @(posedge pixel_clk)
   begin
        if (counterX == 799) begin
            counterY <= (counterY == 524) ? 0 : counterY + 1;
        end
   end
   assign hSync = (counterX>=656) && (counterX<752);
   assign vSync = (counterY>=490) && (counterY<492);
   assign VDE = (counterX<640) && (counterY<480);//Draw area
endmodule




module video_generator #(parameter BACKGROUND_COLOR = 24'h62008f ,CHARACTER_COLOR = 24'hffffff)(
       input wire pixel_clk,
       input wire reset_n,
       input wire  [9:0] counterX,counterY,//Current (x,y) pixel position
       output reg [7:0] red,blue,green//current pixel color values 
       );
       wire[7:0] char_ascii;
       wire [2:0] row;
       wire [7:0] pixels;
       fonts fonts_memory(
            .char_code(char_ascii),  // ASCII character code
            .row(row),        // Row index (0 to 7)
            .pixels(pixels) // Pixel data for the selected row
       );
       reg [7:0] ram_text[0:27]; // Array for 28 characters
always @(posedge pixel_clk ) begin
        ram_text[0]  <= 8'h44; // 'D'
        ram_text[1]  <= 8'h65; // 'e'
        ram_text[2]  <= 8'h73; // 's'
        ram_text[3]  <= 8'h69; // 'i'
        ram_text[4]  <= 8'h67; // 'g'
        ram_text[5]  <= 8'h6E; // 'n'
        ram_text[6]  <= 8'h65; // 'e'
        ram_text[7]  <= 8'h64; // 'd'
        ram_text[8]  <= 8'h20; // (space)
        ram_text[9]  <= 8'h42; // 'B'
        ram_text[10] <= 8'h79; // 'y'
        ram_text[11] <= 8'h20; // (space)
        ram_text[12] <= 8'h49; // 'I'
        ram_text[13] <= 8'h64; // 'd'
        ram_text[14] <= 8'h72; // 'r'
        ram_text[15] <= 8'h69; // 'i'
        ram_text[16] <= 8'h73; // 's'
        ram_text[17] <= 8'h73; // 's'
        ram_text[18] <= 8'h20; // (space)
        ram_text[19] <= 8'h45; // 'E'
        ram_text[20] <= 8'h6C; // 'l'
        ram_text[21] <= 8'h6B; // 'k'
        ram_text[22] <= 8'h68; // 'h'
        ram_text[23] <= 8'h61; // 'a'
        ram_text[24] <= 8'h6C; // 'l'
        ram_text[25] <= 8'h69; // 'i'
        ram_text[26] <= 8'h64; // 'd'
        ram_text[27] <= 8'h79; // 'y'
end
       wire[7:0] char_x , char_y ;//position of the character
       reg[24:0] counter;
       reg toggle_screen;
    
        
       always @(posedge pixel_clk or negedge reset_n)
       begin
             if (!reset_n) begin
                 counter <= 25'b0;
                 toggle_screen <= 1'b1;
             end else begin 
                 if (counter < 25000000 - 1)  begin
                     counter <= counter + 25'b1;
                 end else begin
                        toggle_screen <= toggle_screen ^ 1'b1;
                        counter <= 25'b0;
                 end 
                 end 
       end 
       wire [2:0] pixel_x ,pixel_y;//coordinate of the pixel within each a character
       assign  char_ascii =  ram_text[char_x];
       assign  row =  pixel_y;
       assign char_x = counterX / 8;
       assign char_y = counterY / 8;
       assign pixel_x = counterX % 8;
       assign pixel_y = counterY % 8;

       always @(posedge pixel_clk or negedge reset_n) begin
              if (!reset_n) 
                 {red,green,blue} <= BACKGROUND_COLOR;
              else begin
                 if ((char_y == 7'b1)&&(char_x <= 7'd27)) begin
                    if (pixels[pixel_x] == 1'b1)
                        {red,green,blue} <= CHARACTER_COLOR; 
                     else 
                         {red,green,blue} <=  (toggle_screen == 1) ? BACKGROUND_COLOR : 24'hfa9d11;
                 end else begin
                         {red,green,blue} <=  (toggle_screen == 1) ? BACKGROUND_COLOR : 24'hfa9d11; 
                 end    
              end 
 
       end

       endmodule 
       
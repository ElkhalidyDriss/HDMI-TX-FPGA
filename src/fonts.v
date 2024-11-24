// Verilog font ROM table generated by Python
module fonts (
    input [7:0] char_code,  // ASCII character code
    input [2:0] row,        // Row index (0 to 7)
    output reg [7:0] pixels // Pixel data for the selected row
);

    reg [7:0] font_memory [0:1023];
    initial begin
        font_memory[0] =  8'b00000000;
        font_memory[1] =  8'b00000000;
        font_memory[2] =  8'b00000000;
        font_memory[3] =  8'b00000000;
        font_memory[4] =  8'b00000000;
        font_memory[5] =  8'b00000000;
        font_memory[6] =  8'b00000000;
        font_memory[7] =  8'b00000000;

        font_memory[8] =  8'b00100000;
        font_memory[9] =  8'b00100000;
        font_memory[10] =  8'b00010000;
        font_memory[11] =  8'b00010000;
        font_memory[12] =  8'b00001000;
        font_memory[13] =  8'b00000000;
        font_memory[14] =  8'b00000100;
        font_memory[15] =  8'b00000000;

        font_memory[16] =  8'b00100100;
        font_memory[17] =  8'b00100100;
        font_memory[18] =  8'b00000000;
        font_memory[19] =  8'b00000000;
        font_memory[20] =  8'b00000000;
        font_memory[21] =  8'b00000000;
        font_memory[22] =  8'b00000000;
        font_memory[23] =  8'b00000000;

        font_memory[24] =  8'b00000000;
        font_memory[25] =  8'b00100100;
        font_memory[26] =  8'b01111110;
        font_memory[27] =  8'b00100100;
        font_memory[28] =  8'b00100100;
        font_memory[29] =  8'b01111110;
        font_memory[30] =  8'b00100100;
        font_memory[31] =  8'b00000000;

        font_memory[32] =  8'b00010000;
        font_memory[33] =  8'b00111100;
        font_memory[34] =  8'b00010010;
        font_memory[35] =  8'b00111100;
        font_memory[36] =  8'b01001000;
        font_memory[37] =  8'b01001010;
        font_memory[38] =  8'b00111100;
        font_memory[39] =  8'b00001000;

        font_memory[40] =  8'b01000010;
        font_memory[41] =  8'b00100101;
        font_memory[42] =  8'b00010010;
        font_memory[43] =  8'b00001000;
        font_memory[44] =  8'b00100100;
        font_memory[45] =  8'b01010010;
        font_memory[46] =  8'b00100001;
        font_memory[47] =  8'b00000000;

        font_memory[48] =  8'b00000000;
        font_memory[49] =  8'b00001100;
        font_memory[50] =  8'b00010010;
        font_memory[51] =  8'b01001100;
        font_memory[52] =  8'b00110010;
        font_memory[53] =  8'b00100010;
        font_memory[54] =  8'b01011100;
        font_memory[55] =  8'b00000000;

        font_memory[56] =  8'b00001000;
        font_memory[57] =  8'b00001000;
        font_memory[58] =  8'b00000100;
        font_memory[59] =  8'b00000000;
        font_memory[60] =  8'b00000000;
        font_memory[61] =  8'b00000000;
        font_memory[62] =  8'b00000000;
        font_memory[63] =  8'b00000000;

        font_memory[64] =  8'b00100000;
        font_memory[65] =  8'b00010000;
        font_memory[66] =  8'b00001000;
        font_memory[67] =  8'b00001000;
        font_memory[68] =  8'b00001000;
        font_memory[69] =  8'b00001000;
        font_memory[70] =  8'b00010000;
        font_memory[71] =  8'b00100000;

        font_memory[72] =  8'b00000100;
        font_memory[73] =  8'b00001000;
        font_memory[74] =  8'b00010000;
        font_memory[75] =  8'b00010000;
        font_memory[76] =  8'b00010000;
        font_memory[77] =  8'b00010000;
        font_memory[78] =  8'b00001000;
        font_memory[79] =  8'b00000100;

        font_memory[80] =  8'b00001000;
        font_memory[81] =  8'b00101010;
        font_memory[82] =  8'b00011100;
        font_memory[83] =  8'b00101010;
        font_memory[84] =  8'b00001000;
        font_memory[85] =  8'b00000000;
        font_memory[86] =  8'b00000000;
        font_memory[87] =  8'b00000000;

        font_memory[88] =  8'b00000000;
        font_memory[89] =  8'b00001000;
        font_memory[90] =  8'b00001000;
        font_memory[91] =  8'b00111110;
        font_memory[92] =  8'b00001000;
        font_memory[93] =  8'b00001000;
        font_memory[94] =  8'b00000000;
        font_memory[95] =  8'b00000000;

        font_memory[96] =  8'b00000000;
        font_memory[97] =  8'b00000000;
        font_memory[98] =  8'b00000000;
        font_memory[99] =  8'b00000000;
        font_memory[100] =  8'b00000000;
        font_memory[101] =  8'b00000000;
        font_memory[102] =  8'b00001000;
        font_memory[103] =  8'b00000100;

        font_memory[104] =  8'b00000000;
        font_memory[105] =  8'b00000000;
        font_memory[106] =  8'b00000000;
        font_memory[107] =  8'b00111110;
        font_memory[108] =  8'b00000000;
        font_memory[109] =  8'b00000000;
        font_memory[110] =  8'b00000000;
        font_memory[111] =  8'b00000000;

        font_memory[112] =  8'b00000000;
        font_memory[113] =  8'b00000000;
        font_memory[114] =  8'b00000000;
        font_memory[115] =  8'b00000000;
        font_memory[116] =  8'b00000000;
        font_memory[117] =  8'b00000000;
        font_memory[118] =  8'b00001000;
        font_memory[119] =  8'b00000000;

        font_memory[120] =  8'b00100000;
        font_memory[121] =  8'b00010000;
        font_memory[122] =  8'b00010000;
        font_memory[123] =  8'b00001000;
        font_memory[124] =  8'b00000100;
        font_memory[125] =  8'b00000100;
        font_memory[126] =  8'b00000010;
        font_memory[127] =  8'b00000000;

        font_memory[128] =  8'b00111000;
        font_memory[129] =  8'b01000100;
        font_memory[130] =  8'b01000010;
        font_memory[131] =  8'b01000010;
        font_memory[132] =  8'b01000010;
        font_memory[133] =  8'b00100010;
        font_memory[134] =  8'b00011100;
        font_memory[135] =  8'b00000000;

        font_memory[136] =  8'b00001000;
        font_memory[137] =  8'b00001100;
        font_memory[138] =  8'b00001000;
        font_memory[139] =  8'b00001000;
        font_memory[140] =  8'b00001000;
        font_memory[141] =  8'b00001000;
        font_memory[142] =  8'b00111110;
        font_memory[143] =  8'b00000000;

        font_memory[144] =  8'b00111100;
        font_memory[145] =  8'b01000010;
        font_memory[146] =  8'b01000000;
        font_memory[147] =  8'b00110000;
        font_memory[148] =  8'b00001100;
        font_memory[149] =  8'b00000010;
        font_memory[150] =  8'b01111110;
        font_memory[151] =  8'b00000000;

        font_memory[152] =  8'b01111100;
        font_memory[153] =  8'b00100000;
        font_memory[154] =  8'b00010000;
        font_memory[155] =  8'b00111000;
        font_memory[156] =  8'b01000000;
        font_memory[157] =  8'b01000010;
        font_memory[158] =  8'b00111100;
        font_memory[159] =  8'b00000000;

        font_memory[160] =  8'b00110000;
        font_memory[161] =  8'b00101000;
        font_memory[162] =  8'b00100100;
        font_memory[163] =  8'b00100010;
        font_memory[164] =  8'b01111110;
        font_memory[165] =  8'b00100000;
        font_memory[166] =  8'b00100000;
        font_memory[167] =  8'b00000000;

        font_memory[168] =  8'b01111100;
        font_memory[169] =  8'b00000100;
        font_memory[170] =  8'b00111100;
        font_memory[171] =  8'b01000000;
        font_memory[172] =  8'b01000000;
        font_memory[173] =  8'b01000010;
        font_memory[174] =  8'b00111100;
        font_memory[175] =  8'b00000000;

        font_memory[176] =  8'b00111000;
        font_memory[177] =  8'b00000100;
        font_memory[178] =  8'b00000010;
        font_memory[179] =  8'b00111110;
        font_memory[180] =  8'b01000010;
        font_memory[181] =  8'b01000010;
        font_memory[182] =  8'b00111100;
        font_memory[183] =  8'b00000000;

        font_memory[184] =  8'b01111110;
        font_memory[185] =  8'b01000010;
        font_memory[186] =  8'b00100000;
        font_memory[187] =  8'b00010000;
        font_memory[188] =  8'b00010000;
        font_memory[189] =  8'b00001000;
        font_memory[190] =  8'b00001000;
        font_memory[191] =  8'b00000000;

        font_memory[192] =  8'b00011100;
        font_memory[193] =  8'b00100010;
        font_memory[194] =  8'b00100010;
        font_memory[195] =  8'b00111100;
        font_memory[196] =  8'b01000010;
        font_memory[197] =  8'b01000010;
        font_memory[198] =  8'b00111100;
        font_memory[199] =  8'b00000000;

        font_memory[200] =  8'b00111100;
        font_memory[201] =  8'b01000010;
        font_memory[202] =  8'b01000010;
        font_memory[203] =  8'b01111100;
        font_memory[204] =  8'b01000000;
        font_memory[205] =  8'b00100000;
        font_memory[206] =  8'b00011100;
        font_memory[207] =  8'b00000000;

        font_memory[208] =  8'b00000000;
        font_memory[209] =  8'b00001000;
        font_memory[210] =  8'b00000000;
        font_memory[211] =  8'b00000000;
        font_memory[212] =  8'b00000000;
        font_memory[213] =  8'b00000000;
        font_memory[214] =  8'b00001000;
        font_memory[215] =  8'b00000000;

        font_memory[216] =  8'b00000000;
        font_memory[217] =  8'b00001000;
        font_memory[218] =  8'b00000000;
        font_memory[219] =  8'b00000000;
        font_memory[220] =  8'b00000000;
        font_memory[221] =  8'b00000000;
        font_memory[222] =  8'b00001000;
        font_memory[223] =  8'b00000100;

        font_memory[224] =  8'b00000000;
        font_memory[225] =  8'b01100000;
        font_memory[226] =  8'b00011000;
        font_memory[227] =  8'b00000100;
        font_memory[228] =  8'b00011000;
        font_memory[229] =  8'b01100000;
        font_memory[230] =  8'b00000000;
        font_memory[231] =  8'b00000000;

        font_memory[232] =  8'b00000000;
        font_memory[233] =  8'b00000000;
        font_memory[234] =  8'b01111100;
        font_memory[235] =  8'b00000000;
        font_memory[236] =  8'b01111100;
        font_memory[237] =  8'b00000000;
        font_memory[238] =  8'b00000000;
        font_memory[239] =  8'b00000000;

        font_memory[240] =  8'b00000000;
        font_memory[241] =  8'b00001100;
        font_memory[242] =  8'b00110000;
        font_memory[243] =  8'b01000000;
        font_memory[244] =  8'b00110000;
        font_memory[245] =  8'b00001100;
        font_memory[246] =  8'b00000000;
        font_memory[247] =  8'b00000000;

        font_memory[248] =  8'b00111100;
        font_memory[249] =  8'b01000010;
        font_memory[250] =  8'b01000000;
        font_memory[251] =  8'b00110000;
        font_memory[252] =  8'b00001000;
        font_memory[253] =  8'b00000000;
        font_memory[254] =  8'b00001000;
        font_memory[255] =  8'b00000000;

        font_memory[256] =  8'b00111100;
        font_memory[257] =  8'b01000010;
        font_memory[258] =  8'b01011001;
        font_memory[259] =  8'b01010101;
        font_memory[260] =  8'b00111101;
        font_memory[261] =  8'b00000001;
        font_memory[262] =  8'b00111110;
        font_memory[263] =  8'b00000000;

        font_memory[264] =  8'b00011000;
        font_memory[265] =  8'b00100100;
        font_memory[266] =  8'b00100100;
        font_memory[267] =  8'b01000010;
        font_memory[268] =  8'b01111110;
        font_memory[269] =  8'b01000010;
        font_memory[270] =  8'b01000010;
        font_memory[271] =  8'b00000000;

        font_memory[272] =  8'b00011110;
        font_memory[273] =  8'b00100010;
        font_memory[274] =  8'b00100010;
        font_memory[275] =  8'b00111110;
        font_memory[276] =  8'b01000010;
        font_memory[277] =  8'b01000010;
        font_memory[278] =  8'b00111110;
        font_memory[279] =  8'b00000000;

        font_memory[280] =  8'b00111000;
        font_memory[281] =  8'b01000100;
        font_memory[282] =  8'b00000010;
        font_memory[283] =  8'b00000010;
        font_memory[284] =  8'b00000010;
        font_memory[285] =  8'b01000100;
        font_memory[286] =  8'b00111000;
        font_memory[287] =  8'b00000000;

        font_memory[288] =  8'b00011110;
        font_memory[289] =  8'b00100010;
        font_memory[290] =  8'b01000010;
        font_memory[291] =  8'b01000010;
        font_memory[292] =  8'b01000010;
        font_memory[293] =  8'b00100010;
        font_memory[294] =  8'b00011110;
        font_memory[295] =  8'b00000000;

        font_memory[296] =  8'b01111110;
        font_memory[297] =  8'b00000010;
        font_memory[298] =  8'b00000010;
        font_memory[299] =  8'b00011110;
        font_memory[300] =  8'b00000010;
        font_memory[301] =  8'b00000010;
        font_memory[302] =  8'b01111110;
        font_memory[303] =  8'b00000000;

        font_memory[304] =  8'b01111110;
        font_memory[305] =  8'b00000010;
        font_memory[306] =  8'b00000010;
        font_memory[307] =  8'b00011110;
        font_memory[308] =  8'b00000010;
        font_memory[309] =  8'b00000010;
        font_memory[310] =  8'b00000010;
        font_memory[311] =  8'b00000000;

        font_memory[312] =  8'b01111000;
        font_memory[313] =  8'b00000100;
        font_memory[314] =  8'b00000010;
        font_memory[315] =  8'b01100010;
        font_memory[316] =  8'b01000010;
        font_memory[317] =  8'b01000100;
        font_memory[318] =  8'b01111000;
        font_memory[319] =  8'b00000000;

        font_memory[320] =  8'b01000010;
        font_memory[321] =  8'b01000010;
        font_memory[322] =  8'b01000010;
        font_memory[323] =  8'b01111110;
        font_memory[324] =  8'b01000010;
        font_memory[325] =  8'b01000010;
        font_memory[326] =  8'b01000010;
        font_memory[327] =  8'b00000000;

        font_memory[328] =  8'b00111110;
        font_memory[329] =  8'b00001000;
        font_memory[330] =  8'b00001000;
        font_memory[331] =  8'b00001000;
        font_memory[332] =  8'b00001000;
        font_memory[333] =  8'b00001000;
        font_memory[334] =  8'b00111110;
        font_memory[335] =  8'b00000000;

        font_memory[336] =  8'b01111000;
        font_memory[337] =  8'b01000000;
        font_memory[338] =  8'b01000000;
        font_memory[339] =  8'b01000000;
        font_memory[340] =  8'b01000010;
        font_memory[341] =  8'b00100010;
        font_memory[342] =  8'b00011100;
        font_memory[343] =  8'b00000000;

        font_memory[344] =  8'b00100010;
        font_memory[345] =  8'b00010010;
        font_memory[346] =  8'b00001010;
        font_memory[347] =  8'b00011110;
        font_memory[348] =  8'b00100010;
        font_memory[349] =  8'b00100010;
        font_memory[350] =  8'b01000010;
        font_memory[351] =  8'b00000000;

        font_memory[352] =  8'b00000010;
        font_memory[353] =  8'b00000010;
        font_memory[354] =  8'b00000010;
        font_memory[355] =  8'b00000010;
        font_memory[356] =  8'b00000010;
        font_memory[357] =  8'b00000010;
        font_memory[358] =  8'b01111110;
        font_memory[359] =  8'b00000000;

        font_memory[360] =  8'b01000001;
        font_memory[361] =  8'b01100011;
        font_memory[362] =  8'b01100011;
        font_memory[363] =  8'b01010101;
        font_memory[364] =  8'b01010101;
        font_memory[365] =  8'b01001001;
        font_memory[366] =  8'b01001001;
        font_memory[367] =  8'b00000000;

        font_memory[368] =  8'b01000110;
        font_memory[369] =  8'b01000110;
        font_memory[370] =  8'b01001010;
        font_memory[371] =  8'b01001010;
        font_memory[372] =  8'b01010010;
        font_memory[373] =  8'b01010010;
        font_memory[374] =  8'b01100010;
        font_memory[375] =  8'b00000000;

        font_memory[376] =  8'b00111000;
        font_memory[377] =  8'b01000100;
        font_memory[378] =  8'b01000010;
        font_memory[379] =  8'b01000010;
        font_memory[380] =  8'b01000010;
        font_memory[381] =  8'b00100010;
        font_memory[382] =  8'b00011100;
        font_memory[383] =  8'b00000000;

        font_memory[384] =  8'b00111110;
        font_memory[385] =  8'b01000010;
        font_memory[386] =  8'b01000010;
        font_memory[387] =  8'b00100010;
        font_memory[388] =  8'b00011110;
        font_memory[389] =  8'b00000010;
        font_memory[390] =  8'b00000010;
        font_memory[391] =  8'b00000000;

        font_memory[392] =  8'b00111000;
        font_memory[393] =  8'b01000100;
        font_memory[394] =  8'b01000010;
        font_memory[395] =  8'b01000010;
        font_memory[396] =  8'b01000010;
        font_memory[397] =  8'b00101010;
        font_memory[398] =  8'b00011100;
        font_memory[399] =  8'b00100000;

        font_memory[400] =  8'b00111110;
        font_memory[401] =  8'b01000010;
        font_memory[402] =  8'b01000010;
        font_memory[403] =  8'b00100010;
        font_memory[404] =  8'b00111110;
        font_memory[405] =  8'b00100010;
        font_memory[406] =  8'b01000010;
        font_memory[407] =  8'b00000000;

        font_memory[408] =  8'b00011100;
        font_memory[409] =  8'b00100010;
        font_memory[410] =  8'b00000010;
        font_memory[411] =  8'b00111100;
        font_memory[412] =  8'b01000000;
        font_memory[413] =  8'b01000010;
        font_memory[414] =  8'b00111100;
        font_memory[415] =  8'b00000000;

        font_memory[416] =  8'b01111111;
        font_memory[417] =  8'b00001000;
        font_memory[418] =  8'b00001000;
        font_memory[419] =  8'b00001000;
        font_memory[420] =  8'b00001000;
        font_memory[421] =  8'b00001000;
        font_memory[422] =  8'b00001000;
        font_memory[423] =  8'b00000000;

        font_memory[424] =  8'b01000010;
        font_memory[425] =  8'b01000010;
        font_memory[426] =  8'b01000010;
        font_memory[427] =  8'b01000010;
        font_memory[428] =  8'b01000010;
        font_memory[429] =  8'b00100010;
        font_memory[430] =  8'b00011100;
        font_memory[431] =  8'b00000000;

        font_memory[432] =  8'b01000010;
        font_memory[433] =  8'b01000010;
        font_memory[434] =  8'b01000010;
        font_memory[435] =  8'b00100100;
        font_memory[436] =  8'b00100100;
        font_memory[437] =  8'b00011000;
        font_memory[438] =  8'b00011000;
        font_memory[439] =  8'b00000000;

        font_memory[440] =  8'b01001001;
        font_memory[441] =  8'b01001001;
        font_memory[442] =  8'b01001001;
        font_memory[443] =  8'b00101010;
        font_memory[444] =  8'b00110110;
        font_memory[445] =  8'b00010100;
        font_memory[446] =  8'b00010100;
        font_memory[447] =  8'b00000000;

        font_memory[448] =  8'b01000010;
        font_memory[449] =  8'b01000010;
        font_memory[450] =  8'b00100100;
        font_memory[451] =  8'b00011000;
        font_memory[452] =  8'b00100100;
        font_memory[453] =  8'b01000010;
        font_memory[454] =  8'b01000010;
        font_memory[455] =  8'b00000000;

        font_memory[456] =  8'b00100010;
        font_memory[457] =  8'b00100010;
        font_memory[458] =  8'b00010100;
        font_memory[459] =  8'b00001000;
        font_memory[460] =  8'b00001000;
        font_memory[461] =  8'b00001000;
        font_memory[462] =  8'b00001000;
        font_memory[463] =  8'b00000000;

        font_memory[464] =  8'b01111110;
        font_memory[465] =  8'b00100000;
        font_memory[466] =  8'b00010000;
        font_memory[467] =  8'b00001000;
        font_memory[468] =  8'b00000100;
        font_memory[469] =  8'b00000010;
        font_memory[470] =  8'b01111110;
        font_memory[471] =  8'b00000000;

        font_memory[472] =  8'b00111000;
        font_memory[473] =  8'b00001000;
        font_memory[474] =  8'b00001000;
        font_memory[475] =  8'b00001000;
        font_memory[476] =  8'b00001000;
        font_memory[477] =  8'b00001000;
        font_memory[478] =  8'b00001000;
        font_memory[479] =  8'b00111000;

        font_memory[480] =  8'b00000010;
        font_memory[481] =  8'b00000100;
        font_memory[482] =  8'b00000100;
        font_memory[483] =  8'b00001000;
        font_memory[484] =  8'b00010000;
        font_memory[485] =  8'b00010000;
        font_memory[486] =  8'b00100000;
        font_memory[487] =  8'b00000000;

        font_memory[488] =  8'b00011100;
        font_memory[489] =  8'b00010000;
        font_memory[490] =  8'b00010000;
        font_memory[491] =  8'b00010000;
        font_memory[492] =  8'b00010000;
        font_memory[493] =  8'b00010000;
        font_memory[494] =  8'b00010000;
        font_memory[495] =  8'b00011100;

        font_memory[496] =  8'b00001000;
        font_memory[497] =  8'b00010100;
        font_memory[498] =  8'b00100010;
        font_memory[499] =  8'b00000000;
        font_memory[500] =  8'b00000000;
        font_memory[501] =  8'b00000000;
        font_memory[502] =  8'b00000000;
        font_memory[503] =  8'b00000000;

        font_memory[504] =  8'b00000000;
        font_memory[505] =  8'b00000000;
        font_memory[506] =  8'b00000000;
        font_memory[507] =  8'b00000000;
        font_memory[508] =  8'b00000000;
        font_memory[509] =  8'b00000000;
        font_memory[510] =  8'b00000000;
        font_memory[511] =  8'b01111110;

        font_memory[512] =  8'b00000100;
        font_memory[513] =  8'b00001000;
        font_memory[514] =  8'b00000000;
        font_memory[515] =  8'b00000000;
        font_memory[516] =  8'b00000000;
        font_memory[517] =  8'b00000000;
        font_memory[518] =  8'b00000000;
        font_memory[519] =  8'b00000000;

        font_memory[520] =  8'b00000000;
        font_memory[521] =  8'b00000000;
        font_memory[522] =  8'b00111100;
        font_memory[523] =  8'b01000000;
        font_memory[524] =  8'b01111100;
        font_memory[525] =  8'b01000010;
        font_memory[526] =  8'b01111100;
        font_memory[527] =  8'b00000000;

        font_memory[528] =  8'b00000010;
        font_memory[529] =  8'b00000010;
        font_memory[530] =  8'b00111010;
        font_memory[531] =  8'b01000110;
        font_memory[532] =  8'b01000010;
        font_memory[533] =  8'b01000010;
        font_memory[534] =  8'b00111110;
        font_memory[535] =  8'b00000000;

        font_memory[536] =  8'b00000000;
        font_memory[537] =  8'b00000000;
        font_memory[538] =  8'b00111000;
        font_memory[539] =  8'b01000100;
        font_memory[540] =  8'b00000010;
        font_memory[541] =  8'b00000010;
        font_memory[542] =  8'b00111100;
        font_memory[543] =  8'b00000000;

        font_memory[544] =  8'b01000000;
        font_memory[545] =  8'b01000000;
        font_memory[546] =  8'b01111100;
        font_memory[547] =  8'b01000010;
        font_memory[548] =  8'b01000010;
        font_memory[549] =  8'b01100010;
        font_memory[550] =  8'b01011100;
        font_memory[551] =  8'b00000000;

        font_memory[552] =  8'b00000000;
        font_memory[553] =  8'b00000000;
        font_memory[554] =  8'b00111100;
        font_memory[555] =  8'b01000010;
        font_memory[556] =  8'b01111110;
        font_memory[557] =  8'b00000010;
        font_memory[558] =  8'b00111100;
        font_memory[559] =  8'b00000000;

        font_memory[560] =  8'b00110000;
        font_memory[561] =  8'b00001000;
        font_memory[562] =  8'b00111100;
        font_memory[563] =  8'b00001000;
        font_memory[564] =  8'b00001000;
        font_memory[565] =  8'b00001000;
        font_memory[566] =  8'b00001000;
        font_memory[567] =  8'b00000000;

        font_memory[568] =  8'b00000000;
        font_memory[569] =  8'b00000000;
        font_memory[570] =  8'b01011100;
        font_memory[571] =  8'b00100010;
        font_memory[572] =  8'b00011100;
        font_memory[573] =  8'b00110000;
        font_memory[574] =  8'b01000010;
        font_memory[575] =  8'b00111100;

        font_memory[576] =  8'b00000010;
        font_memory[577] =  8'b00000010;
        font_memory[578] =  8'b00111010;
        font_memory[579] =  8'b01000110;
        font_memory[580] =  8'b01000010;
        font_memory[581] =  8'b01000010;
        font_memory[582] =  8'b01000010;
        font_memory[583] =  8'b00000000;

        font_memory[584] =  8'b00001000;
        font_memory[585] =  8'b00000000;
        font_memory[586] =  8'b00001000;
        font_memory[587] =  8'b00001000;
        font_memory[588] =  8'b00001000;
        font_memory[589] =  8'b00001000;
        font_memory[590] =  8'b00001000;
        font_memory[591] =  8'b00000000;

        font_memory[592] =  8'b00010000;
        font_memory[593] =  8'b00000000;
        font_memory[594] =  8'b00010000;
        font_memory[595] =  8'b00010000;
        font_memory[596] =  8'b00010000;
        font_memory[597] =  8'b00010000;
        font_memory[598] =  8'b00001000;
        font_memory[599] =  8'b00000110;

        font_memory[600] =  8'b00000010;
        font_memory[601] =  8'b00000010;
        font_memory[602] =  8'b00010010;
        font_memory[603] =  8'b00001010;
        font_memory[604] =  8'b00001110;
        font_memory[605] =  8'b00010010;
        font_memory[606] =  8'b01100010;
        font_memory[607] =  8'b00000000;

        font_memory[608] =  8'b00001000;
        font_memory[609] =  8'b00001000;
        font_memory[610] =  8'b00001000;
        font_memory[611] =  8'b00001000;
        font_memory[612] =  8'b00001000;
        font_memory[613] =  8'b00001000;
        font_memory[614] =  8'b00001000;
        font_memory[615] =  8'b00000000;

        font_memory[616] =  8'b00000000;
        font_memory[617] =  8'b00000000;
        font_memory[618] =  8'b00100101;
        font_memory[619] =  8'b01011011;
        font_memory[620] =  8'b01001001;
        font_memory[621] =  8'b01001001;
        font_memory[622] =  8'b01001001;
        font_memory[623] =  8'b00000000;

        font_memory[624] =  8'b00000000;
        font_memory[625] =  8'b00000000;
        font_memory[626] =  8'b00111010;
        font_memory[627] =  8'b01000110;
        font_memory[628] =  8'b01000010;
        font_memory[629] =  8'b01000010;
        font_memory[630] =  8'b01000010;
        font_memory[631] =  8'b00000000;

        font_memory[632] =  8'b00000000;
        font_memory[633] =  8'b00000000;
        font_memory[634] =  8'b00111000;
        font_memory[635] =  8'b01000100;
        font_memory[636] =  8'b01000010;
        font_memory[637] =  8'b00100010;
        font_memory[638] =  8'b00011100;
        font_memory[639] =  8'b00000000;

        font_memory[640] =  8'b00000000;
        font_memory[641] =  8'b00000000;
        font_memory[642] =  8'b00111010;
        font_memory[643] =  8'b01000110;
        font_memory[644] =  8'b01000010;
        font_memory[645] =  8'b00111110;
        font_memory[646] =  8'b00000010;
        font_memory[647] =  8'b00000010;

        font_memory[648] =  8'b00000000;
        font_memory[649] =  8'b00000000;
        font_memory[650] =  8'b01111100;
        font_memory[651] =  8'b01000010;
        font_memory[652] =  8'b01100010;
        font_memory[653] =  8'b01011100;
        font_memory[654] =  8'b01000000;
        font_memory[655] =  8'b01000000;

        font_memory[656] =  8'b00000000;
        font_memory[657] =  8'b00000000;
        font_memory[658] =  8'b00110100;
        font_memory[659] =  8'b00001100;
        font_memory[660] =  8'b00000100;
        font_memory[661] =  8'b00000100;
        font_memory[662] =  8'b00000100;
        font_memory[663] =  8'b00000000;

        font_memory[664] =  8'b00000000;
        font_memory[665] =  8'b00000000;
        font_memory[666] =  8'b00111100;
        font_memory[667] =  8'b00000010;
        font_memory[668] =  8'b00111100;
        font_memory[669] =  8'b01000000;
        font_memory[670] =  8'b00111110;
        font_memory[671] =  8'b00000000;

        font_memory[672] =  8'b00001000;
        font_memory[673] =  8'b00001000;
        font_memory[674] =  8'b00111100;
        font_memory[675] =  8'b00001000;
        font_memory[676] =  8'b00001000;
        font_memory[677] =  8'b00001000;
        font_memory[678] =  8'b00110000;
        font_memory[679] =  8'b00000000;

        font_memory[680] =  8'b00000000;
        font_memory[681] =  8'b00000000;
        font_memory[682] =  8'b01000010;
        font_memory[683] =  8'b01000010;
        font_memory[684] =  8'b01000010;
        font_memory[685] =  8'b01100010;
        font_memory[686] =  8'b01011100;
        font_memory[687] =  8'b00000000;

        font_memory[688] =  8'b00000000;
        font_memory[689] =  8'b00000000;
        font_memory[690] =  8'b01000010;
        font_memory[691] =  8'b01000010;
        font_memory[692] =  8'b00100100;
        font_memory[693] =  8'b00100100;
        font_memory[694] =  8'b00011000;
        font_memory[695] =  8'b00000000;

        font_memory[696] =  8'b00000000;
        font_memory[697] =  8'b00000000;
        font_memory[698] =  8'b01001001;
        font_memory[699] =  8'b01001001;
        font_memory[700] =  8'b00101010;
        font_memory[701] =  8'b00110110;
        font_memory[702] =  8'b00010100;
        font_memory[703] =  8'b00000000;

        font_memory[704] =  8'b00000000;
        font_memory[705] =  8'b00000000;
        font_memory[706] =  8'b01000110;
        font_memory[707] =  8'b00101000;
        font_memory[708] =  8'b00011000;
        font_memory[709] =  8'b00010100;
        font_memory[710] =  8'b01100010;
        font_memory[711] =  8'b00000000;

        font_memory[712] =  8'b00000000;
        font_memory[713] =  8'b00000000;
        font_memory[714] =  8'b01000010;
        font_memory[715] =  8'b00100100;
        font_memory[716] =  8'b00100100;
        font_memory[717] =  8'b00011000;
        font_memory[718] =  8'b00001000;
        font_memory[719] =  8'b00000110;

        font_memory[720] =  8'b00000000;
        font_memory[721] =  8'b00000000;
        font_memory[722] =  8'b01111110;
        font_memory[723] =  8'b00100000;
        font_memory[724] =  8'b00011000;
        font_memory[725] =  8'b00000100;
        font_memory[726] =  8'b01111110;
        font_memory[727] =  8'b00000000;

        font_memory[728] =  8'b00110000;
        font_memory[729] =  8'b00001000;
        font_memory[730] =  8'b00001000;
        font_memory[731] =  8'b00001100;
        font_memory[732] =  8'b00001100;
        font_memory[733] =  8'b00001000;
        font_memory[734] =  8'b00001000;
        font_memory[735] =  8'b00110000;

        font_memory[736] =  8'b00001000;
        font_memory[737] =  8'b00001000;
        font_memory[738] =  8'b00001000;
        font_memory[739] =  8'b00001000;
        font_memory[740] =  8'b00001000;
        font_memory[741] =  8'b00001000;
        font_memory[742] =  8'b00001000;
        font_memory[743] =  8'b00001000;

        font_memory[744] =  8'b00001100;
        font_memory[745] =  8'b00010000;
        font_memory[746] =  8'b00010000;
        font_memory[747] =  8'b00110000;
        font_memory[748] =  8'b00110000;
        font_memory[749] =  8'b00010000;
        font_memory[750] =  8'b00010000;
        font_memory[751] =  8'b00001100;

        font_memory[752] =  8'b00000000;
        font_memory[753] =  8'b00000000;
        font_memory[754] =  8'b00000110;
        font_memory[755] =  8'b01001001;
        font_memory[756] =  8'b00110000;
        font_memory[757] =  8'b00000000;
        font_memory[758] =  8'b00000000;
        font_memory[759] =  8'b00000000;

        font_memory[760] =  8'b01111111;
        font_memory[761] =  8'b01000001;
        font_memory[762] =  8'b01110011;
        font_memory[763] =  8'b01001101;
        font_memory[764] =  8'b01001001;
        font_memory[765] =  8'b01010111;
        font_memory[766] =  8'b01100001;
        font_memory[767] =  8'b01111111;

    end

    always @(*) begin
        pixels = font_memory[(char_code - 8'd32) * 8 + row];
    end

endmodule
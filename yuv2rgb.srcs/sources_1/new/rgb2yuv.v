`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/26 09:43:34
// Design Name: 
// Module Name: rgb2yuv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rgb2yuv(i_data,o_data
    );
    
    input [31:0]i_data;
    output [31:0]o_data;
    
    wire [9:0]i_r;
    wire [9:0]i_g;
    wire [9:0]i_b;
    wire [9:0] o_y;
    wire  [9:0]o_u;
    wire  [9:0]o_v;
    
assign  i_r = i_data[29:20];
assign  i_g = i_data[19:10];
assign  i_b = i_data[9:0];

assign o_y = 0.299*i_r  + 0.587*i_g  + 0.114*i_b;
assign o_u = -0.1687*i_r  - 0.3313*i_g  + 0.5*i_b + 128;
assign o_v = 0.5*i_r  - 0.4187*i_g  - 0.0813*i_b +128;
    
   
   
   
   
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 07:15:22 PM
// Design Name: 
// Module Name: Mux4Bit2To1
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


module Mux4Bit2To1(out, inA, inB, sel);

    output reg [3:0] out;
    
    input [3:0] inA;
    input [3:0] inB;
    input sel;

    always @(sel, inA, inB)
    begin
        if (sel == 1)
            out <= inB;
        else 
            out <= inA;     
    end
    
endmodule

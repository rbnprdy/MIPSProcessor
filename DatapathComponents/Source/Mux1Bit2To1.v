`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 03:36:51 PM
// Design Name: 
// Module Name: Mux1Bit2To1
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


module Mux1Bit2To1(out, inA, inB, sel);
    output reg out;
    
    input inA;
    input inB;
    input sel;

    always @(sel, inA, inB)
    begin
        if (sel == 1)
            out <= inB;
        else 
            out <= inA;     
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2017 11:10:47 PM
// Design Name: 
// Module Name: Mux32Bit4To1
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


module Mux32Bit4To1(out, inA, inB, inC, inD, sel);

    input [31:0] inA, inB, inC, inD;
    input [1:0] sel;
    
    output reg [31:0] out;
    
    always@(sel, inA, inB, inC, inD) begin
        if (sel == 2'd0)
            out <= inA;
        else if (sel == 2'd1)
            out <= inB;
        else if (sel == 2'd2)
            out <= inC;
        else if (sel == 2'd3)
            out <= inD;
        else
            out <= inA;
    end
endmodule

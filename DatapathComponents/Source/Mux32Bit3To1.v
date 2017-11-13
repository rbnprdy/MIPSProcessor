`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2017 10:02:30 PM
// Design Name: 
// Module Name: Mux32Bit3To1
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


module Mux32Bit3To1(out, inA, inB, inC, sel);
    
    output reg [31:0] out;
        
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0] sel;

    always @(inA, inB, inC, sel) begin
        if (sel == 2'b00)
            out <= inA;
        else if (sel == 2'b01) 
            out <= inB; 
        else
            out <= inC;    
    end
endmodule

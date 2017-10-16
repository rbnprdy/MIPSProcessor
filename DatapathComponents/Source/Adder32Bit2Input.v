`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 07:47:50 PM
// Design Name: 
// Module Name: Adder32Bit2Input
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


module Adder32Bit2Input(A, B, O);
    input [31:0] A, B;
        
    output reg [31:0] O;
    
    always @(*) begin
        O <= A + B;
    end
endmodule

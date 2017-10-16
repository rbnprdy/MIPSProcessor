`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 09:29:25 PM
// Design Name: 
// Module Name: OrGate1Bit2In
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


module OrGate1Bit2In(A, B, O);
    input A, B;
    output reg O;
    
    always @(*) begin
        O <= A || B;
    end
endmodule

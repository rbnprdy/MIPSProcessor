`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 04:39:48 PM
// Design Name: 
// Module Name: AndGate1Bit
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


module AndGate1Bit(A,B,O);

    input A, B;
    output reg O;
    
    always@(*) begin
        O <= A & B;
    end
    
endmodule

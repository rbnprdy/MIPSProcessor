`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 09:29:25 PM
// Design Name: 
// Module Name: NotGate1Bit1In
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


module NotGate1Bit1In(A, O);
    input A;
    output reg O;
    
    always @(*) begin
        O <= ~A;
    end
endmodule

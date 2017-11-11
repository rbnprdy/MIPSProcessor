`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2017 01:48:19 PM
// Design Name: 
// Module Name: HazardDetectionUnit
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


module HazardDetectionUnit(Rs_ID, Rt_ID, Rt_EX, MemRead_EX, PCWrite, IF_ID_Write, FlushControl);
    input [4:0] Rs_ID, Rt_ID, Rt_EX;
    input MemRead_EX;
    
    output reg PCWrite, IF_ID_Write, FlushControl;
    
    always@(*) begin
        if ((MemRead_EX == 1) && ((Rt_EX == Rs_ID) || (Rt_EX == Rt_ID))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        else begin
            PCWrite <= 1;
            IF_ID_Write <= 1;
            FlushControl <= 0;
        end
    end
endmodule

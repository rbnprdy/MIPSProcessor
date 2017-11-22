`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2017 02:09:17 PM
// Design Name: 
// Module Name: ClkDiv
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


module ClkDiv(Clk, Rst, ClkOut);
    input Clk, Rst;
    
    output reg ClkOut;
    
    parameter DivVal = 5;
    
    reg [2:0] DivCnt;
    reg ClkInt;
    
    always @(posedge Clk) begin
        if (Rst == 1) begin
            ClkOut <= 0;
            ClkInt <= 0;
            DivCnt <= 0;
        end    
        else begin
            if (DivCnt >= DivVal) begin
                ClkOut <= ~ClkInt;
                ClkInt <= ~ClkInt;
                DivCnt <= 0;
            end
            else begin 
                ClkOut <= ClkInt;
                ClkInt <= ClkInt;
                DivCnt <= DivCnt + 1;
            end
        end
    end
            
endmodule

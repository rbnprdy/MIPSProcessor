`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 03:21:48 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(Clk, PCAddIn, InstructionIn, PCAddOut, InstructionOut);
    
    input [31:0] PCAddIn, InstructionIn;
    input Clk;
    
    output reg [31:0] PCAddOut, InstructionOut;
    
    always @(negedge Clk) begin
        PCAddOut <= PCAddIn;
        InstructionOut <= InstructionIn;
    end


endmodule

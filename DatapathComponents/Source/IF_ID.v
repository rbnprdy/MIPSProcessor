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


module IF_ID(Clk, PCAddIn, InstructionIn, WriteEn, PCAddOut, InstructionOut);
    
    input [31:0] PCAddIn, InstructionIn;
    input Clk, WriteEn;
    
    reg [31:0] PCAddReg, InstructionReg;
    
    output reg [31:0] PCAddOut, InstructionOut;
    
    initial begin
        PCAddReg <= 32'd0;
        InstructionReg <= 32'd0;
    end
    
    always @(posedge Clk) begin
        if (WriteEn != 0) begin
            PCAddReg <= PCAddIn;
            InstructionReg <= InstructionIn;
        end
    end
    
    always @(negedge Clk) begin
        PCAddOut <= PCAddReg;
        InstructionOut <= InstructionReg;
    end


endmodule

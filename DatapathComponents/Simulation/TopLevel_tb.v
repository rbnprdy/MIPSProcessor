`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Ruben Purdy and Kray Althuas 
// Percent Effort: 50/50
// 
// Create Date: 10/16/2017 03:32:01 PM
// Design Name: 
// Module Name: TopLevel_tb
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


module TopLevel_tb();

    reg Clk, Rst;
    
    wire [31:0] WriteData, PCValue, HiReg, LoReg;
    
    TopLevel m0(
        .Clk(Clk),
        .Rst(Rst),
        .WriteData(WriteData),
        .PCValue(PCValue),
        .HiReg(HiReg),
        .LoReg(LoReg)
    );
    
   initial begin
        Clk <= 1'b0;
        forever #100 Clk <= ~Clk;
    end
    
    initial begin
        Rst <= 1;
        @(negedge Clk);
        @(negedge Clk);
        #50 Rst <= 0;
    end
endmodule

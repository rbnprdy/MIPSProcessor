`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2017 12:46:57 PM
// Design Name: 
// Module Name: TopLevelWithDisplay_tb
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


module TopLevelWithDisplay_tb();

    reg Clk, Rst, Rst_Clk;
        
    wire [6:0] out7; 
    wire [7:0] en_out;
    
    TopLevelWithDisplay m0(
        .Clk(Clk), 
        .Rst(Rst), 
        .Rst_Clk(Rst_Clk),
        .out7(out7), 
        .en_out(en_out)
    );
    
    initial begin
        Clk <= 1'b0;
        forever #100 Clk <= ~Clk;
    end
    
    initial begin
        Rst <= 1'b1;
        Rst_Clk <= 1'b1;
        @(negedge Clk);
        @(negedge Clk);
        Rst_Clk <= 1'b0;
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        Rst <= 1'b0;
    end
endmodule

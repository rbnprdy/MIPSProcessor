`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 07:37:29 PM
// Design Name: 
// Module Name: TopLevelWithDisplay
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


module TopLevelWithDisplay(Clk, Rst, Rst_Clk, out7, en_out);
    
    input Clk, Rst, Rst_Clk;
    output [6:0] out7;
    output [7:0] en_out;
    
    wire [31:0] v0, v1, PCValue;
    wire ClkTL, ClkDisplay;
    
    TopLevel tl(
        .Clk(ClkTL),
        .Rst(Rst),
        .PCValue(PCValue),
        .v0(v0),
        .v1(v1)
    );
    
    ClkDiv ClockTL(
        .Clk(Clk),
        .Rst(Rst_Clk),
        .ClkOut(ClkTL)
    );
    
    ClkDiv #(.DivVal(1000))ClockDisplay(
        .Clk(Clk),
        .Rst(Rst_Clk),
        .ClkOut(ClkDisplay)
    );
    
    Two4DigitDisplay display(
        .Clk(ClkDisplay),
        .NumberA(v0[7:0]),
        .NumberB(v1[7:0]),
        .out7(out7),
        .en_out(en_out)
    );
    
endmodule

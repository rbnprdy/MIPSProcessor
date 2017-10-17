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


module TopLevelWithDisplay(Clk, Rst, out7, en_out);
    
    input Clk, Rst;
    output [6:0] out7;
    output [7:0] en_out;
    
    wire [31:0] WriteData, PCValue;
    
    TopLevel tl(
        .Clk(Clk),
        .Rst(Rst),
        .WriteData(WriteData),
        .PCValue(PCValue)
    );
    
    Two4DigitDisplay display(
        .Clk(Clk),
        .NumberA(PCValue[7:0]),
        .NumberB(WriteData[7:0]),
        .out7(out7),
        .en_out(en_out)
    );
    
endmodule

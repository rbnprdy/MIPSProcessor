`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2017 12:54:44 PM
// Design Name: 
// Module Name: TopLevel_tb_vbsme
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


module TopLevel_tb_vbsme();
    reg Clk, Rst;
    
    wire [31:0] PCValue, v0, v1;
    
    TopLevel m0(
        .Clk(Clk),
        .Rst(Rst),
        .PCValue(PCValue),
        .v0(v0),
        .v1(v1)
    );
      
    initial begin
        Clk <= 1'b0;
        forever #100 Clk <= ~Clk;
    end
    
    initial begin
        Rst <= 1;
        
        @(negedge Clk);
        @(negedge Clk);
        Rst <= 0;
    end
endmodule

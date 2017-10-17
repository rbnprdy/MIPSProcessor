`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    
    TopLevel m0(
        .Clk(Clk),
        .Rst(Rst)
    );
    
   initial begin
        Clk <= 1'b0;
        forever #100 Clk <= ~Clk;
    end
    
    initial begin
        Rst <= 1;
        /*
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        */
        #150 Rst <= 0;
        #500;
    end
    
endmodule

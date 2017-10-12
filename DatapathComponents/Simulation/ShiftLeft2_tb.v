`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 12:57:46 PM
// Design Name: 
// Module Name: ShiftLeft2_tb
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


module ShiftLeft2_tb();
    
    reg [31:0] in;
    
    wire [31:0] out;
    
    ShiftLeft2 u0(
        .in(in),
        .out(out)
    );
    
    initial begin
        in <= 32'b0;
        #5;
        in <= 32'd1;
        #5;
        in <= 32'd2;
        #5;
        in <= 32'd4;
        #5;  
    end

endmodule

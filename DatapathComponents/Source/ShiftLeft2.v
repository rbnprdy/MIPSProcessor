`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2017 03:46:38 PM
// Design Name: 
// Module Name: HiLoRegisterFile
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


module ShiftLeft2(in, out);
    input [31:0] in;
    
    output reg [31:0] out;
    
    always @(in) begin
        out <= in << 2;
    end

endmodule
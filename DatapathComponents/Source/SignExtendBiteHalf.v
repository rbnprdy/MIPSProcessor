`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 04:17:59 PM
// Design Name: 
// Module Name: SignExtendBiteHalf
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


module SignExtendBiteHalf(in, out, sel);
    input [15:0] in;
    input sel;
    
    output reg [31:0] out;
    
    always@(*) begin
        // if sel is 1, sign extend byte
        if (sel == 1)
            out <= {{24{in[7]}}, in[7:0]};
        else // otherwise, sign extend half
            out <= { {16{in[15]}}, in[15:0]}; 
    end
endmodule

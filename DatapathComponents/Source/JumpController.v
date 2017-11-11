`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 06:31:04 PM
// Design Name: 
// Module Name: JumpController
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


module JumpController(Instruction, PCResult, JumpRegister, JumpAddress);

    input [31:0] Instruction, JumpRegister;
    input [3:0] PCResult;
    
    output reg [31:0] JumpAddress;
    
    always@(*) begin
        if (Instruction[31:26] == 6'b000000) // jr
            JumpAddress <= JumpRegister;
        else // j, jal
            JumpAddress <= {PCResult, Instruction[25:0], 2'b00};
    end
endmodule

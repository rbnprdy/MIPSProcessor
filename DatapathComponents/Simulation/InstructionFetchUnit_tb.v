`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 11:37:25 PM
// Design Name: 
// Module Name: InstructionFetchUnit_tb
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


module InstructionFetchUnit_tb();

    reg Reset, Clk, Branch; // Inputs to ProgramCounter
    reg [31:0] BranchAddress;
    
    wire [31:0] Instruction, PCAddResult; // Output of InstructionMemory
    
    InstructionFetchUnit m0(
        .Instruction(Instruction),
        .PCAddResult(PCAddResult),
        .Branch(Branch),
        .BranchAddress(BranchAddress),
        .Reset(Reset),
        .Clk(Clk)
    );
    
    initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
        
    end
    
endmodule

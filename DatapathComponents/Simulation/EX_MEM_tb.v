`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 07:48:46 PM
// Design Name: 
// Module Name: EX_MEM_tb
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


module EX_MEM_tb();
    
    reg [31:0] RHiIn, RLoIn, AddResultIn, ZeroIn, ALUResultIn, RD2In;
    reg [3:0] WriteAddressIn;
    reg Clk, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn;
    
    wire [31:0] RHiOut, RLoOut, AddResultOut, ZeroOut, ALUResultOut, RD2Out;
    wire [3:0] WriteAddressOut;
    wire RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut;
    
    integer passed;
    integer tests;
    
    EX_MEM(
        .Clk,
        .RegWriteIn,
        MoveNotZeroIn,
        DontMoveIn,
        HiOrLoIn,
        MemToRegIn,
        HiLoToRegIn,
        MemWriteIn,
        BranchIn,
        MemReadIn,
        RHiIn,
        RLoIn,
        AddResultIn,
        ZeroIn,
        ALUResultIn,
        RD2In,
        WriteAddressIn,
        RegWriteOut,
        MoveNotZeroOut,
        DontMoveOut,
        HiOrLoOut,
        MemToRegOut,
        HiLoToRegOut,
        MemWriteOut,
        BranchOut,
        MemReadOut,
        RHiOut,
        RLoOut,
        AddResultOut,
        ZeroOut,
        ALUResultOut,
        RD2Out,
        WriteAddressOut
    );
    


endmodule

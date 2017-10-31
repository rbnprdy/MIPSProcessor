`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 03:21:48 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(Clk, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn, RHiIn, RLoIn, AddResultIn, ZeroIn, ALUResultIn, RD2In, WriteAddressIn, LbIn, LoadExtendedIn, RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut, RHiOut, RLoOut, AddResultOut, ZeroOut, ALUResultOut, RD2Out, WriteAddressOut, LbOut, LoadExtendedOut);
    input [31:0] RHiIn, RLoIn, AddResultIn, ALUResultIn, RD2In;
    input [4:0] WriteAddressIn;
    input Clk, ZeroIn, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn, LbIn, LoadExtendedIn;
    
    output reg [31:0] RHiOut, RLoOut, AddResultOut, ALUResultOut, RD2Out;
    output reg ZeroOut;
    output reg [4:0] WriteAddressOut;
    output reg RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut, LbOut, LoadExtendedOut;
    
    always @(negedge Clk) begin
        RHiOut <= RHiIn;
        RLoOut <= RLoIn;
        AddResultOut <= AddResultIn;
        ZeroOut <= ZeroIn;
        ALUResultOut <= ALUResultIn;
        RD2Out <= RD2In;
        WriteAddressOut <= WriteAddressIn;
        RegWriteOut <= RegWriteIn;
        MoveNotZeroOut <= MoveNotZeroIn;
        DontMoveOut <= DontMoveIn;
        HiOrLoOut <= HiOrLoIn;
        MemToRegOut <= MemToRegIn;
        HiLoToRegOut <= HiLoToRegIn;
        MemWriteOut <= MemWriteIn;
        BranchOut <= BranchIn;
        MemReadOut <= MemReadIn;
        LbOut <= LbIn;
        LoadExtendedOut <= LoadExtendedIn;
    end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 03:21:48 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    //inputs
    Clk,
    RegWriteIn,
    MoveNotZeroIn,
    DontMoveIn,
    HiOrLoIn,
    MemToRegIn,
    HiLoToRegIn,
    RHiIn,
    RLoIn,
    ZeroIn,
    ALUResultIn,
    WriteAddressIn,
    ReadDataIn,
    LbIn,
    LoadExtendedIn,
    // Extra input for forwarding
    MemReadIn,
    //outputs
    RegWriteOut,
    MoveNotZeroOut,
    DontMoveOut,
    HiOrLoOut,
    MemToRegOut,
    HiLoToRegOut,
    RHiOut,
    RLoOut,
    ZeroOut,
    ALUResultOut,
    WriteAddressOut,
    ReadDataOut,
    LbOut,
    LoadExtendedOut,
    // Extra output for forwarding
    MemReadOut
);
    
    
    input [31:0] RHiIn, RLoIn, ALUResultIn, ReadDataIn;
    input [4:0] WriteAddressIn;
    input Clk, ZeroIn, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, LbIn, LoadExtendedIn, MemReadIn;
    
    output reg [31:0] RHiOut, RLoOut, ALUResultOut, ReadDataOut;
    output reg [4:0] WriteAddressOut;
    output reg RegWriteOut, ZeroOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, LbOut, LoadExtendedOut, MemReadOut;
    
    always @(negedge Clk) begin
        RHiOut <= RHiIn;
        RLoOut <= RLoIn;
        ZeroOut <= ZeroIn;
        ALUResultOut <= ALUResultIn;
        ReadDataOut <= ReadDataIn;
        WriteAddressOut <= WriteAddressIn;
        RegWriteOut <= RegWriteIn;
        MoveNotZeroOut <= MoveNotZeroIn;
        DontMoveOut <= DontMoveIn;
        HiOrLoOut <= HiOrLoIn;
        MemToRegOut <= MemToRegIn;
        HiLoToRegOut <= HiLoToRegIn;
        LbOut <= LbIn;
        LoadExtendedOut <= LoadExtendedIn;
        MemReadOut <= MemReadIn;
    end

endmodule

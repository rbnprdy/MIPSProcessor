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


module MEM_WB(Clk, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, RHiIn, RLoIn, ZeroIn, ALUResultIn, WriteAddressIn, ReadDataIn, RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, RHiOut, RLoOut, ZeroOut, ALUResultOut, WriteAddressOut, ReadDataOut);
    input [31:0] RHiIn, RLoIn, ZeroIn, ALUResultIn, ReadDataIn;
    input [3:0] WriteAddressIn;
    input Clk, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn;
    
    output reg [31:0] RHiOut, RLoOut, ZeroOut, ALUResultOut, ReadDataOut;
    output reg [3:0] WriteAddressOut;
    output reg RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut;
    
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
    end

endmodule

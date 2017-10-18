`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 04:21:07 PM
// Design Name: 
// Module Name: InstructionDecode
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


module InstructionDecode(
        // Inputs
        Clk, 
        Instruction,
        WriteRegister,
        WriteData,
        RegWriteIn,
        Move,
        // Outputs
        ReadData1,
        ReadData2,
        Instruction_15_0_Extended,
        // Control Signals
        PCSrc, 
        RegWrite, 
        ALUSrc, 
        InstructionToALU,
        RegDst,
        HiWrite, 
        LoWrite,
        Madd, 
        Msub, 
        MemWrite, 
        MemRead, 
        Branch,
        MemToReg, 
        HiOrLo, 
        HiToReg, 
        DontMove, 
        MoveOnNotZero
);
    input Clk, RegWriteIn, Move;
    input [31:0] Instruction, WriteData;
    input [4:0] WriteRegister;
    
    output [31:0] ReadData1, ReadData2, Instruction_15_0_Extended;
    output PCSrc, RegWrite, ALUSrc, RegDst, HiWrite, LoWrite, Madd, Msub, MemWrite, MemRead, Branch, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero;
    output [31:0] InstructionToALU;
    
    wire [15:0] Instruction_15_0;
    wire AndOut;
    
    AndGate1Bit RegWriteAnd(
        .A(RegWriteIn),
        .B(Move),
        .O(AndOut)
    );
    
    RegisterFile RegFile(
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(WriteRegister),
        .WriteData(WriteData),
        .RegWrite(AndOut),
        .Clk(Clk),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    SignExtension SignExtend(
        .in(Instruction[15:0]),
        .opcode(Instruction[31:26]),
        .out(Instruction_15_0_Extended)
    );
    
    Controller C(
        .Instruction(Instruction), 
        .PCSrc(PCSrc), 
        .RegWrite(RegWrite), 
        .ALUSrc(ALUSrc), 
        .InstructionToALU(InstructionToALU),
        .RegDst(RegDst),
        .HiWrite(HiWrite), 
        .LoWrite(LoWrite),
        .Madd(Madd), 
        .Msub(Msub), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .Branch(Branch),
        .MemToReg(MemToReg), 
        .HiOrLo(HiOrLo), 
        .HiToReg(HiToReg), 
        .DontMove(DontMove), 
        .MoveOnNotZero(MoveOnNotZero)
    );
      
endmodule

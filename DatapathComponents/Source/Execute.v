`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 06:55:09 PM
// Design Name: 
// Module Name: Execute
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


module Execute(
        // Inputs
        Clk,
        ReadData1,
        ReadData2,
        Instruction_10_6,
        Instruction_15_0_Extended,
        Instruction_20_16,
        Instruction_15_11,
        PCAddResult,
        // Controller Inputs
        ALUSrc, 
        InstructionToALU,
        RegDst,
        HiLoWrite, 
        Madd, 
        Msub, 
        // Outputs
        ReadDataHi,
        ReadDataLo,
        PCAddResultOut,
        ALUResult,
        Zero,
        WriteRegister
);
    input [31:0] ReadData1, ReadData2, PCAddResult, Instruction_15_0_Extended;
    input [3:0] Instruction_10_6, Instruction_20_16, Instruction_15_11;
    input Clk, ALUSrc, RegDst, HiLoWrite, Madd, Msub;
    input [31:0] InstructionToALU;
    
    output [31:0] ReadDataHi, ReadDataLo, PCAddResultOut, ALUResult;
    output [3:0] WriteRegister;
    output Zero;
    
    wire [31:0] ALUInputB;
    wire [4:0] ALUOp;
    wire [31:0] ALUHiResult;
    wire [31:0] Instruction_15_0_Shifted;
    
    Mux4Bit2To1 RegDstMux(
        .out(WriteRegister),
        .inA(Instruction_20_16),
        .inB(Instruction_15_11),
        .sel(RegDst)
    );
        
    Mux32Bit2To1 ALUSrcMux(
        .out(ALUInputB),
        .inA(ReadData2),
        .inB(Instruction_15_0_Extended),
        .sel(ALUSrc)
    );
    
    ALUController ALUC(
        .Instruction(InstructionToALU),
        .ALUOp(ALUOp)
    );
    
    ALU32Bit ALU(
        .ALUControl(ALUOp),
        .A(ReadData1),
        .B(ALUInputB),
        .ShiftAmount(Instruction_10_6),
        .ALUResult(ALUResult),
        .HiResult(ALUHiResult),
        .Zero(Zero)
    );
    
    ShiftLeft2 Sl2(
        .in(Instruction_15_0_Extended),
        .out(Instruction_15_0_Shifted)
    );
    
    Adder32Bit2Input AddPC(
        .A(PCAddResult),
        .B(Instruction_15_0_Shifted),
        .O(PCAddResultOut)
    );
    
    HiLoRegisterFile HiLoReg(
        .Clk(Clk),
        .WriteHiData(ALUHiResult),
        .WriteLoData(ALUResult),
        .ReadHi(ReadDataHi),
        .ReadLo(ReadDataLo),
        .Madd(Madd),
        .Msub(Msub),
        .WriteEn(HiLoWrite)
    );
        
endmodule

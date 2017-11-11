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
        Instruction,
        Instruction_15_0_Extended,
        PCAddResult,
        // Controller Inputs
        ALUSrc, 
        RegDst,
        HiWrite,
        LoWrite, 
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
    input [31:0] ReadData1, ReadData2, Instruction, Instruction_15_0_Extended, PCAddResult;
    input Clk, ALUSrc, RegDst, HiWrite, LoWrite, Madd, Msub;
    
    output [31:0] ReadDataHi, ReadDataLo, PCAddResultOut, ALUResult;
    output [4:0] WriteRegister;
    output Zero;
    
    wire [31:0] ALUInputB;
    wire [4:0] ALUOp;
    wire [31:0] ALUHiResult;
    wire [31:0] Instruction_15_0_Shifted;
    
    Mux5Bit2To1 RegDstMux(
        .out(WriteRegister),
        .inA(Instruction[20:16]),
        .inB(Instruction[15:11]),
        .sel(RegDst)
    );
        
    Mux32Bit2To1 ALUSrcMux(
        .out(ALUInputB),
        .inA(ReadData2),
        .inB(Instruction_15_0_Extended),
        .sel(ALUSrc)
    );
    
    ALUController ALUC(
        .Instruction_31_16(Instruction[31:16]),
        .Instruction_10_0(Instruction[10:0]),
        .ALUOp(ALUOp)
    );
    
    ALU32Bit ALU(
        .ALUControl(ALUOp),
        .A(ReadData1),
        .B(ALUInputB),
        .ShiftAmount(Instruction[10:6]),
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
        .WriteEnHi(HiWrite),
        .WriteEnLo(LoWrite)
    );
        
endmodule

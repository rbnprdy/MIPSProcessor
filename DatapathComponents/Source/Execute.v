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
        // Controller Inputs
        ALUSrc, 
        RegDst,
        HiWrite,
        LoWrite, 
        Madd, 
        Msub, 
        // Forwarding Inputs
        ForwardA,
        ForwardB,
        ForwardC,
        ForwardData_Mem,
        ForwardData_Wb,
        // Outputs
        ReadDataHi,
        ReadDataLo,
        ALUResult,
        Zero,
        WriteRegister,
        WriteData,
        // Outputs for phase1
        HiReg,
        LoReg
);
    input [31:0] ReadData1, ReadData2, Instruction, Instruction_15_0_Extended, ForwardData_Mem, ForwardData_Wb;
    input [1:0] ForwardA, ForwardB;
    input Clk, ALUSrc, RegDst, HiWrite, LoWrite, Madd, Msub, ForwardC;
    
    output [31:0] ReadDataHi, ReadDataLo, ALUResult, WriteData, HiReg, LoReg;
    output [4:0] WriteRegister;
    output Zero;
    
    wire [31:0] ForwardBInput, ALUInputA, ALUInputB, ALUHiResult, Instruction_15_0_Shifted;
    wire [4:0] ALUOp; 
    
    Mux5Bit2To1 RegDstMux(
        .out(WriteRegister),
        .inA(Instruction[20:16]),
        .inB(Instruction[15:11]),
        .sel(RegDst)
    );
        
    Mux32Bit2To1 ALUSrcMux(
        .out(ForwardBInput),
        .inA(ReadData2),
        .inB(Instruction_15_0_Extended),
        .sel(ALUSrc)
    );
    
    Mux32Bit3To1 ForwardAMux(
        .out(ALUInputA),
        .inA(ReadData1),
        .inB(ForwardData_Wb),
        .inC(ForwardData_Mem),
        .sel(ForwardA)
    );
    
    Mux32Bit3To1 ForwardBMux(
        .out(ALUInputB),
        .inA(ForwardBInput),
        .inB(ForwardData_Wb),
        .inC(ForwardData_Mem),
        .sel(ForwardB)
    );
    
    ALUController ALUC(
        .Instruction_31_16(Instruction[31:16]),
        .Instruction_10_0(Instruction[10:0]),
        .ALUOp(ALUOp)
    );
    
    ALU32Bit ALU(
        .ALUControl(ALUOp),
        .A(ALUInputA),
        .B(ALUInputB),
        .ShiftAmount(Instruction[10:6]),
        .ALUResult(ALUResult),
        .HiResult(ALUHiResult),
        .Zero(Zero)
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
        .WriteEnLo(LoWrite),
        .HiRegOut(HiReg),
        .LoRegOut(LoReg)
    );
    
    Mux32Bit2To1 ForwardCMux(
        .out(WriteData),
        .inA(ReadData2),
        .inB(ForwardData_Wb),
        .sel(ForwardC)
    );
        
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 09:13:10 PM
// Design Name: 
// Module Name: WriteBack
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


module WriteBack(
        // Inputs
        MemoryReadData,
        ALUResult,
        Zero,
        ReadDataHi,
        ReadDataLo,
        // Control Signals
        MemToReg, 
        HiOrLo, 
        HiToReg, 
        DontMove, 
        MoveOnNotZero,
        // Outputs
        WriteData,
        Move
);
    input [31:0] MemoryReadData, ALUResult, ReadDataHi, ReadDataLo;
    input Zero, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero;
    
    output [31:0] WriteData;
    output Move;
    
    wire [31:0] MemToRegOut, HiOrLoOut;
    wire NotZeroOut, MoveOnZeroOut, MoveOnNotZeroOut;
    
    
    Mux32Bit2To1 MemToRegMux(
        .out(MemToRegOut),
        .inA(MemoryReadData),
        .inB(ALUResult),
        .sel(MemToReg)
    );
    
    Mux32Bit2To1 HiOrLoMux(
        .out(HiOrLoOut),
        .inA(ReadDataHi),
        .inB(ReadDataLo),
        .sel(HiOrLo)
    );
    
    Mux32Bit2To1 HiToRegMux(
        .out(WriteData),
        .inA(HiOrLoOut),
        .inB(MemToRegOut),
        .sel(HiToReg)
    );
    
    OrGate1Bit2In MoveOnZeroOr(
        .A(DontMove),
        .B(Zero),
        .O(MoveOnZeroOut)
    );
    
    NotGate1Bit1In NotZero(
        .A(Zero),
        .O(NotZeroOut)
    );
    
    OrGate1Bit2In MoveOnNotZeroOr(
        .A(DontMove),
        .B(NotZeroOut),
        .O(MoveOnNotZeroOut)
    );
    
    Mux32Bit2To1 MoveMux(
        .out(Move),
        .inA(MoveOnZeroOut),
        .inB(MoveOnNotZeroOut),
        .sel(MoveOnNotZero)
    );
    
endmodule

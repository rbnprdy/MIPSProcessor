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
        WriteAddressIn,
        MemoryReadData,
        ALUResult,
        Zero,
        ReadDataHi,
        ReadDataLo,
        Ra,
        // Control Signals
        MemToReg, 
        HiOrLo, 
        HiToReg, 
        DontMove, 
        MoveOnNotZero,
        Lb,
        LoadExtended,
        Jal,
        // Outputs
        WriteData,
        WriteAddressOut,
        Move
);
    input [31:0] MemoryReadData, ALUResult, ReadDataHi, ReadDataLo, Ra;
    input [4:0] WriteAddressIn;
    input Zero, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero, Lb, LoadExtended, Jal;
    
    output [31:0] WriteData;
    output [4:0] WriteAddressOut;
    output Move;
    
    wire [31:0] MemToRegOut, HiOrLoOut, HiToRegOut, SignExtendByteHalfOut, LoadExtendedOut;
    wire NotZeroOut, MoveOnZeroOut, MoveOnNotZeroOut;
    
    Mux5Bit2To1 WriteAddressMux(
        .out(WriteAddressOut),
        .inA(WriteAddressIn),
        .inB(5'd31),
        .sel(Jal)
    );
    
    Mux32Bit2To1 MemToRegMux(
        .out(MemToRegOut),
        .inA(MemoryReadData),
        .inB(ALUResult),
        .sel(MemToReg)
    );
    
    Mux32Bit2To1 HiOrLoMux(
        .out(HiOrLoOut),
        .inA(ReadDataLo),
        .inB(ReadDataHi),
        .sel(HiOrLo)
    );
    
    Mux32Bit2To1 HiToRegMux(
        .out(HiToRegOut),
        .inA(MemToRegOut),
        .inB(HiOrLoOut),
        .sel(HiToReg)
    );
    
    SignExtendBiteHalf SignExtendBH(
        .in(HiToRegOut[15:0]),
        .out(SignExtendByteHalfOut),
        .sel(Lb)
    );
    
    Mux32Bit2To1 LoadExtendedMux(
        .out(LoadExtendedOut),
        .inA(HiToRegOut),
        .inB(SignExtendByteHalfOut),
        .sel(LoadExtended)
    );
    
    Mux32Bit2To1 JalMux(
        .out(WriteData),
        .inA(LoadExtendedOut),
        .inB(Ra),
        .sel(Jal)
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
    
    Mux1Bit2To1 MoveMux(
        .out(Move),
        .inA(MoveOnZeroOut),
        .inB(MoveOnNotZeroOut),
        .sel(MoveOnNotZero)
    );
    
endmodule

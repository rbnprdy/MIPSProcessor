`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 09:03:26 PM
// Design Name: 
// Module Name: Memory
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


module Memory(
        Clk,
        Zero,
        MemoryAddress,
        MemoryWriteData,
        Hi, 
        Lo,
        // Forwarding Signals
        ForwardD,
        WriteDataD,
        // Control Signals
        MemWrite, 
        MemRead, 
        HiOrLo,
        HiToReg,
        // Outputs
        MemoryReadData,
        ForwardingOut
);
    input Clk, Zero, ForwardD, MemWrite, MemRead, HiOrLo, HiToReg;
    input [31:0] MemoryAddress, MemoryWriteData, Hi, Lo, WriteDataD;
    
    output [31:0] MemoryReadData, ForwardingOut;
    
    wire [31:0] ForwardDMuxOut;
    
    Mux32Bit2To1 ForwardDMux(
        .out(ForwardDMuxOut),
        .inA(MemoryWriteData),
        .inB(WriteDataD),
        .sel(ForwardD)
    );
    
    DataMemory Memory(
        .Address(MemoryAddress),
        .WriteData(ForwardDMuxOut),
        .Clk(Clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(MemoryReadData)
    );
    
    Mux32Bit3To1 HiLoForwardingMux(
        .out(ForwardingOut),
        .inA(MemoryAddress),
        .inB(Lo),
        .inC(Hi),
        .sel({HiOrLo, HiToReg})
    );
    
endmodule

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
        // Forwarding Signals
        ForwardD,
        WriteDataD,
        // Control Signals
        MemWrite, 
        MemRead, 
        Branch,
        // Outputs
        MemoryReadData,
        BranchOut
);
    input Clk, Zero, ForwardD, MemWrite, MemRead, Branch;
    input [31:0] MemoryAddress, MemoryWriteData, WriteDataD;
    
    output [31:0] MemoryReadData;
    output BranchOut;
    
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
    
    AndGate1Bit AndGateBranch(
        .A(Branch),
        .B(Zero),
        .O(BranchOut)
    );
    
endmodule

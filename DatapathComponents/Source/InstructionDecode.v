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
        PCResult,
        WriteRegister,
        WriteData,
        RegWriteIn,
        Move,
        // Hazard Detection Signal
        FlushControl,
        // Outputs
        ReadData1,
        ReadData2,
        Instruction_15_0_Extended,
        JumpAddress,
        // Control Signals 
        RegWrite, 
        ALUSrc,
        RegDst,
        HiWrite, 
        LoWrite,
        Madd, 
        Msub, 
        MemWrite, 
        MemRead, 
        //Branch,
        MemToReg, 
        HiOrLo, 
        HiToReg, 
        DontMove, 
        MoveOnNotZero,
        Jump,
        Lb,
        LoadExtended,
        // BranchOutput
        BranchOut,
        BranchAddress
);
    input Clk, RegWriteIn, Move, FlushControl;
    input [31:0] Instruction, PCResult, WriteData;
    input [4:0] WriteRegister;
    
    output [31:0] ReadData1, ReadData2, Instruction_15_0_Extended, JumpAddress, BranchAddress;
    output RegWrite, ALUSrc, RegDst, HiWrite, LoWrite, Madd, Msub, MemWrite, MemRead, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero, Jump, Lb, LoadExtended, BranchOut;
    
    wire [31:0] PCAddResult, WriteDataMuxOut, FlushControllerOut, ShiftLeftOut;
    wire [15:0] Instruction_15_0;
    wire [4:0] WriteRegisterMuxOut;
    wire AndOut, OrOut, JumpAndLink, ComparatorOut, Branch;
    
    PCAdder PCAdderJump(
        .PCResult(PCResult),
        .WriteEn(1'b1),
        .PCAddResult(PCAddResult)
    );
    
    Mux32Bit2To1 WriteDataMux(
        .out(WriteDataMuxOut),
        .inA(WriteData),
        .inB(PCAddResult),
        .sel(JumpAndLink)
    );
    
    Mux5Bit2To1 WriteRegisterMux(
        .out(WriteRegisterMuxOut),
        .inA(WriteRegister),
        .inB(5'd31),
        .sel(JumpAndLink)
    );
    
    AndGate1Bit RegWriteAnd(
        .A(RegWriteIn),
        .B(Move),
        .O(AndOut)
    );
    
    OrGate1Bit2In RegWriteOr(
        .A(JumpAndLink),
        .B(AndOut),
        .O(OrOut)
    );
    
    RegisterFile RegFile(
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(WriteRegisterMuxOut),
        .WriteData(WriteDataMuxOut),
        .RegWrite(OrOut),
        .Clk(Clk),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    JumpController JControl(
        .Instruction(Instruction),
        .PCResult(PCResult[31:28]),
        .JumpRegister(ReadData1),
        .JumpAddress(JumpAddress)
    );
    
    SignExtension SignExtend(
        .in(Instruction[15:0]),
        .opcode(Instruction[31:26]),
        .out(Instruction_15_0_Extended)
    );
    
    Mux32Bit2To1 FlushControllerMux(
        .out(FlushControllerOut),
        .inA(Instruction),
        .inB(32'd0),
        .sel(FlushControl)  
    );
    
    Controller C(
        .Instruction(FlushControllerOut),  
        .RegWrite(RegWrite), 
        .ALUSrc(ALUSrc), 
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
        .MoveOnNotZero(MoveOnNotZero),
        .Jump(Jump),
        .JumpAndLink(JumpAndLink),
        .Lb(Lb),
        .LoadExtended(LoadExtended)
    );
    
    BranchComparator Comparator(
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .OpCode(Instruction[31:26]),
        .Instruction_20_16(Instruction[20:16]),
        .Out(ComparatorOut)
    );
    
    AndGate1Bit AndGateBranch(
        .A(Branch),
        .B(ComparatorOut),
        .O(BranchOut)
    );
    
    ShiftLeft2 ShifterBranch(
        .in(Instruction_15_0_Extended),
        .out(ShiftLeftOut)
    );
    
    Adder32Bit2Input AdderBranch(
        .A(ShiftLeftOut),
        .B(PCResult),
        .O(BranchAddress)
    );
      
endmodule

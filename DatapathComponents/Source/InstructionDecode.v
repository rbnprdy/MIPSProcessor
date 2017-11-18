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
        Jal,
        Lb,
        LoadExtended,
        Branch,
        // BranchOutput
        BranchOut,
        BranchAddress,
        // Jump and Link Output
        Ra,
        // Forwarding
        ForwardE,
        ForwardF,
        ForwardG,
        ForwardData,
        Ra_Mem
);
    input Clk, RegWriteIn, Move, FlushControl;
    input [1:0] ForwardE, ForwardF, ForwardG;
    input [31:0] Instruction, PCResult, WriteData, ForwardData, Ra_Mem;
    input [4:0] WriteRegister;
    
    output [31:0] ReadData1, ReadData2, Instruction_15_0_Extended, JumpAddress, BranchAddress, Ra;
    output RegWrite, ALUSrc, RegDst, HiWrite, LoWrite, Madd, Msub, MemWrite, MemRead, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero, Jump, Jal, Lb, LoadExtended, Branch, BranchOut;
    
    wire [31:0] FlushControllerOut, ShiftLeftOut, ForwardEOut, ForwardFOut, JumpForwardingMuxOut;
    wire [15:0] Instruction_15_0;
    wire AndOut, ComparatorOut;
    
    PCAdder RaAdder(
        .PCResult(PCResult),
        .WriteEn(1'b1),
        .PCAddResult(Ra)
    );
    
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
    
    Mux32Bit4To1 JumpForwardingMux(
        .out(JumpForwardingMuxOut),
        .inA(ReadData1),
        .inB(Ra_Mem),
        .inC(ForwardData),
        .inD(WriteData),
        .sel(ForwardG)
    );
    
    JumpController JControl(
        .Instruction(Instruction),
        .PCResult(PCResult[31:28]),
        .JumpRegister(JumpForwardingMuxOut),
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
        .JumpAndLink(Jal),
        .Lb(Lb),
        .LoadExtended(LoadExtended)
    );
    
    Mux32Bit3To1 ForwardEMux(
        .out(ForwardEOut),
        .inA(ReadData1),
        .inB(ForwardData),
        .inC(WriteData),
        .sel(ForwardE) 
    );
    
    Mux32Bit3To1 ForwardFMux(
        .out(ForwardFOut),
        .inA(ReadData2),
        .inB(ForwardData),
        .inC(WriteData),
        .sel(ForwardF)
    );
    
    BranchComparator Comparator(
        .ReadData1(ForwardEOut),
        .ReadData2(ForwardFOut),
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 09:56:14 PM
// Design Name: 
// Module Name: TopLevel
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


module TopLevel(Clk, Rst);
    input Clk, Rst;
    
    // InstructionFetch Inputs
    wire Branch_IF, BranchAddress_IF;
    // Instruction Fetch Outputs
    wire [31:0] PCAddResult_IF, Instruction_IF;
    
    // IF_ID Outputs
    wire [31:0] PCAdd_IF_ID;
    
    // InstructionDecode Inputs
    wire RegWrite_In_ID, Move_ID;
    wire [31:0] Instruction_ID, WriteData_ID;
    wire [4:0] WriteRegister_ID;
    // InstructionDecode Outputs
    wire [31:0] ReadData1_ID, ReadData2_ID, Instruction_15_0_Extended_ID;
    wire PCSrc_ID, RegWrite_ID, ALUSrc_ID, RegDst_ID, HiLoWrite_ID, Madd_ID, Msub_ID, MemWrite_ID, MemRead_ID, Branch_ID, MemToReg_ID, HiOrLo_ID, HiToReg_ID, DontMove_ID, MoveOnNotZero_ID;
    wire [31:0] InstructionToALU_ID;
    
    // ID_EX Outputs
    wire RegWrite_EX, MoveOnNotZero_EX, DontMove_EX, HiOrLo_EX, MemToReg_EX, MemWrite_EX, MemRead_EX, HiToReg_EX, Branch_EX; 
    
    // Execute Inputs
    wire [31:0] ReadData1_EX, ReadData2_EX, PCAddResult_In_EX, Instruction_15_0_Extended_EX;
    wire [3:0] Instruction_10_6_EX, Instruction_20_16_EX, Instruction_15_11_EX;
    wire ALUSrc_EX, RegDst_EX, HiLoWrite_EX, Madd_EX, Msub_EX;
    wire [31:0] InstructionToALU_EX;
    // Execute Outputs
    wire [31:0] ReadDataHi_EX, ReadDataLo_EX, PCAddResult_Out_EX, ALUResult_EX;
    wire Zero_EX;
    wire [3:0] WriteRegister_EX;
    
    InstructionFetchUnit IF(
        .Instruction(Instruction_IF), 
        .PCAddResult(PCAddResult_IF),
        .Branch(Branch_IF),
        .BranchAddress(BranchAddress_IF),
        .Reset(Rst),
        .Clk(Clk)
    );
    
    IF_ID IF_ID_Reg(
        .Clk(Clk),
        .PCAddIn(PCAddResult_IF),
        .InstructionIn(Instruction_IF),
        .PCAddOut(PCAdd_IF_ID),
        .InstructionOut(Instruction_ID)
    );
    
    InstructionDecode ID(
        // Inputs
        .Clk(Clk),
        .Instruction(Instruction_ID),
        .WriteRegister(WriteRegister_ID),
        .WriteData(WriteData_ID),
        .RegWriteIn(RegWrite_In_ID),
        .Move(Move_ID),
        // Outputs
        .ReadData1(ReadData1_ID),
        .ReadData2(ReadData2_ID),
        .Instruction_15_0_Extended(Instruction_15_0_Extended_ID),
        // Control Signals
        .PCSrc(PCSrc_ID), 
        .RegWrite(RegWrite_ID), 
        .ALUSrc(ALUSrc_ID), 
        .InstructionToALU(InstructionToALU_ID),
        .RegDst(RegDst_ID),
        .HiLoWrite(HiLoWrite_ID), 
        .Madd(Madd_ID), 
        .Msub(Msub_ID), 
        .MemWrite(MemWrite_ID), 
        .MemRead(MemRead_ID), 
        .Branch(Branch_ID),
        .MemToReg(MemToReg_ID), 
        .HiOrLo(HiOrLo_ID), 
        .HiToReg(HiToReg_ID), 
        .DontMove(DontMove_ID), 
        .MoveOnNotZero(MoveOnNotZero_ID)
    );
    
    ID_EX ID_EX_Reg(
        .Clk(Clk),
        .PCAddIn(PCAdd_IF_ID),
        .RD1In(ReadData1_ID),
        .RD2In(ReadData2_ID),
        .SignExtendIn(Instruction_15_0_Extended_ID),
        .Instr106In(Instruction_ID[10:6]),
        .Instr2016In(Instruction_ID[20:16]),
        .Instr1511In(Instruction_ID[15:11]),
        .MsubIn(Msub_ID),
        .MaddIn(Madd_ID),
        .HiLoWriteIn(HiLoWrite_ID),
        .RegWriteIn(RegWrite_ID),
        .MoveNotZeroIn(MoveOnNotZero_ID),
        .DontMoveIn(DontMove_ID),
        .HiOrLoIn(HiOrLo_ID),
        .MemToRegIn(MemToReg_ID),
        .HiLoToRegIn(HiToReg_ID),
        .MemWriteIn(MemWrite_ID),
        .BranchIn(Branch_ID),
        .MemReadIn(MemRead_ID),
        .RegDestIn(RegDst_ID),
        .ALUSrcIn(ALUSrc_ID),
        .ALUOpIn(InstructionToALU_ID),
        .PCAddOut(PCAddResult_In_EX),
        .RD1Out(ReadData1_EX),
        .RD2Out(ReadData2_EX),
        .SignExtendOut(Instruction_15_0_Extended_EX),
        .Instr106Out(Instruction_10_6_EX),
        .Instr2016Out(Instruction_20_16_EX),
        .Instr1511Out(Instruction_15_11_EX),
        .MsubOut(Msub_EX),
        .MaddOut(Madd_EX),
        .HiLoWriteOut(HiLoWrite_EX),
        .RegWriteOut(RegWrite_EX),
        .MoveNotZeroOut(MoveOnNotZero_EX),
        .DontMoveOut(DontMove_EX),
        .HiOrLoOut(HiOrLo_EX),
        .MemToRegOut(MemToReg_EX),
        .HiLoToRegOut(HiToReg_EX),
        .MemWriteOut(MemWrite_EX),
        .BranchOut(Branch_EX),
        .MemReadOut(MemRead_EX),
        .RegDestOut(RegDst_EX),
        .ALUSrcOut(ALUSrc_EX),
        .ALUOpOut(InstructionToALU_EX)
    );
    
    Execute EX(
        // Inputs
        .Clk(Clk),
        .ReadData1(ReadData1_EX),
        .ReadData2(ReadData2_EX),
        .Instruction_10_6(Instruction_10_6_EX),
        .Instruction_15_0_Extended(Instruction_15_0_Extended_EX),
        .Instruction_20_16(Instruction_20_16_EX),
        .Instruction_15_11(Instruction_15_11_EX),
        .PCAddResult(PCAddResult_In_EX),
        // Controller Inputs
        .ALUSrc(ALUSrc_EX), 
        .InstructionToALU(InstructionToALU_EX),
        .RegDst(RegDst_EX),
        .HiLoWrite(HiLoWrite_EX), 
        .Madd(Madd_EX), 
        .Msub(Msub_EX), 
        // Outputs
        .ReadDataHi(ReadDataHi_EX),
        .ReadDataLo(ReadDataLo_EX),
        .PCAddResultOut(PCAddResult_Out_EX),
        .ALUResult(ALUResult_EX),
        .Zero(Zero_EX),
        .WriteRegister(WriteRegister_EX)
    );
    
    EX_MEM EX_MEM_Reg(
        .Clk(Clk),
        .RegWriteIn(RegWrite_EX),
        .MoveNotZeroIn(MoveOnNotZero_EX),
        .DontMoveIn(DontMove_EX),
        .HiOrLoIn(HiOrLo_EX),
        .MemToRegIn(MemToReg_EX),
        .HiLoToRegIn(HiToReg_EX),
        .MemWriteIn(MemWrite_EX),
        .BranchIn(Branch_EX),
        .MemReadIn(MemRead_EX),
        .RHiIn(ReadDataHi_EX),
        .RLoIn(ReadDataLo_EX),
        .AddResultIn(PCAddResult_Out_EX),
        .ZeroIn(Zero_EX),
        .ALUResultIn(ALUResult_EX),
        .RD2In(ReadData2_EX),
        .WriteAddressIn(WriteRegister_EX),
        // START FROM HERE
        .RegWriteOut(RegWrite_MEM),
        .MoveNotZeroOut(MoveOnNotZero_MEM),
        .DontMoveOut(DontMove_MEM),
        .HiOrLoOut(HiOrLo_MEM),
        .MemToRegOut(MemToReg_MEM),
        .HiLoToRegOut(HiLoToReg_MEM),
        .MemWriteOut(MemWrite_MEM),
        .BranchOut(Branch_MEM),
        .MemReadOut(MemRead_MEM),
        .RHiOut(ReadHi_MEM),
        .RLoOut(ReadLo_MEM),
        .AddResultOut(AddResult_MEM),
        .ZeroOut(Zero_MEM),
        .ALUResultOut(ALUResult_MEM),
        .RD2Out(ReadRegister2_MEM),
        .WriteAddressOut(WriteAddress_MEM)
    );
        
endmodule

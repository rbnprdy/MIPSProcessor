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


module TopLevel(Clk, Rst, WriteData, PCValue, HiData, LoData);
    input Clk, Rst;
    
    output [31:0] WriteData, PCValue, HiData, LoData;
    
    // InstructionFetch Inputs
    wire Branch_IF;
    // Instruction Fetch Outputs
    wire [31:0] Instruction_IF;
    wire [31:0] PCAddResult_IF;
    
    // IF_ID Outputs
    wire [31:0] PCAdd_IF_ID;
    
    // InstructionDecode Inputs
    wire RegWrite_In_ID, Move_ID;
    wire [31:0] Instruction_ID, JumpAddress_ID;
    wire [4:0] WriteRegister_ID;
    // InstructionDecode Outputs
    wire [31:0] ReadData1_ID, ReadData2_ID, Instruction_15_0_Extended_ID;
    wire RegWrite_ID, ALUSrc_ID, RegDst_ID, HiWrite_ID, LoWrite_ID, Madd_ID, Msub_ID, MemWrite_ID, MemRead_ID, Branch_ID, MemToReg_ID, HiOrLo_ID, HiToReg_ID, DontMove_ID, MoveOnNotZero_ID, Jump_ID, JumpAndLink_ID, Lb_ID, LoadExtended_ID;
    wire [31:0] InstructionToALU_ID;
    
    // ID_EX Outputs
    wire RegWrite_EX, MoveOnNotZero_EX, DontMove_EX, HiOrLo_EX, MemToReg_EX, MemWrite_EX, MemRead_EX, HiToReg_EX, Branch_EX, Lb_EX, LoadExtended_EX; 
    
    // Execute Inputs
    wire [31:0] ReadData1_EX, ReadData2_EX, PCAddResult_In_EX, Instruction_15_0_Extended_EX;
    wire [4:0] Instruction_10_6_EX, Instruction_20_16_EX, Instruction_15_11_EX;
    wire ALUSrc_EX, RegDst_EX, HiWrite_EX, LoWrite_EX, Madd_EX, Msub_EX;
    wire [31:0] InstructionToALU_EX;
    // Execute Outputs
    wire [31:0] PCAddResult_Out_EX, ALUResult_EX;
    wire Zero_EX;
    wire [4:0] WriteRegister_EX;
    
    //EX_MEM Outputs
    wire [31:0] ReadHi_MEM, ReadLo_MEM, AddResult_MEM, ALUResult_MEM, ReadRegister2_MEM;
    wire [4:0] WriteAddress_MEM;
    wire Zero_MEM, RegWrite_MEM, MoveOnNotZero_MEM, DontMove_MEM, HiOrLo_MEM, MemToReg_MEM, HiLoToReg_MEM, MemWrite_MEM, Branch_MEM, MemRead_MEM, Lb_MEM, LoadExtended_MEM;
    
    //MEM Outputs
    wire [31:0] ReadData_MEM;
    
    //MEM_WB Outputs
    wire [31:0] ReadHi_WB, ReadLo_WB, ALUResult_WB, ReadData_WB;
    wire [4:0] WriteAddress_WB;
    wire Zero_WB, RegWrite_WB, MoveOnNotZero_WB, HiOrLo_WB, DontMove_WB, MemToReg_WB, HiLoToReg_WB, Lb_WB, LoadExtended_WB;
    
    InstructionFetchUnit IF(
        .Instruction(Instruction_IF),
        .PCResult(PCValue), 
        .PCAddResult(PCAddResult_IF),
        .Branch(Branch_IF),
        .BranchAddress(AddResult_MEM),
        .Jump(Jump_ID),
        .JumpAddress(JumpAddress_ID),
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
        .PCResult(PCAdd_IF_ID),
        .WriteRegister(WriteRegister_ID),
        .WriteData(WriteData),
        .RegWriteIn(RegWrite_In_ID),
        .Move(Move_ID),
        // Outputs
        .ReadData1(ReadData1_ID),
        .ReadData2(ReadData2_ID),
        .Instruction_15_0_Extended(Instruction_15_0_Extended_ID),
        .JumpAddress(JumpAddress_ID),
        // Control Signals 
        .RegWrite(RegWrite_ID), 
        .ALUSrc(ALUSrc_ID), 
        .InstructionToALU(InstructionToALU_ID),
        .RegDst(RegDst_ID),
        .HiWrite(HiWrite_ID),
        .LoWrite(LoWrite_ID), 
        .Madd(Madd_ID), 
        .Msub(Msub_ID), 
        .MemWrite(MemWrite_ID), 
        .MemRead(MemRead_ID), 
        .Branch(Branch_ID),
        .MemToReg(MemToReg_ID), 
        .HiOrLo(HiOrLo_ID), 
        .HiToReg(HiToReg_ID), 
        .DontMove(DontMove_ID), 
        .MoveOnNotZero(MoveOnNotZero_ID),
        .Jump(Jump_ID),
        .Lb(Lb_ID),
        .LoadExtended(LoadExtended_ID)
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
        .HiWriteIn(HiWrite_ID),
        .LoWriteIn(LoWrite_ID),
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
        .LbIn(Lb_ID),
        .LoadExtendedIn(LoadExtended_ID),
        .PCAddOut(PCAddResult_In_EX),
        .RD1Out(ReadData1_EX),
        .RD2Out(ReadData2_EX),
        .SignExtendOut(Instruction_15_0_Extended_EX),
        .Instr106Out(Instruction_10_6_EX),
        .Instr2016Out(Instruction_20_16_EX),
        .Instr1511Out(Instruction_15_11_EX),
        .MsubOut(Msub_EX),
        .MaddOut(Madd_EX),
        .HiWriteOut(HiWrite_EX),
        .LoWriteOut(LoWrite_EX),
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
        .ALUOpOut(InstructionToALU_EX),
        .LbOut(Lb_EX),
        .LoadExtendedOut(LoadExtended_EX)
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
        .HiWrite(HiWrite_EX), 
        .LoWrite(LoWrite_EX),
        .Madd(Madd_EX), 
        .Msub(Msub_EX), 
        // Outputs
        .ReadDataHi(HiData),
        .ReadDataLo(LoData),
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
        .RHiIn(HiData),
        .RLoIn(LoData),
        .AddResultIn(PCAddResult_Out_EX),
        .ZeroIn(Zero_EX),
        .ALUResultIn(ALUResult_EX),
        .RD2In(ReadData2_EX),
        .WriteAddressIn(WriteRegister_EX),
        .LbIn(Lb_EX),
        .LoadExtendedIn(LoadExtended_EX),
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
        .WriteAddressOut(WriteAddress_MEM),
        .LbOut(Lb_MEM),
        .LoadExtendedOut(LoadExtended_MEM)
    );
    
    Memory MEM(
        .Clk(Clk),
        .Zero(Zero_MEM),
        .MemoryAddress(ALUResult_MEM),
        .MemoryWriteData(ReadRegister2_MEM),
        // Control Signals
        .MemWrite(MemWrite_MEM), 
        .MemRead(MemRead_MEM), 
        .Branch(Branch_MEM),
        // Outputs
        .MemoryReadData(ReadData_MEM),
        .BranchOut(Branch_IF)
    );
    
    MEM_WB MEM_WB_Reg(
        .Clk(Clk),
        .RegWriteIn(RegWrite_MEM),
        .MoveNotZeroIn(MoveOnNotZero_MEM),
        .DontMoveIn(DontMove_MEM),
        .HiOrLoIn(HiOrLo_MEM),
        .MemToRegIn(MemToReg_MEM),
        .HiLoToRegIn(HiLoToReg_MEM),
        .RHiIn(ReadHi_MEM),
        .RLoIn(ReadLo_MEM),
        .ZeroIn(Zero_MEM),
        .ALUResultIn(ALUResult_MEM),
        .WriteAddressIn(WriteAddress_MEM),
        .ReadDataIn(ReadData_MEM),
        .LbIn(Lb_MEM),
        .LoadExtendedIn(LoadExtended_MEM),
        .RegWriteOut(RegWrite_In_ID),
        .MoveNotZeroOut(MoveOnNotZero_WB),
        .DontMoveOut(DontMove_WB),
        .HiOrLoOut(HiOrLo_WB),
        .MemToRegOut(MemToReg_WB),
        .HiLoToRegOut(HiLoToReg_WB),
        .RHiOut(ReadHi_WB),
        .RLoOut(ReadLo_WB),
        .ZeroOut(Zero_WB),
        .ALUResultOut(ALUResult_WB),
        .WriteAddressOut(WriteRegister_ID),
        .ReadDataOut(ReadData_WB),
        .LbOut(Lb_WB),
        .LoadExtendedOut(LoadExtended_WB)
    );
    
    WriteBack WB(
        // Inputs
        .MemoryReadData(ReadData_WB),
        .ALUResult(ALUResult_WB),
        .Zero(Zero_WB),
        .ReadDataHi(ReadHi_WB),
        .ReadDataLo(ReadLo_WB),
        // Control Signals
        .MemToReg(MemToReg_WB), 
        .HiOrLo(HiOrLo_WB), 
        .HiToReg(HiLoToReg_WB), 
        .DontMove(DontMove_WB), 
        .MoveOnNotZero(MoveOnNotZero_WB),
        .Lb(Lb_WB),
        .LoadExtended(LoadExtended_WB),
        // Outputs
        .WriteData(WriteData),
        .Move(Move_ID)
    );
    
        
endmodule

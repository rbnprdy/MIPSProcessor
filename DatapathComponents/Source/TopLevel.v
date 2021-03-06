`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Ruben Purdy and Kray Althuas 
// 
// Percent Effort: 50/50
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


module TopLevel(Clk, Rst, PCValue, v0, v1);
    input Clk, Rst;
    
    output [31:0] PCValue, v0, v1;
    
    wire [31:0] WriteData, HiData, LoData;
    // InstructionFetch Inputs
    wire Branch_IF; 
    wire [31:0] BranchAddress_IF;
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
    wire [31:0] ReadData1_ID, ReadData2_ID, Instruction_15_0_Extended_ID, Ra_ID;
    wire RegWrite_ID, ALUSrc_ID, RegDst_ID, HiWrite_ID, LoWrite_ID, Madd_ID, Msub_ID, MemWrite_ID, MemRead_ID, MemToReg_ID, HiOrLo_ID, HiToReg_ID, DontMove_ID, MoveOnNotZero_ID, Jump_ID, JumpAndLink_ID, Lb_ID, LoadExtended_ID, Jal_ID;
    //wire [31:0] InstructionToALU_ID;
    
    // ID_EX Outputs
    wire RegWrite_EX, MoveOnNotZero_EX, DontMove_EX, HiOrLo_EX, MemToReg_EX, MemWrite_EX, MemRead_EX, HiToReg_EX, Branch_EX, Lb_EX, LoadExtended_EX, Jal_EX; 
    wire [31:0] Ra_EX;
    
    // Execute Inputs
    wire [31:0] ReadData1_EX, ReadData2_EX, PCAddResult_In_EX, Instruction_15_0_Extended_EX;
    wire ALUSrc_EX, RegDst_EX, HiWrite_EX, LoWrite_EX, Madd_EX, Msub_EX;
    wire [31:0] Instruction_EX;
    // Execute Outputs
    wire [31:0] PCAddResult_Out_EX, ALUResult_EX, MemWriteData_EX;
    wire Zero_EX;
    wire [4:0] WriteRegister_EX;
    
    //EX_MEM Outputs
    wire [31:0] ReadHi_MEM, ReadLo_MEM, AddResult_MEM, ALUResult_MEM, ReadData2_MEM, Ra_MEM;
    wire [4:0] WriteAddress_MEM;
    wire Zero_MEM, RegWrite_MEM, MoveOnNotZero_MEM, DontMove_MEM, HiOrLo_MEM, MemToReg_MEM, HiLoToReg_MEM, MemWrite_MEM, MemRead_MEM, Lb_MEM, LoadExtended_MEM, Jal_MEM;
    
    //MEM Outputs
    wire [31:0] ReadData_MEM, ForwardingOut_MEM;
    
    //MEM_WB Outputs
    wire [31:0] ReadHi_WB, ReadLo_WB, ALUResult_WB, ReadData_WB, Ra_WB;
    wire [4:0] WriteAddress_WB;
    wire Zero_WB, RegWrite_WB, MoveOnNotZero_WB, HiOrLo_WB, DontMove_WB, MemToReg_WB, HiLoToReg_WB, Lb_WB, LoadExtended_WB, MemRead_WB, Jal_WB;
    
    wire Branch_Forwarding;
    // Forwarding Outputs
    wire [1:0] ForwardA, ForwardB, ForwardE, ForwardF, ForwardG;
    wire ForwardC, ForwardD;
    
    wire Jump_Hazard;
    // Hazard Detection Outputs
    wire PCWrite, IF_ID_Write, FlushControl;
    
    InstructionFetchUnit IF(
        .Instruction(Instruction_IF),
        .PCResult(PCValue), 
        .PCWrite(PCWrite),
        .PCAddResult(PCAddResult_IF),
        .Branch(Branch_IF),
        .BranchAddress(BranchAddress_IF),
        .Jump(Jump_ID),
        .JumpAddress(JumpAddress_ID),
        .Reset(Rst),
        .Clk(Clk)
    );
    
    IF_ID IF_ID_Reg(
        .Clk(Clk),
        .PCAddIn(PCAddResult_IF),
        .InstructionIn(Instruction_IF),
        .WriteEn(IF_ID_Write),
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
        // Hazard Detection Signal
        .FlushControl(FlushControl),
        // Outputs
        .ReadData1(ReadData1_ID),
        .ReadData2(ReadData2_ID),
        .Instruction_15_0_Extended(Instruction_15_0_Extended_ID),
        .JumpAddress(JumpAddress_ID),
        // Control Signals 
        .RegWrite(RegWrite_ID), 
        .ALUSrc(ALUSrc_ID), 
        .RegDst(RegDst_ID),
        .HiWrite(HiWrite_ID),
        .LoWrite(LoWrite_ID), 
        .Madd(Madd_ID), 
        .Msub(Msub_ID), 
        .MemWrite(MemWrite_ID), 
        .MemRead(MemRead_ID), 
        .MemToReg(MemToReg_ID), 
        .HiOrLo(HiOrLo_ID), 
        .HiToReg(HiToReg_ID), 
        .DontMove(DontMove_ID), 
        .MoveOnNotZero(MoveOnNotZero_ID),
        .Jump(Jump_ID),
        .Jal(Jal_ID),
        .Lb(Lb_ID),
        .LoadExtended(LoadExtended_ID),
        .Branch(Branch_Forwarding),
        // Branch Outputs
        .BranchOut(Branch_IF),
        .BranchAddress(BranchAddress_IF),
        // Forwarding
        .ForwardE(ForwardE),
        .ForwardF(ForwardF),
        .ForwardG(ForwardG),
        .ForwardData(ForwardingOut_MEM),
        .Ra_Mem(Ra_MEM),
        .v0(v0),
        .v1(v1)
    );
    
    ID_EX ID_EX_Reg(
        .Clk(Clk),
        .RD1In(ReadData1_ID),
        .RD2In(ReadData2_ID),
        .InstructionIn(Instruction_ID),
        .SignExtendIn(Instruction_15_0_Extended_ID),
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
        .BranchIn(Branch_IF),
        .MemReadIn(MemRead_ID),
        .RegDestIn(RegDst_ID),
        .ALUSrcIn(ALUSrc_ID),
        .LbIn(Lb_ID),
        .LoadExtendedIn(LoadExtended_ID),
        .RD1Out(ReadData1_EX),
        .RD2Out(ReadData2_EX),
        .InstructionOut(Instruction_EX),
        .SignExtendOut(Instruction_15_0_Extended_EX),
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
        .LbOut(Lb_EX),
        .LoadExtendedOut(LoadExtended_EX),
        .JumpIn(Jump_ID),
        .JumpOut(Jump_Hazard),
        .JalIn(Jal_ID),
        .JalOut(Jal_EX),
        .RaIn(PCAdd_IF_ID),
        .RaOut(Ra_EX)
    );
    
    Execute EX(
        // Inputs
        .Clk(Clk),
        .ReadData1(ReadData1_EX),
        .ReadData2(ReadData2_EX),
        .Instruction(Instruction_EX),
        .Instruction_15_0_Extended(Instruction_15_0_Extended_EX),
        // Controller Inputs
        .ALUSrc(ALUSrc_EX), 
        .RegDst(RegDst_EX),
        .HiWrite(HiWrite_EX), 
        .LoWrite(LoWrite_EX),
        .Madd(Madd_EX), 
        .Msub(Msub_EX), 
        // Forwarding Inputs
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .ForwardC(ForwardC),
        .ForwardData_Mem(ForwardingOut_MEM),
        .ForwardData_Wb(WriteData),
        // Outputs
        .ReadDataHi(HiData),
        .ReadDataLo(LoData),
        .ALUResult(ALUResult_EX),
        .Zero(Zero_EX),
        .WriteRegister(WriteRegister_EX),
        .WriteData(MemWriteData_EX)
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
        .MemReadIn(MemRead_EX),
        .RHiIn(HiData),
        .RLoIn(LoData),
        .ZeroIn(Zero_EX),
        .ALUResultIn(ALUResult_EX),
        .RD2In(MemWriteData_EX),
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
        .MemReadOut(MemRead_MEM),
        .RHiOut(ReadHi_MEM),
        .RLoOut(ReadLo_MEM),
        .ZeroOut(Zero_MEM),
        .ALUResultOut(ALUResult_MEM),
        .RD2Out(ReadData2_MEM),
        .WriteAddressOut(WriteAddress_MEM),
        .LbOut(Lb_MEM),
        .LoadExtendedOut(LoadExtended_MEM),
        .JalIn(Jal_EX),
        .JalOut(Jal_MEM),
        .RaIn(Ra_EX),
        .RaOut(Ra_MEM)
    );
    
    Memory MEM(
        .Clk(Clk),
        .Zero(Zero_MEM),
        .MemoryAddress(ALUResult_MEM),
        .MemoryWriteData(ReadData2_MEM),
        .Hi(ReadHi_MEM),
        .Lo(ReadLo_MEM),
        // Forwarding Signals
        .ForwardD(ForwardD),  
        .WriteDataD(WriteData),
        // Control Signals
        .MemWrite(MemWrite_MEM), 
        .MemRead(MemRead_MEM),
        .HiOrLo(HiOrLo_MEM),
        .HiToReg(HiLoToReg_MEM), 
        // Outputs
        .MemoryReadData(ReadData_MEM),
        .ForwardingOut(ForwardingOut_MEM)
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
        .MemReadIn(MemRead_MEM),
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
        .WriteAddressOut(WriteAddress_WB),
        .ReadDataOut(ReadData_WB),
        .LbOut(Lb_WB),
        .LoadExtendedOut(LoadExtended_WB),
        .MemReadOut(MemRead_WB),
        .JalIn(Jal_MEM),
        .JalOut(Jal_WB),
        .RaIn(Ra_MEM),
        .RaOut(Ra_WB)
    );
    
    WriteBack WB(
        // Inputs
        .WriteAddressIn(WriteAddress_WB),
        .MemoryReadData(ReadData_WB),
        .ALUResult(ALUResult_WB),
        .Zero(Zero_WB),
        .ReadDataHi(ReadHi_WB),
        .ReadDataLo(ReadLo_WB),
        .Ra(Ra_WB),
        // Control Signals
        .MemToReg(MemToReg_WB), 
        .HiOrLo(HiOrLo_WB), 
        .HiToReg(HiLoToReg_WB), 
        .DontMove(DontMove_WB), 
        .MoveOnNotZero(MoveOnNotZero_WB),
        .Lb(Lb_WB),
        .LoadExtended(LoadExtended_WB),
        .Jal(Jal_WB),
        // Outputs
        .WriteData(WriteData),
        .WriteAddressOut(WriteRegister_ID),
        .Move(Move_ID)
    );
    
    ForwardingUnit FU(
        // Inputs
        .Rs_Id(Instruction_ID[25:21]),
        .Rt_Id(Instruction_ID[20:16]),
        .Rs_Ex(Instruction_EX[25:21]),
        .Rt_Ex(Instruction_EX[20:16]),
        .Rd_Mem(WriteAddress_MEM),
        .Rd_Wb(WriteRegister_ID),
        .ALUSrc(ALUSrc_EX),
        .Opcode_Id(Instruction_ID[31:26]),
        .Instruction_5_0_Id(Instruction_ID[5:0]),
        .MemWrite_Ex(MemWrite_EX),
        .RegWrite_Mem(RegWrite_MEM),
        .MemWrite_Mem(MemWrite_MEM),
        .Jal_Mem(Jal_MEM),
        .MemRead_Wb(MemRead_WB),
        .RegWrite_Wb(RegWrite_In_ID),
        .Jal_Wb(Jal_WB),
        // Outputs
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .ForwardC(ForwardC),
        .ForwardD(ForwardD),
        .ForwardE(ForwardE),
        .ForwardF(ForwardF),
        .ForwardG(ForwardG),
        .Branch(Branch_Forwarding)
    );
    
    HazardDetectionUnit HDU(
        // Inputs
        .Rs_ID(Instruction_ID[25:21]),
        .Rt_ID(Instruction_ID[20:16]),
        .Rt_EX(Instruction_EX[20:16]),
        .Instruction_31_26(Instruction_ID[31:26]),
        .Instruction_5_0(Instruction_ID[5:0]),
        .MemRead_EX(MemRead_EX),
        .PCWrite(PCWrite),
        .IF_ID_Write(IF_ID_Write),
        .FlushControl(FlushControl),
        .RegWrite_Ex(RegWrite_EX),
        .MemRead_Mem(MemRead_MEM),
        .Rd_Mem(WriteAddress_MEM),
        .Rd_Ex(WriteRegister_EX),
        .Branch_Ex(Branch_EX),
        .Jump_Ex(Jump_Hazard)
    );
                
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 03:21:48 PM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(Clk, PCAddIn, RD1In, RD2In, SignExtendIn, Instr106In, Instr2016In, Instr1511In, MsubIn, MaddIn, HiLoWriteIn, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn, RegDestIn, ALUSrcIn, ALUOpIn, PCAddOut, RD1Out, RD2Out, SignExtendOut, Instr106Out, Instr2016Out, Instr1511Out, MsubOut, MaddOut, HiLoWriteOut, RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut, RegDestOut, ALUSrcOut, ALUOpOut);
    input [31:0] PCAddIn, RD1In, RD2In, SignExtendIn, ALUOpIn;
    input [3:0] Instr106In, Instr2016In, Instr1511In;
    input MsubIn, MaddIn, HiLoWriteIn, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn, RegDestIn, ALUSrcIn, Clk;
    
    output reg [31:0] PCAddOut, RD1Out, RD2Out, SignExtendOut, ALUOpOut;
    output reg [3:0] Instr106Out, Instr2016Out, Instr1511Out;
    output reg MsubOut, MaddOut, HiLoWriteOut, RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut, RegDestOut, ALUSrcOut;

    always @(negedge Clk) begin
        PCAddOut <= PCAddIn;
        RD1Out <= RD1In;
        RD2Out <= RD2In;
        SignExtendOut <= SignExtendIn;
        ALUOpOut <= ALUOpIn;
        Instr106Out <= Instr106In;
        Instr2016Out <= Instr2016In;
        Instr1511Out <= Instr1511In;
        MsubOut <= MsubIn;
        MaddOut <= MaddIn;
        HiLoWriteOut <= HiLoWriteIn;
        RegWriteOut <= RegWriteIn;
        MoveNotZeroOut <= MoveNotZeroIn;
        DontMoveOut <= DontMoveIn;
        HiOrLoOut <= HiOrLoIn;
        MemToRegOut <= MemToRegIn;
        HiLoToRegOut <= HiLoToRegIn;
        MemWriteOut <= MemWriteIn;
        BranchOut <= BranchIn;
        MemReadOut <= MemReadIn;
        RegDestOut <= RegDestIn;
        ALUSrcOut <= ALUSrcIn;
    end

endmodule

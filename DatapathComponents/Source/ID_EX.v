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


module ID_EX(Clk, PCAddIn, RD1In, RD2In, InstructionIn, SignExtendIn, MsubIn, MaddIn, HiWriteIn, LoWriteIn, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn, RegDestIn, ALUSrcIn, LbIn, LoadExtendedIn, PCAddOut, RD1Out, RD2Out, InstructionOut, SignExtendOut, MsubOut, MaddOut, HiWriteOut, LoWriteOut, RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut, RegDestOut, ALUSrcOut, LbOut, LoadExtendedOut);
    input [31:0] PCAddIn, RD1In, RD2In, InstructionIn, SignExtendIn;
    input MsubIn, MaddIn, HiWriteIn, LoWriteIn, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn, RegDestIn, ALUSrcIn, LbIn, LoadExtendedIn, Clk;
    
    output reg [31:0] PCAddOut, RD1Out, RD2Out, InstructionOut, SignExtendOut;
    output reg MsubOut, MaddOut, HiWriteOut, LoWriteOut, RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut, RegDestOut, ALUSrcOut, LbOut, LoadExtendedOut;

    always @(negedge Clk) begin
        PCAddOut <= PCAddIn;
        RD1Out <= RD1In;
        RD2Out <= RD2In;
        InstructionOut <= InstructionIn;
        SignExtendOut <= SignExtendIn;
        MsubOut <= MsubIn;
        MaddOut <= MaddIn;
        HiWriteOut <= HiWriteIn;
        LoWriteOut <= LoWriteIn;
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
        LbOut <= LbIn;
        LoadExtendedOut <= LoadExtendedIn;
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 07:48:46 PM
// Design Name: 
// Module Name: ID_EX_tb
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


module ID_EX_tb();
    
    reg [31:0] PCAddIn, RD1In, RD2In, SignExtendIn, ALUOpIn;
    reg [3:0] Instr106In, Instr2016In, Instr1511In;
    reg MsubIn, MaddIn, HiLoWriteIn, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn, MemWriteIn, BranchIn, MemReadIn, RegDestIn, ALUSrcIn, Clk;

    wire [31:0] PCAddOut, RD1Out, RD2Out, SignExtendOut, ALUOpOut;
    wire [3:0] Instr106Out, Instr2016Out, Instr1511Out;
    wire MsubOut, MaddOut, HiLoWriteOut, RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut, MemWriteOut, BranchOut, MemReadOut, RegDestOut, ALUSrcOut;

    integer passed;
    integer tests;

    ID_EX u0(
        .Clk(Clk),
        .PCAddIn(PCAddIn),
        .RD1In(RD1In),
        .RD2In(RD2In),
        .SignExtendIn(SignExtendIn),
        .Instr106In(Instr106In),
        .Instr2016In(Instr2016In),
        .Instr1511In(Instr1511In),
        .MsubIn(MsubIn),
        .MaddIn(MaddIn),
        .HiLoWriteIn(HiLoWriteIn),
        .RegWriteIn(RegWriteIn),
        .MoveNotZeroIn(MoveNotZeroIn),
        .DontMoveIn(DontMoveIn),
        .HiOrLoIn(HiOrLoIn),
        .MemToRegIn(MemToRegIn),
        .HiLoToRegIn(HiLoToRegIn),
        .MemWriteIn(MemWriteIn),
        .BranchIn(BranchIn),
        .MemReadIn(MemReadIn),
        .RegDestIn(RegDestIn),
        .ALUSrcIn(ALUSrcIn),
        .ALUOpIn(ALUOpIn),
        .PCAddOut(PCAddOut),
        .RD1Out(RD1Out),
        .RD2Out(RD2Out),
        .SignExtendOut(SignExtendOut),
        .Instr106Out(Instr106Out),
        .Instr2016Out(Instr2016Out),
        .Instr1511Out(Instr1511Out),
        .MsubOut(MsubOut),
        .MaddOut(MaddOut),
        .HiLoWriteOut(HiLoWriteOut),
        .RegWriteOut(RegWriteOut),
        .MoveNotZeroOut(MoveNotZeroOut),
        .DontMoveOut(DontMoveOut),
        .HiOrLoOut(HiOrLoOut),
        .MemToRegOut(MemToRegOut),
        .HiLoToRegOut(HiLoToRegOut),
        .MemWriteOut(MemWriteOut),
        .BranchOut(BranchOut),
        .MemReadOut(MemReadOut),
        .RegDestOut(RegDestOut),
        .ALUSrcOut(ALUSrcOut),
        .ALUOpOut(ALUOpOut)
    );
        
    initial begin
       Clk <= 1'b0;
       forever #10 Clk <= ~Clk;
    end    
    
    initial begin
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        PCAddIn <= 32'b0;
        RD1In <= 32'b0;
        RD2In <= 32'b0;
        SignExtendIn <= 32'b0;
        Instr106In <= 4'b0;
        Instr2016In <= 4'b0;
        Instr1511In <= 4'b0;
        MsubIn <= 0;
        MaddIn <= 0;
        HiLoWriteIn <= 0;
        RegWriteIn <= 0;
        MoveNotZeroIn <= 0;
        DontMoveIn <= 0;
        HiOrLoIn <= 0;
        MemToRegIn <= 0;
        HiLoToRegIn <= 0;
        MemWriteIn <= 0;
        BranchIn <= 0;
        MemReadIn <= 0;
        RegDestIn <= 0;
        ALUSrcIn <= 0;
        ALUOpIn <= 32'b0;
        tests <= 0;
        passed <= 0;
        @(posedge Clk);
        //Testing Program Counter
        PCAddIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (PCAddOut == PCAddIn)
            passed <= passed + 1;
        else
            $display("Program Counter Test Failed, Expected: %d, Actual: %d", PCAddIn, PCAddOut);
        @(posedge Clk);
        //Testing RD1
        RD1In <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (RD1Out == RD1In)
            passed <= passed + 1;
        else
            $display("Read Destination 1 Test Failed, Expected: %d, Actual: %d", RD1In, RD1Out);
        @(posedge Clk);
        //Testing RD2
        @(posedge Clk);
        RD2In <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (RD2Out == RD2In)
            passed <= passed + 1;
        else
            $display("Read Destination 2 Test Failed, Expected: %d, Actual: %d", RD2In, RD2Out);
        @(posedge Clk);
        //Testing Sign Extend
        SignExtendIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (SignExtendOut == SignExtendIn)
            passed <= passed + 1;
        else
            $display("Sign Extend Test Failed, Expected: %d, Actual: %d", SignExtendIn, SignExtendOut);
        @(posedge Clk);
        //Testing ALU Operation
        ALUOpIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (ALUOpOut == ALUOpIn)
            passed <= passed + 1;
        else
            $display("ALU Operation Test Failed, Expected: %d, Actual: %d", ALUOpIn, ALUOpOut);
        @(posedge Clk);
        //Testing Instruction [10:6]
        Instr106In <= 4'b1111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (Instr106Out == Instr106In)
            passed <= passed + 1;
        else
            $display("Instruction [10:6] Test Failed, Expected: %d, Actual: %d", Instr106In, Instr106Out);
        @(posedge Clk);
        //Testing Instruction [20:16]
        Instr2016In <= 4'b1111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (Instr2016Out == Instr2016In)
            passed <= passed + 1;
        else
            $display("Instruction [20:16] Test Failed, Expected: %d, Actual: %d", Instr2016In, Instr2016Out);
        @(posedge Clk);
        //Testing Instruction [15:11]
        Instr1511In <= 4'b1111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (Instr1511Out == Instr1511In)
            passed <= passed + 1;
        else
            $display("Instruction [15:11] Test Failed, Expected: %d, Actual: %d", Instr1511In, Instr1511Out);
        @(posedge Clk);
        //Testing Msub
        MsubIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (MsubOut == MsubIn)
            passed <= passed + 1;
        else
            $display("Msub Test Failed, Expected: %d, Actual: %d", MsubIn, MsubOut);
        @(posedge Clk);
        //Testing Madd
        MaddIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (MaddOut == MaddIn)
            passed <= passed + 1;
        else
            $display("Madd Test Failed, Expected: %d, Actual: %d", MaddIn, MaddOut);        
        @(posedge Clk);
        //Testing Hi Lo Write Enable
        HiLoWriteIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (HiLoWriteOut == HiLoWriteIn)
            passed <= passed + 1;
        else
            $display("Hi/Lo Write Enable Test Failed, Expected: %d, Actual: %d", HiLoWriteIn, HiLoWriteOut);
        @(posedge Clk);
        //Testing Reg Write Enable
        RegWriteIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (RegWriteOut == RegWriteIn)
            passed <= passed + 1;
        else
            $display("RegWrite Test Failed, Expected: %d, Actual: %d", RegWriteIn, RegWriteOut);
        @(posedge Clk);
        //Testing Move on not zero
        MoveNotZeroIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (MoveNotZeroOut == MoveNotZeroIn)
            passed <= passed + 1;
        else
            $display("Move on not zero Test Failed, Expected: %d, Actual: %d", MoveNotZeroIn, MoveNotZeroOut);
        @(posedge Clk);
        //Testing Dont Move
        DontMoveIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (DontMoveOut == DontMoveIn)
            passed <= passed + 1;
        else
            $display("Dont move Test Failed, Expected: %d, Actual: %d", DontMoveIn, DontMoveOut);
        @(posedge Clk);
        //Testing Hi or Lo
        HiOrLoIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (HiOrLoOut == HiOrLoIn)
            passed <= passed + 1;
        else
            $display("Hi or Lo Test Failed, Expected: %d, Actual: %d", HiOrLoIn, HiOrLoOut);
        @(posedge Clk);
        //Testing MemToReg
        MemToRegIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (MemToRegOut == MemToRegIn)
            passed <= passed + 1;
        else
            $display("MemToReg Test Failed, Expected: %d, Actual: %d", MemToRegIn, MemToRegOut);
        @(posedge Clk);
        //Testing HiToLoReg
        HiLoToRegIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (HiLoToRegOut == HiLoToRegIn)
            passed <= passed + 1;
        else
            $display("HiLoToReg Test Failed, Expected: %d, Actual: %d", HiLoToRegIn, HiLoToRegOut);
        @(posedge Clk);
        //Testing MemWrite
        MemWriteIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (MemWriteOut == MemWriteIn)
            passed <= passed + 1;
        else
            $display("MemWrite Test Failed, Expected: %d, Actual: %d", MemWriteIn, MemWriteOut);
        @(posedge Clk);
        //Testing Branch
        BranchIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (BranchOut == BranchIn)
            passed <= passed + 1;
        else
            $display("Branch Test Failed, Expected: %d, Actual: %d", BranchIn, BranchOut);
        @(posedge Clk);
        //Testing MemRead
        MemReadIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (MemReadOut == MemReadIn)
            passed <= passed + 1;
        else
            $display("MemRead Test Failed, Expected: %d, Actual: %d", MemReadIn, MemReadOut);
        @(posedge Clk);
        //Testing RegDest
        RegDestIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (RegDestOut == RegDestIn)
            passed <= passed + 1;
        else
            $display("RegDest Test Failed, Expected: %d, Actual: %d", RegDestIn, RegDestOut);
        @(posedge Clk);
        //Testing ALUSrc
        ALUSrcIn <= 1;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (ALUSrcOut == ALUSrcIn)
            passed <= passed + 1;
        else
            $display("ALUSrc Test Failed, Expected: %d, Actual: %d", ALUSrcIn, ALUSrcOut);
        #10;
        if (tests == passed)
            $display("All tests passed");
            $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            
    end    


endmodule

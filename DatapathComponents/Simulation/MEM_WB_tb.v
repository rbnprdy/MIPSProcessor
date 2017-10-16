`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 07:48:46 PM
// Design Name: 
// Module Name: MEM_WB_tb
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


module MEM_WB_tb();

    reg [31:0] RHiIn, RLoIn, ZeroIn, ALUResultIn, ReadDataIn;
    reg [3:0] WriteAddressIn;
    reg Clk, RegWriteIn, MoveNotZeroIn, DontMoveIn, HiOrLoIn, MemToRegIn, HiLoToRegIn;
    
    wire [31:0] RHiOut, RLoOut, ZeroOut, ALUResultOut, ReadDataOut;
    wire [3:0] WriteAddressOut;
    wire RegWriteOut, MoveNotZeroOut, DontMoveOut, HiOrLoOut, MemToRegOut, HiLoToRegOut;
    
    integer passed;
    integer tests;
    
    MEM_WB u0(
        .Clk(Clk),
        .RegWriteIn(RegWriteIn),
        .MoveNotZeroIn(MoveNotZeroIn),
        .DontMoveIn(DontMoveIn),
        .HiOrLoIn(HiOrLoIn),
        .MemToRegIn(MemToRegIn),
        .HiLoToRegIn(HiLoToRegIn),
        .RHiIn(RHiIn),
        .RLoIn(RLoIn),
        .ZeroIn(ZeroIn),
        .ALUResultIn(ALUResultIn),
        .WriteAddressIn(WriteAddressIn),
        .ReadDataIn(ReadDataIn),
        .RegWriteOut(RegWriteOut),
        .MoveNotZeroOut(MoveNotZeroOut),
        .DontMoveOut(DontMoveOut),
        .HiOrLoOut(HiOrLoOut),
        .MemToRegOut(MemToRegOut),
        .HiLoToRegOut(HiLoToRegOut),
        .RHiOut(RHiOut),
        .RLoOut(RLoOut),
        .ZeroOut(ZeroOut),
        .ALUResultOut(ALUResultOut),
        .WriteAddressOut(WriteAddressOut),
        .ReadDataOut(ReadDataOut)
    );

    initial begin
       Clk <= 1'b0;
       forever #10 Clk <= ~Clk;
    end    
    
    initial begin
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        ReadDataIn <= 32'b0;
        RHiIn <= 32'b0;
        RLoIn <= 32'b0;
        ZeroIn <= 32'b0;
        ALUResultIn <= 32'b0;
        WriteAddressIn <= 4'b0;
        RegWriteIn <= 0;
        MoveNotZeroIn <= 0;
        DontMoveIn <= 0;
        HiOrLoIn <= 0;
        MemToRegIn <= 0;
        HiLoToRegIn <= 0;
        tests <= 0;
        passed <= 0;
        @(posedge Clk);
        //Testing Read Data 
        ReadDataIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (ReadDataOut == ReadDataIn)
            passed <= passed + 1;
        else
            $display("Read Data Test Failed, Expected: %d, Actual: %d", ReadDataIn, ReadDataOut);
        @(posedge Clk);
        //Testing RHi
        RHiIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (RHiOut == RHiIn)
            passed <= passed + 1;
        else
            $display("Read Hi Register Test Failed, Expected: %d, Actual: %d", RHiIn, RHiOut);
        @(posedge Clk);
        //Testing RLo
        @(posedge Clk);
        RLoIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (RLoOut == RLoIn)
            passed <= passed + 1;
        else
            $display("Read Lo Destination Test Failed, Expected: %d, Actual: %d", RLoIn, RLoOut);
        @(posedge Clk);
        //Testing Zero Flag
        ZeroIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (ZeroOut == ZeroIn)
            passed <= passed + 1;
        else
            $display("Zero Flag Test Failed, Expected: %d, Actual: %d", ZeroIn, ZeroOut);
        @(posedge Clk);
        //Testing ALU Result 
        ALUResultIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (ALUResultOut == ALUResultIn)
            passed <= passed + 1;
        else
            $display("ALU Result Test Failed, Expected: %d, Actual: %d", ALUResultIn, ALUResultOut);
        @(posedge Clk);
        //Testing WriteAddress
        WriteAddressIn <= 4'b1111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (WriteAddressOut == WriteAddressIn)
            passed <= passed + 1;
        else
            $display("Write Address Test Failed, Expected: %d, Actual: %d", WriteAddressIn, WriteAddressOut);
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
       #10;
       if (tests == passed)
           $display("All tests passed");
           $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
       end    

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 12:57:46 PM
// Design Name: 
// Module Name: HiLoRegisterFile_tb
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


module HiLoRegisterFile_tb();
    reg Clk, Madd, Msub, WriteEn;
    reg [31:0] WriteHiData;
    reg [31:0] WriteLoData;
    
    integer passed;
    integer tests;
    
    wire [31:0] ReadHi;
    wire [31:0] ReadLo;
    
    HiLoRegisterFile u0(
        .Clk(Clk),
        .WriteHiData(WriteHiData),
        .WriteLoData(WriteLoData),
        .ReadHi(ReadHi),
        .ReadLo(ReadLo),
        .Madd(Madd),
        .Msub(Msub),
        .WriteEn(WriteEn)
    );
    
    initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
    
        passed <= 0;
        tests <= 0;
    
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
           
        Madd <= 1'b0;
        Msub <= 1'b0;
        WriteEn <= 1'b0;
        WriteHiData <= 32'b0;
        WriteLoData <= 32'b0;
        #15;
        WriteHiData <= 32'b11111111000000001111111100000000;
        WriteLoData <= 32'b00000000111111110000000011111111;
        @(posedge Clk);
        Madd <= 1'b1;
        @(posedge Clk);
        Madd <= 1'b0;
        tests = tests + 2;
        @(posedge Clk);
        if (ReadHi == WriteHiData)
            passed = passed + 1;
        else
            $display("Madd test 1 failed, HiReg not written properly");
        if (ReadLo == WriteLoData)
            passed = passed + 1;
        else 
            $display("Madd test 1 failed, LoReg not written properly");
        @(posedge Clk)
        WriteHiData <= 32'b00000000111111110000000011111111;
        WriteLoData <= 32'b11111111000000001111111100000000;
        Madd <= 1'b1;
        @(posedge Clk);
        Madd <= 1'b0;
        tests = tests + 2;
        @(posedge Clk);
        if (ReadHi == 32'b11111111111111111111111111111111)
            passed = passed + 1;
        else
            $display("Madd test 2 failed, HiReg not written properly");
        if (ReadLo == 32'b11111111111111111111111111111111)
            passed = passed + 1;
        else 
            $display("Madd test 2 failed, LoReg not written properly");
        @(posedge Clk);
        WriteHiData <= 32'd0;
        WriteLoData <= 32'd32;
        WriteEn <= 1'b1;
        @(posedge Clk);
        @(posedge Clk);
        WriteEn <= 1'b0;
        @(posedge Clk);
        WriteHiData <= 32'b0;
        WriteLoData <= 32'd1024;
        Msub <= 1'b1;
        @(posedge Clk);
        Msub <= 1'b0;
        tests = tests + 2;
        @(posedge Clk);
        if (ReadHi == 32'b0)
            passed = passed + 1;
        else
            $display("Madd test 3 failed, HiReg not written properly");
        if (ReadLo == -32'd992)
            passed = passed + 1;
        else 
            $display("Msub test 3 failed, LoReg not written properly");
            
        @(posedge Clk);
        tests = tests + 1;
        WriteHiData <= 32'd31;
        WriteLoData <= -32'd32;
        WriteEn <= 1'b1;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadHi == 32'd31 && ReadLo == -32'd32)
            passed = passed + 1;
        else
            $display("Writing into hilo failed. Expected ReadHi: 31, Actual: %d. Exepcted ReadLo: -32, Actual: %d", ReadHi, ReadLo);
    
        @(posedge Clk);
        tests = tests + 1;
        WriteHiData <= 32'd0;
        WriteLoData <= -32'd32;
        WriteEn <= 1'b0;
        Madd <= 1'b1;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadHi == 32'd31 && ReadLo == -32'd64)
            passed = passed + 1;
        else
            $display("Madd failed. Expected ReadHi: 31, Actual: %d. Exepcted ReadLo: -32, Actual: %d", ReadHi, ReadLo);
            
        @(posedge Clk);
        tests = tests + 1;
        WriteHiData <= 32'd32;
        WriteLoData <= -32'd1;
        Madd <= 1'b0;
        WriteEn <= 1'b1;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadHi == 32'd32 && ReadLo == -32'd1)
            passed = passed + 1;
        else
            $display("Writing into hilo failed. Expected ReadHi: 32, Actual: %d. Exepcted ReadLo: -1, Actual: %d", ReadHi, ReadLo);
   
        @(posedge Clk);
        tests = tests + 1;
        WriteHiData <= 32'd0;
        WriteLoData <= 32'd1024;
        WriteEn <= 1'b0;
        Msub <= 1'b1;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadHi == 32'd32 && ReadLo == -32'd1025)
            passed = passed + 1;
        else
            $display("Madd failed. Expected ReadHi: 32, Actual: %d. Exepcted ReadLo: -1025, Actual: %d", ReadHi, ReadLo);
            
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
        
    end

endmodule

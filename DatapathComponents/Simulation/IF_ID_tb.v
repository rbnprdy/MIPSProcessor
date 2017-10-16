`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 07:48:46 PM
// Design Name: 
// Module Name: IF_ID_tb
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


module IF_ID_tb();
 
    reg [31:0] PCAddIn, InstructionIn;
    reg Clk;
    
    integer passed;
    integer tests;

    wire [31:0] PCAddOut, InstructionOut;   
    
    IF_ID u0(
        .Clk(Clk),
        .PCAddIn(PCAddIn),
        .InstructionIn(InstructionIn),
        .PCAddOut(PCAddOut),
        .InstructionOut(InstructionOut)
    );
        
    initial begin
       Clk <= 1'b0;
       forever #10 Clk <= ~Clk;
    end    
    
    initial begin
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        PCAddIn <= 32'b0;
        InstructionIn <= 32'b0;
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
        //Testing Instuction
        InstructionIn <= 32'b11111111111111111111111111111111;
        tests <= tests + 1;
        @(posedge Clk);
        @(negedge Clk);
        if (InstructionOut == InstructionIn)
            passed <= passed + 1;
        else
            $display("Instruction Test Failed, Expected: %d, Actual: %d", InstructionIn, InstructionOut);
        #10;
        if (tests == passed)
            $display("All tests passed");
            $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            
    end
endmodule

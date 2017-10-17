`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 07:28:33 PM
// Design Name: 
// Module Name: Execute_tb
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


module Execute_tb();

    reg Clk;

    reg [31:0] ReadData1, ReadData2, Instruction_15_0_Extended, PCAddResult;
    reg [3:0] Instruction_10_6, Instruction_20_16, Instruction_15_11;
    reg ALUSrc, RegDst, HiLoWrite, Madd, Msub;
    reg [31:0] InstructionToALU;
    
    wire [31:0] ReadDataHi, ReadDataLo, PCAddResultOut, ALUResult;
    wire Zero;
    wire [3:0] WriteRegister;
    
    integer tests;
    integer passed;
        
    Execute E1(
        // Inputs
        .Clk(Clk),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .Instruction_10_6(Instruction_10_6),
        .Instruction_15_0_Extended(Instruction_15_0_Extended),
        .Instruction_20_16(Instruction_20_16),
        .Instruction_15_11(Instruction_15_11),
        .PCAddResult(PCAddResult),
        // Controller Inputs
        .ALUSrc(ALUSrc), 
        .InstructionToALU(InstructionToALU),
        .RegDst(RegDst),
        .HiLoWrite(HiLoWrite), 
        .Madd(Madd), 
        .Msub(Msub), 
        // Outputs
        .ReadDataHi(ReadDataHi),
        .ReadDataLo(ReadDataLo),
        .PCAddResultOut(PCAddResultOut),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .WriteRegister(WriteRegister)
    );
    
    initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
        // Initial Assignment
        tests <= 0;
        passed <= 0;
                
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        
        ///////// TYPE-R INSTRUCTIONS //////////
            
        #5 // Test Add
        tests = tests + 1;
        InstructionToALU <= {6'b000000, 5'b01000, 5'b01001, 5'b01010, 5'b00000, 6'b100000}; // add $t0, $t1, $t2
        ReadData1 <= 32'd5;
        ReadData2 <= 32'd7;
        ALUSrc <= 0;
        #5 if (ALUResult == 32'd12)
            passed = passed + 1;
        else
            $display("Test Add Failed. Expected ALUResult: 12. Actual ALUResult: %d", ALUResult);
        
        #5 // Test Addi
        tests = tests + 1;
        InstructionToALU <= {6'b001000, 5'b01000, 5'b01001, 16'b0000000000001001}; // Addi $t0, $t1, 9
        Instruction_15_0_Extended <= 32'd9;
        ALUSrc <= 1;
        #5 if (ALUResult == 32'd14)
            passed = passed + 1;
        else
            $display("Test Addi Failed. Expected ALUResult: 14. Actual ALUResult: %d", ALUResult);
            
        #5 // Test Madd
        @(posedge Clk) #5;
        tests = tests + 1;
        InstructionToALU <= {6'b011100, 5'b01000, 5'b01001, 5'b00000, 5'b00000, 6'b000000}; // madd $t0, $t1
        ReadData1 <= 32'd2000000020;
        ReadData2 <= 32'd4;
        Madd <= 1;
        ALUSrc <= 0;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadDataHi == 32'b00000000000000000000000000000001 && ReadDataLo == 32'b11011100110101100101000001010000)
            passed = passed + 1;
        else
            $display("Test Madd Failed. Expected ReadDataHi: 0000000000000000000000000000001. Actual ReadDataHi: %b. Expected ReadDataLo: 11011100110101100101000001010000. Actual ReadDataLo: %b", ReadDataHi, ReadDataLo);
        
        #5 // Test Msub
        @(posedge Clk) #5;
        tests = tests + 1;
        InstructionToALU <= {6'b011100, 5'b01000, 5'b01001, 5'b00000, 5'b00000, 6'b000100}; // msub $t0, $t1
        ReadData1 <= 32'd2000000040;
        ReadData2 <= 32'd6;
        Madd <= 0;
        Msub <= 1;
        ALUSrc <= 0;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadDataHi == 32'b11111111111111111111111111111111 && ReadDataLo == 32'b11101110011010110010100010100000)
            passed = passed + 1;
        else
            $display("Test Msub Failed. Expected ReadDataHi: 11111111111111111111111111111111. Actual ReadDataHi: %b. Expected ReadDataLo: 11101110011010110010100010100000. Actual ReadDataLo: %b", ReadDataHi, ReadDataLo);

        #5 // Test RegDestMux #1
        tests = tests + 1;
        RegDst <= 0;
        Instruction_20_16 <= 32'd15;
        #5 if (WriteRegister == 32'd15)
            passed = passed + 1;
        else 
            $display("Test RegDstMux #1 Failed. Expected WriteRegister: 15. Actual WriteRegister: %d", WriteRegister);
        
        #5 // Test RegDestMux #2
        tests = tests + 1;
        RegDst <= 1;
        Instruction_15_11 <= 32'd8;
        #5 if (WriteRegister == 32'd8)
            passed = passed + 1;
        else 
            $display("Test RegDstMux #2 Failed. Expected WriteRegister: 8. Actual WriteRegister: %d", WriteRegister);

        #5 // Test PCAdd
        tests = tests + 1;
        PCAddResult <= 32'd1;
        Instruction_15_0_Extended <= 32'b00000000000000000000000000000110;
        #5 if (PCAddResultOut == 32'b00000000000000000000000000011001)
            passed = passed + 1;
        else
            $display("Test PCAdd Failed. Expected PCAddResultOut: 00000000000000000000000000011001. Actual PCAddResultOut: %b.", PCAddResultOut);
        
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d test passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
    end    
endmodule

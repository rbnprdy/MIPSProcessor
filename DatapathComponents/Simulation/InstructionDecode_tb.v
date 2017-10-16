`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 04:51:09 PM
// Design Name: 
// Module Name: InstructionDecode_tb
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


module InstructionDecode_tb();
    
    reg Clk, RegWriteIn, Move;
    reg [31:0] Instruction, WriteData;
    reg [4:0] WriteRegister;
    
    wire [31:0] ReadData1, ReadData2, Instruction_15_0_Extended;
    wire [3:0] Instruction_10_6, Instruction_20_16, Instruction_15_11;
    wire PCSrc, RegWrite, ALUSrc, RegDst, HiLoWrite, Madd, Msub, MemWrite, MemRead, Branch, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero;
    wire [31:0] InstructionToALU;
    
    integer tests;
    integer passed;
        
    InstructionDecode I1(
        // Inputs
        .Clk(Clk),
        .Instruction(Instruction),
        .WriteRegister(WriteRegister),
        .WriteData(WriteData),
        .RegWriteIn(RegWriteIn),
        .Move(Move),
        // Outputs
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .Instruction_15_0_Extended(Instruction_15_0_Extended),
        // Control Signals
        .PCSrc(PCSrc), 
        .RegWrite(RegWrite), 
        .ALUSrc(ALUSrc), 
        .InstructionToALU(InstructionToALU),
        .RegDst(RegDst),
        .HiLoWrite(HiLoWrite), 
        .Madd(Madd), 
        .Msub(Msub), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .Branch(Branch),
        .MemToReg(MemToReg), 
        .HiOrLo(HiOrLo), 
        .HiToReg(HiToReg), 
        .DontMove(DontMove), 
        .MoveOnNotZero(MoveOnNotZero)
    );
    
    initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
        // Initial Assignment
        Instruction <= 32'd0;
        tests <= 0;
        passed <= 0;
                
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        
        ///////// TYPE-R INSTRUCTIONS //////////
        
        #5 // Test Add
        tests = tests + 1;
        Instruction <= {6'b000000, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b100000}; // add
        @(posedge Clk);
        #5 if (PCSrc == 0 && ALUSrc == 0 && RegDst == 1 && HiLoWrite == 0 && Madd == 0 && Msub == 0 
            && MemWrite == 0 && MemRead == 0 && Branch == 0 && MemToReg == 1 && HiToReg == 0
            && RegWrite == 1 && DontMove == 1)
            passed = passed + 1;
        else
            $display("Test Controller Add Failed.");
            
        #5 // Test Addi
        tests = tests + 1;
        Instruction <= {6'b001000, 5'b01000, 5'b01001, 5'b00000, 5'b00000, 6'b000010}; // addi $t0, $t1, 2
        @(posedge Clk);
        #5 if (PCSrc == 0 && ALUSrc == 1 && RegDst == 0 && HiLoWrite == 0 && Madd == 0 && Msub == 0 
            && MemWrite == 0 && MemRead == 0 && Branch == 0 && MemToReg == 1 && HiToReg == 0
            && RegWrite == 1 && DontMove == 1)
            passed = passed + 1;
        else
            $display("Test Addi Failed.");
            
        #5 // Test Writing and Reading into RegisterFile
        tests = tests + 1;
        WriteData <= 32'd5;
        WriteRegister <= 32'd9;
        RegWriteIn <= 1;
        Move <= 1;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadData2 == 32'd5)
            passed = passed + 1;
        else
            $display("Test Writing and Reading into RegisterFile Failed. Expected ReadData2: 5. Actual ReadData2: %d", ReadData2);
            
        #5 // Test overwriting without move.
        tests = tests + 1;
        @(posedge Clk) #5;
        WriteData <= 32'd7;
        Move <= 0;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadData2 == 32'd5)
            passed = passed + 1;
        else
            $display("Test Overwriting without move Failed. Expected ReadData2: 5. Actual ReadData2: %d", ReadData2);
            
        #5 // Test overwriting.
        tests = tests + 1;
        @(posedge Clk) #5;
        WriteData <= 32'd9;
        Move <= 1;
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadData2 == 32'd9)
            passed = passed + 1;
        else
            $display("Test Overwriting Failed. Expected ReadData2: 9. Actual ReadData2: %d", ReadData2);
            
        #5 // Test writing to new register.
        tests = tests + 1;
        @(posedge Clk) #5;
        WriteData <= 32'd344;
        WriteRegister <= 32'd14;
        Instruction <= {6'b001000, 5'b01110, 5'b01001, 5'b00000, 5'b00000, 6'b000010}; // addi $t6, $t1, 2
        @(posedge Clk);
        @(negedge Clk);
        #5 if (ReadData1 == 32'd344)
            passed = passed + 1;
        else
            $display("Test Writing to New Register Failed. Expected ReadData2: 9. Actual ReadData2: %d", ReadData2);
            
        #5 // Test Sign Extension
        tests = tests + 1;
        Instruction <= {6'b001000, 5'b01110, 5'b01001, 16'b1000000000001001};
        #5 if (Instruction_15_0_Extended == 32'b11111111111111111000000000001001)
            passed = passed + 1;
        else
            $display("Test Sign Extension Failed. Expected Instruction_15_0_Extended: 11111111111111111000000000001001. Actual Instruction_15_0_Extended: %b", ReadData2);
                             
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d test passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
    end    
    
endmodule

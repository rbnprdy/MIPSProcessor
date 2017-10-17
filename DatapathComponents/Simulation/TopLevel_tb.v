`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 03:32:01 PM
// Design Name: 
// Module Name: TopLevel_tb
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


module TopLevel_tb();

    reg Clk, Rst;
    
    wire [31:0] WriteData, PCValue;
    
    integer tests, passed;
    
    TopLevel m0(
        .Clk(Clk),
        .Rst(Rst),
        .WriteData(WriteData),
        .PCValue(PCValue)
    );
    
   initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
        tests <= 0;
        passed <= 0;
        Rst <= 1;
        
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
               
        @(negedge Clk);
        @(negedge Clk);
        #5 Rst <= 0;
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk); 
        
        // addi $s0, $zero, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("addi $s0, $zero, 1 failed. Exp WD: 1. Act WD: %d", WriteData);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s1, $zero, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("addi $s1, $zero, 1 failed. Exp WD: 1. Act WD: %d", WriteData);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // and $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("and $s0, $s0, $s1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // and $s0, $s0, $zero
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("and $s0, $s0, $zero failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sub $s0, $s1, $s0
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("sub $s0, $s1, $s0 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // nor $s0, $s0, $zero
        tests = tests + 1;
        #5 if (WriteData == -32'd2)
            passed = passed + 1;
        else
            $display("nor $s0, $s0, $zero failed. Exp WD: -2. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // nor $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("nor $s0, $s0, $s1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // or $s0, $zero, $zero
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("or $s0, $zero, $zero failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // or $s0, $s1, $zero
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("or $s0, $s1, $zero failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sll $s0, $s0, 2
        tests = tests + 1;
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("and $s0, $s0, $s1 failed. Exp WD: 4. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sllv $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd8)
            passed = passed + 1;
        else
            $display("sllv $s0, $s0, $s1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // slt $s0, $s0, $zero
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("slt $s0, $s0, $zero failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // slt $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("slt $s0, $s0, $s1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sra $s0, $s1, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("sra $s0, $s1, 1 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // srav $s0, $s1, $zero
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("srav $s0, $s1, $zero failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // srl $s0, $s1, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("srl $s0, $s1, 1 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sll $s0, $s1, 3
        tests = tests + 1;
        #5 if (WriteData == 32'd8)
            passed = passed + 1;
        else
            $display("sll $s0, $s1, 3 failed. Exp WD: 8. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // srl $s0, $s0, 3
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("srl $s0, $s0, 3 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sllv $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("sllv $s0, $s0, $s1 failed. Exp WD: 2. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // srlv $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("srlv $s0, $s0, $s1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // xor $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("xor $s0, $s0, $s1 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // xor $s0, $s0, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("xor $s0, $s0, $s1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s2, $zero, 4
        tests = tests + 1;
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("addi $s2, $zero, 4 failed. Exp WD: 4. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mul $s0, $s0, $s2
        tests = tests + 1;
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("mul $s0, $s0, $s2 failed. Exp WD: 4. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $s0, 4
        tests = tests + 1;
        #5 if (WriteData == 32'd8)
            passed = passed + 1;
        else
            $display("addi $s0, $s0, 4 failed. Exp WD: 8. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // andi $s0, $s0, 0
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("andi $s0, $s0, 0 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // ori $s0, $s0, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("ori $s0, $s0, 1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // slti $s0, $s0, 0
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("slti $s0, $s0, 0 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // slti $s0, $s0, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("slti $s0, $s0, 1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // xori $s0, $s0, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("xori $s0, $s0, 1 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // xori $s0, $s0, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("xori $s0, $s0, 1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $zero, -2
        tests = tests + 1;
        #5 if (WriteData == -32'd2)
            passed = passed + 1;
        else
            $display("addi $s0, $zero, -2 failed. Exp WD: -2. Act WD: %d", WriteData);
                            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s1, $zero, 2
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("addi $s1, $zero, 2 failed. Exp WD: 2. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sltu $s2, $s1, $s0
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("sltu $s2, $s1, $s0 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sltiu $s0, $s1, -2
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("sltiu $s0, $s1, -2 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // movz $s0, $s1, $zero
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("movz $s0, $s1, $zero failed. Exp WD: 2. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // movn $s0, $zero, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("movn $s0, $zero, $s1 failed. Exp WD: 0. Act WD: %d", WriteData); 
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // add $s0, $s1, $s2
        tests = tests + 1;
        #5 if (WriteData == 32'd3)
            passed = passed + 1;
        else
            $display("and $s0, $s1, $s2 failed. Exp WD: 3. Act WD: %d", WriteData);    
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $zero, -2
        tests = tests + 1;
        #5 if (WriteData == -32'd2)
            passed = passed + 1;
        else
            $display("addi $s0, $zero, -2 failed. Exp WD: -2. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addu $s1, $s1, $s0
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("and $s1, $s1, $s0 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addiu $s1, $zero, -1
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("addiu $s1, $zero, -1 failed. Exp WD: -1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s2, $zero, 32
        tests = tests + 1;
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("addi $s2, $zero, 32 failed. Exp WD: 32. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mult $s1, $s2
//        tests = tests + 1;
//        #5 if (m0.EX.HiLoReg.ReadHi == -1 && m0.EX.HiLoReg.ReadLo == -32)
//            passed = passed + 1;
//        else
//            $display("mult $s1, $s2 failed. Exp Hi: -1. Act Hi: %d. Exp Lo: -32. Act Lo: %d", m0.EX.HiLoReg.ReadHi, m0.EX.HiLoReg.ReadLo);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mfhi $s4
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("mfhi $s4 failed. Exp WD: -1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mflo $s5
        tests = tests + 1;
        #5 if (WriteData == -32'd32)
            passed = passed + 1;
        else
            $display("mflo $s5 failed. Exp WD: -32. Act WD: %d", WriteData);
                        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // multu $s1, $s2
//        tests = tests + 1;
//        #5 if (m0.EX.HiLoReg.ReadHi == 31 && m0.EX.HiLoReg.ReadLo == -32)
//            passed = passed + 1;
//        else
//            $display("multu $s1, $s2 failed. Exp Hi: 31. Act Hi: %d. Exp Lo: -32. Act Lo: %d", m0.EX.HiLoReg.ReadHi, m0.EX.HiLoReg.ReadLo);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mfhi $s4
        tests = tests + 1;
        #5 if (WriteData == 32'd31)
            passed = passed + 1;
        else
            $display("mfhi $s4 failed. Exp WD: 31. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mflo $s5
        tests = tests + 1;
        #5 if (WriteData == -32'd32)
            passed = passed + 1;
        else
            $display("mflo $s5 failed. Exp WD: -32. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        // madd $s1, $s2
//        tests = tests + 1;
//        #5 if (m0.EX.HiLoReg.ReadHi == 31 && m0.EX.HiLoReg.ReadLo == -64)
//            passed = passed + 1;
//        else
//            $display("madd $s1, $s2 failed. Exp Hi: 31. Act Hi: %d. Exp Lo: -64. Act Lo: %d", m0.EX.HiLoReg.ReadHi, m0.EX.HiLoReg.ReadLo);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mfhi $s4
        tests = tests + 1;
        #5 if (WriteData == 32'd31)
            passed = passed + 1;
        else
            $display("mfhi $s4 failed. Exp WD: 31. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mflo $s5
        tests = tests + 1;
        #5 if (WriteData == -32'd64)
            passed = passed + 1;
        else
            $display("mflo $s5 failed. Exp WD: -64. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mthi $s2
        tests = tests + 1;
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("mthi $s2 failed. Exp WD: 32. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mtlo $s1
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("mtlo $s1 failed. Exp WD: -1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mfhi $s4
        tests = tests + 1;
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("mfhi $s4 failed. Exp WD: 32. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mflo $s5
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("mflo $s5 failed. Exp WD: -1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // andi $s1, $s1, 65535
        tests = tests + 1;
        #5 if (WriteData == 32'd65535)
            passed = passed + 1;
        else
            $display("andi $s1, $s1, 65535 failed. Exp WD: 65535. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
            
        // msub $s4, $s2
//        tests = tests + 1;
//        #5 if (m0.EX.HiLoReg.ReadHi == 32 && m0.EX.HiLoReg.ReadLo == -1025)
//            passed = passed + 1;
//        else
//            $display("msub $s4, $s2 failed. Exp Hi: 32. Act Hi: %d. Exp Lo: -1025. Act Lo: %d", m0.EX.HiLoReg.ReadHi, m0.EX.HiLoReg.ReadLo);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mfhi $s4
        tests = tests + 1;
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("mfhi $s4 failed. Exp WD: 32. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // mflo $s5
        tests = tests + 1;
        #5 if (WriteData == -32'd1025)
            passed = passed + 1;
        else
            $display("mflo $s5 failed. Exp WD: -1025. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s2, $zero, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("andi $s2, $zero, 1 failed. Exp WD: 1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // rotr $s1, $s2, 31
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("rotr $s1, $s2, 31 failed. Exp WD: 2. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s4, $zero, 31
        tests = tests + 1;
        #5 if (WriteData == 32'd31)
            passed = passed + 1;
        else
            $display("andi $s4, $zero, 31 failed. Exp WD: 31. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // rotrv $s1, $s1, $s4
        tests = tests + 1;
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("rotrv $s1, $s1, $s4 failed. Exp WD: 4. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // ori $s1, $zero, 0x0FF0
        tests = tests + 1;
        #5 if (WriteData == 32'h0FF0)
            passed = passed + 1;
        else
            $display("ori $s1, $zero, 0x0FF0 failed. Exp WD: 0FF0. Act WD: %h", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // seb $s4, $s1
        tests = tests + 1;
        #5 if (WriteData == -32'd16)
            passed = passed + 1;
        else
            $display("seb $s4, $s1 failed. Exp WD: -16. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // seh $s4, $s1
        tests = tests + 1;
        #5 if (WriteData == 32'd4080)
            passed = passed + 1;
        else
            $display("seh $s4, $s1 failed. Exp WD: 4080. Act WD: %d", WriteData);
                        
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
    end
    
endmodule

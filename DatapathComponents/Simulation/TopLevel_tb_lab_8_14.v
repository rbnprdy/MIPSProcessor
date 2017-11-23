`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2017 03:55:32 PM
// Design Name: 
// Module Name: TopLevel_tb_lab_8_14
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


module TopLevel_tb_lab_8_14();

    reg Clk, Rst;
        
    wire [31:0] WriteData, PCValue, HiReg, LoReg;
    
    integer tests, passed;
    
    TopLevel m0(
        .Clk(Clk),
        .Rst(Rst),
        .WriteData(WriteData),
        .PCValue(PCValue),
        .HiReg(HiReg),
        .LoReg(LoReg)
    );
          
    initial begin
        Clk <= 1'b0;
        forever #100 Clk <= ~Clk;
    end
    
    initial begin
        tests <= 0;
        passed <= 0;
        Rst <= 1;
        
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        
        @(negedge Clk);
        @(negedge Clk);
        Rst <= 0;
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        // main:
        
        
        // addi    $s0, $zero, 1       
        @(negedge Clk);
        tests = tests + 1; // Test #1
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #1: addi    $s0, $zero, 1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // addi    $s1, $zero, 1       
        @(negedge Clk);
        tests = tests + 1; // Test #2
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #2: addi    $s1, $zero, 1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // and     $s0, $s0, $s1       
        @(negedge Clk);
        tests = tests + 1; // Test #3
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #3: and     $s0, $s0, $s1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // and     $s0, $s0, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #4
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #4: and     $s0, $s0, $zero. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // sub     $s0, $s1, $s0       
        @(negedge Clk);
        tests = tests + 1; // Test #5
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #5: sub     $s0, $s1, $s0. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // nor     $s0, $s0, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #6
        #5 if (WriteData == -32'd2)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #6: nor     $s0, $s0, $zero. Exceptect WriteData: -2. Actual WriteData: %d", $time, WriteData);
        
        // nor     $s0, $s0, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #7
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #7: nor     $s0, $s0, $zero. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // or      $s0, $zero, $zero   
        @(negedge Clk);
        tests = tests + 1; // Test #8
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #8: or      $s0, $zero, $zero. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // or      $s0, $s1, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #9
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #9: or      $s0, $s1, $zero. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // sll     $s0, $s0, 2         
        @(negedge Clk);
        tests = tests + 1; // Test #10
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #10: sll     $s0, $s0, 2. Exceptect WriteData: 4. Actual WriteData: %d", $time, WriteData);
        
        // sllv    $s0, $s0, $s1       
        @(negedge Clk);
        tests = tests + 1; // Test #11
        #5 if (WriteData == 32'd8)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #11: sllv    $s0, $s0, $s1. Exceptect WriteData: 8. Actual WriteData: %d", $time, WriteData);
        
        // slt     $s0, $s0, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #12
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #12: slt     $s0, $s0, $zero. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // slt     $s0, $s0, $s1       
        @(negedge Clk);
        tests = tests + 1; // Test #13
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #13: slt     $s0, $s0, $s1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // sra     $s0, $s1, 1         
        @(negedge Clk);
        tests = tests + 1; // Test #14
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #14: sra     $s0, $s1, 1. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // srav    $s0, $s1, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #15
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #15: srav    $s0, $s1, $zero. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // srl     $s0, $s1, 1         
        @(negedge Clk);
        tests = tests + 1; // Test #16
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #16: srl     $s0, $s1, 1. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // sll     $s0, $s1, 3         
        @(negedge Clk);
        tests = tests + 1; // Test #17
        #5 if (WriteData == 32'd8)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #17: sll     $s0, $s1, 3. Exceptect WriteData: 8. Actual WriteData: %d", $time, WriteData);
        
        // srl     $s0, $s0, 3         
        @(negedge Clk);
        tests = tests + 1; // Test #18
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #18: srl     $s0, $s0, 3. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // sllv    $s0, $s0, $s1       
        @(negedge Clk);
        tests = tests + 1; // Test #19
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #19: sllv    $s0, $s0, $s1. Exceptect WriteData: 2. Actual WriteData: %d", $time, WriteData);
        
        // srlv    $s0, $s0, $s1       
        @(negedge Clk);
        tests = tests + 1; // Test #20
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #20: srlv    $s0, $s0, $s1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // xor     $s0, $s0, $s1       
        @(negedge Clk);
        tests = tests + 1; // Test #21
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #21: xor     $s0, $s0, $s1. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // xor     $s0, $s0, $s1       
        @(negedge Clk);
        tests = tests + 1; // Test #22
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #22: xor     $s0, $s0, $s1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // addi    $s2, $zero, 4        
        @(negedge Clk);
        tests = tests + 1; // Test #23
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #23: addi    $s2, $zero, 4. Exceptect WriteData: 4. Actual WriteData: %d", $time, WriteData);
        
        // mul     $s0, $s0, $s2       
        @(negedge Clk);
        tests = tests + 1; // Test #24
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #24: mul     $s0, $s0, $s2. Exceptect WriteData: 4. Actual WriteData: %d", $time, WriteData);
        
        // addi    $s0, $s0, 4         
        @(negedge Clk);
        tests = tests + 1; // Test #25
        #5 if (WriteData == 32'd8)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #25: addi    $s0, $s0, 4. Exceptect WriteData: 8. Actual WriteData: %d", $time, WriteData);
        
        // andi    $s0, $s0, 0         
        @(negedge Clk);
        tests = tests + 1; // Test #26
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #26: andi    $s0, $s0, 0. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // ori     $s0, $s0, 1         
        @(negedge Clk);
        tests = tests + 1; // Test #27
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #27: ori     $s0, $s0, 1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // slti    $s0, $s0, 0         
        @(negedge Clk);
        tests = tests + 1; // Test #28
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #28: slti    $s0, $s0, 0. Exceptect WriteData: . Actual WriteData: %d", $time, WriteData);
        
        // slti    $s0, $s0, 1         
        @(negedge Clk);
        tests = tests + 1; // Test #29
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #29: slti    $s0, $s0, 1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // xori    $s0, $s0, 1         
        @(negedge Clk);
        tests = tests + 1; // Test #30
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #30: xori    $s0, $s0, 1. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // xori    $s0, $s0, 1         
        @(negedge Clk);
        tests = tests + 1; // Test #31
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #31: xori    $s0, $s0, 1. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // addi    $s0, $zero, -2      
        @(negedge Clk);
        tests = tests + 1; // Test #32
        #5 if (WriteData == -32'd2)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #32: addi    $s0, $zero, -2. Exceptect WriteData: -2. Actual WriteData: %d", $time, WriteData);
        
        // addi    $s1, $zero, 2       
        @(negedge Clk);
        tests = tests + 1; // Test #33
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #33: addi    $s1, $zero, 2. Exceptect WriteData: 2. Actual WriteData: %d", $time, WriteData);
        
        // sltu    $s2, $s1, $s0       
        @(negedge Clk);
        tests = tests + 1; // Test #34
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #34: sltu    $s2, $s1, $s0. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // sltiu   $s0, $s1, -2        
        @(negedge Clk);
        tests = tests + 1; // Test #35
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #35: sltiu   $s0, $s1, -2. Exceptect WriteData: 1. Actual WriteData: %d", $time, WriteData);
        
        // movz    $s0, $s1, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #36
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #36: movz    $s0, $s1, $zero. Exceptect WriteData: 2. Actual WriteData: %d", $time, WriteData);
        
        // movn    $s0, $zero, $s1     
        @(negedge Clk);
        tests = tests + 1; // Test #37
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #37: movn    $s0, $zero, $s1. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // add     $s0, $s1, $s2       
        @(negedge Clk);
        tests = tests + 1; // Test #38
        #5 if (WriteData == 32'd3)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #38: add     $s0, $s1, $s2. Exceptect WriteData: 3. Actual WriteData: %d", $time, WriteData);
        
        // addi    $s0, $zero, -2      
        @(negedge Clk);
        tests = tests + 1; // Test #39
        #5 if (WriteData == -32'd2)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #39: addi    $s0, $zero, -2. Exceptect WriteData: -2. Actual WriteData: %d", $time, WriteData);
        
        // addu    $s1, $s1, $s0       
        @(negedge Clk);
        tests = tests + 1; // Test #40
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #40: addu    $s1, $s1, $s0. Exceptect WriteData: 0. Actual WriteData: %d", $time, WriteData);
        
        // addiu  $s1, $zero, -1
        @(negedge Clk);
        
        // addi   $s2, $zero, 32       
        @(negedge Clk);
        tests = tests + 1; // Test #41
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #41: addi   $s2, $zero, 32. Exceptect WriteData: 32. Actual WriteData: %d", $time, WriteData);
        
        // mult   $s1, $s2 
        @(negedge Clk);
        
        // mfhi   $s4  
        @(negedge Clk);
        tests = tests + 1; // Test #42
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #42: mfhi   $s4. Exceptect WriteData: -1. Actual WriteData: %d", $time, WriteData);
        
        // mflo   $s5 
        @(negedge Clk);
        tests = tests + 1; // Test #43
        #5 if (WriteData == -32'd32)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #43: mflo   $s5. Exceptect WriteData: -32. Actual WriteData: %d", $time, WriteData);
        
        // multu  $s1, $s2 
        @(negedge Clk);
        
        // mfhi   $s4  
        @(negedge Clk);
        tests = tests + 1; // Test #44
        #5 if (WriteData == 32'd31)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #44: mfhi   $s4. Exceptect WriteData: 31. Actual WriteData: %d", $time, WriteData);
        
        // mflo   $s5 
        @(negedge Clk);
        tests = tests + 1; // Test #45
        #5 if (WriteData == -32'd32)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #45: mflo   $s5. Exceptect WriteData: -32. Actual WriteData: %d", $time, WriteData);
        
        // madd   $s1, $s2 
        @(negedge Clk);
        
        // mfhi   $s4  
        @(negedge Clk);
        tests = tests + 1; // Test #46
        #5 if (WriteData == 32'd31)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #46: mfhi   $s4. Exceptect WriteData: 31. Actual WriteData: %d", $time, WriteData);
        
        // mflo   $s5 
        @(negedge Clk);
        tests = tests + 1; // Test #47
        #5 if (WriteData == -32'd64)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #47: mflo   $s5. Exceptect WriteData: -64. Actual WriteData: %d", $time, WriteData);
        
        // mthi   $s2 
        @(negedge Clk);
        tests = tests + 1; // Test #48
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #48: mthi   $s2. Exceptect WriteData: 32. Actual WriteData: %d", $time, WriteData);
        
        // mtlo   $s1 
        @(negedge Clk);
        tests = tests + 1; // Test #49
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #49: mtlo   $s1. Exceptect WriteData: -1. Actual WriteData: %d", $time, WriteData);
        
        // mfhi   $s4  
        @(negedge Clk);
        tests = tests + 1; // Test #50
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #50: mfhi   $s4. Exceptect WriteData: 32. Actual WriteData: %d", $time, WriteData);
        
        // mflo   $s5 
        @(negedge Clk);
        tests = tests + 1; // Test #51
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #51: mflo   $s5. Exceptect WriteData: -1. Actual WriteData: %d", $time, WriteData);
        
        // andi   $s1 , $s1, 65535  
        @(negedge Clk);
        tests = tests + 1; // Test #52
        #5 if (WriteData == 32'd65535)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #52: andi   $s1 , $s1, 65535. Exceptect WriteData: 65535. Actual WriteData: %d", $time, WriteData);
        
        // msub   $s4 , $s2     
        @(negedge Clk);
        
        // mfhi   $s4  
        @(negedge Clk);
        tests = tests + 1; // Test #53
        #5 if (WriteData == 32'd32)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #53: mfhi   $s4. Exceptect WriteData: 32. Actual WriteData: %d", $time, WriteData);
        
        // mflo   $s5 
        @(negedge Clk);
        tests = tests + 1; // Test #54
        #5 if (WriteData == -32'd1025)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #54: mflo   $s5. Exceptect WriteData: -1025. Actual WriteData: %d", $time, WriteData);
        
        // addi   $s2, $zero, 1
        @(negedge Clk);
        
        // rotr   $s1, $s2, 31   
        @(negedge Clk);
        tests = tests + 1; // Test #55
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #55: rotr   $s1, $s2, 31. Exceptect WriteData: 2. Actual WriteData: %d", $time, WriteData);
        
        // addi   $s4, $zero, 31
        @(negedge Clk);
        
        // rotrv   $s1, $s1, $s4 
        @(negedge Clk);
        tests = tests + 1; // Test #56
        #5 if (WriteData == 32'd4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #56: rotrv   $s1, $s1, $s4. Exceptect WriteData: 4. Actual WriteData: %d", $time, WriteData);
        
        // ori    $s1 , $zero, 0x0FF0
        @(negedge Clk);
        
        // seb    $s4, $s1   
        @(negedge Clk);
        tests = tests + 1; // Test #57
        #5 if (WriteData == -32'd16)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #57: seb    $s4, $s1. Exceptect WriteData: -16. Actual WriteData: %d", $time, WriteData);
        
        // seh    $s4 , $s1  
        @(negedge Clk);
        tests = tests + 1; // Test #58
        #5 if (WriteData == 32'd4080)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #58: seh    $s4 , $s1. Exceptect WriteData: 4080. Actual WriteData: %d", $time, WriteData);
        
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%3d out of %3d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");

    end
endmodule

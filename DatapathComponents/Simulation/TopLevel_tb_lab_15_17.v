`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2017 04:01:03 PM
// Design Name: 
// Module Name: TopLevel_tb_lab_15_17
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


module TopLevel_tb_lab_15_17();

    reg Clk, Rst;
        
    wire [31:0] WriteData, PCValue, HiData, LoData;
    
    integer tests, passed;
    
    TopLevel m0(
        .Clk(Clk),
        .Rst(Rst),
        .WriteData(WriteData),
        .PCValue(PCValue),
        .HiData(HiData),
        .LoData(LoData)
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
        
        
        // la      $a0, DataMemory     
        @(negedge Clk);
        
        
        //// # Instruction to Binary Translation begin ////
        
        // j       start               
        @(negedge Clk);
        
        // start:
        
        // lw      $s0, 4($a0)         
        @(negedge Clk);
        
        // lw      $s0, 8($a0)         
        @(negedge Clk);
        
        // sw      $s0, 0($a0)         
        @(negedge Clk);
        tests = tests + 1; // Test #1
        #5 if (WriteData == 32'h00000002)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #1: sw      $s0, 0($a0). Exceptect WriteData: 32'h00000002.. Actual WriteData: %d", $time, WriteData);
        
        // sw      $s0, 12($a0)        
        @(negedge Clk);
        tests = tests + 1; // Test #2
        #5 if (WriteData == 32'h00000002)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #2: sw      $s0, 12($a0). Exceptect WriteData: 32'h00000002.. Actual WriteData: %d", $time, WriteData);
        
        // lw      $s1, 0($a0)         
        @(negedge Clk);
        
        // lw      $s2, 12($a0)        
        @(negedge Clk);
        
        // beq     $s0, $zero, branch1 
        @(negedge Clk);
        
        // add     $s1, $s0, $zero     
        @(negedge Clk);
        tests = tests + 1; // Test #3
        #5 if (WriteData == 32'h00000002)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #3: add     $s1, $s0, $zero. Exceptect WriteData: 32'h00000002.. Actual WriteData: %d", $time, WriteData);
        
        // beq     $s0, $s1, branch1   
        @(negedge Clk);
        
        // branch1:
        
        // addi    $s0, $zero, -1        
        @(negedge Clk);
        tests = tests + 1; // Test #4
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #4: addi    $s0, $zero, -1. Exceptect WriteData: -1. Actual WriteData: %d", $time, WriteData);
        
        // bgez    $s0, start          
        @(negedge Clk);
        
        // addi    $s0, $s0, 1         
        @(negedge Clk);
        tests = tests + 1; // Test #5
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #5: addi    $s0, $s0, 1. Exceptect WriteData: 0.. Actual WriteData: %d", $time, WriteData);
        
        // bgez    $s0, branch2        
        @(negedge Clk);
        
        // branch2:
        
        // addi    $s0, $zero, -1      
        @(negedge Clk);
        tests = tests + 1; // Test #6
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #6: addi    $s0, $zero, -1. Exceptect WriteData: -1.. Actual WriteData: %d", $time, WriteData);
        
        // bgtz    $s0, branch3        
        @(negedge Clk);
        
        // addi    $s0, $zero, 1       
        @(negedge Clk);
        tests = tests + 1; // Test #7
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #7: addi    $s0, $zero, 1. Exceptect WriteData: 1.. Actual WriteData: %d", $time, WriteData);
        
        // bgtz    $s0, branch3        
        @(negedge Clk);
        
        // branch3:
        
        // bltz    $s0, branch4        
        @(negedge Clk);
        
        // addi    $s0, $zero, -1      
        @(negedge Clk);
        tests = tests + 1; // Test #8
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #8: addi    $s0, $zero, -1. Exceptect WriteData: -1.. Actual WriteData: %d", $time, WriteData);
        
        // bltz    $s0, branch4        
        @(negedge Clk);
        
        // branch4:
        
        // addi    $s1, $zero, -1      
        @(negedge Clk);
        tests = tests + 1; // Test #9
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #9: addi    $s1, $zero, -1. Exceptect WriteData: -1.. Actual WriteData: %d", $time, WriteData);
        
        // bne     $s0, $s1, branch5   
        @(negedge Clk);
        
        // bne     $s0, $zero, branch5 
        @(negedge Clk);
        
        // branch5:
        
        // addi $s0, $zero, 128        
        @(negedge Clk);
        tests = tests + 1; // Test #10
        #5 if (WriteData == 32'h80)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #10: addi $s0, $zero, 128. Exceptect WriteData: 80. Actual WriteData: %h", $time, WriteData);
        
        // sb   $s0, 0($a0)            # Memory[0][7:0] = 0x80
        
        // lb   $s0, 0($a0)            
        @(negedge Clk);
        tests = tests + 1; // Test #11
        #5 if (WriteData == 32'hffffff80)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #11: lb   $s0, 0($a0). Exceptect WriteData: ffffff80. Actual WriteData: %h", $time, WriteData);
        
        // blez $s0, branch6           
        @(negedge Clk);
        
        // branch6:
        
        // addi $s0, $zero, -1         
        @(negedge Clk);
        tests = tests + 1; // Test #12
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #12: addi $s0, $zero, -1. Exceptect WriteData: -1. Actual WriteData: %d", $time, WriteData);
        
        // sh   $s0, 0($a0)            # Memory[0][15:0] = -1
        
        // addi $s0, $zero, 0            
        @(negedge Clk);
        tests = tests + 1; // Test #13
        #5 if (WriteData == 32'h0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #13: addi $s0, $zero, 0. Exceptect WriteData: 0. Actual WriteData: %h", $time, WriteData);
        
        // lh   $s0, 0($a0)            
        @(negedge Clk);
        tests = tests + 1; // Test #14
        #5 if (WriteData == 32'hffffffff)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #14: lh   $s0, 0($a0). Exceptect WriteData: ffffffff. Actual WriteData: %h", $time, WriteData);
        
        // blez $s0, branch7           
        @(negedge Clk);
        
        // branch7:
        
        // addi $s0, $zero, -1         
        @(negedge Clk);
        tests = tests + 1; // Test #15
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #15: addi $s0, $zero, -1. Exceptect WriteData: -1. Actual WriteData: %d", $time, WriteData);
        
        // lui $s0, 1                  
        @(negedge Clk);
        tests = tests + 1; // Test #16
        #5 if (WriteData == 32'h10000)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #16: lui $s0, 1. Exceptect WriteData: 10000. Actual WriteData: %h", $time, WriteData);
        
        // bgez $s0, branch8           
        @(negedge Clk);
        
        // branch8:
        
        // j       jump1               
        @(negedge Clk);
        
        // jump1:
        
        // jal     jal1                
        @(negedge Clk);
        
        // jal1:
        
        // jr      $ra                 
        @(negedge Clk);
        
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%3d out of %3d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");

    end
endmodule

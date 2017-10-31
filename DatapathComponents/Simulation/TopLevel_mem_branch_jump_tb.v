`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2017 09:10:18 PM
// Design Name: 
// Module Name: TopLevel_mem_branch_jump_tb
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


module TopLevel_mem_branch_jump_tb();

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
        #50 Rst <= 0;
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk); 
        
        //  ori $a0, $zero, 0
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("ori $a0, $zero, 0 failed. Exp WD: 0. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // j start
        tests = tests + 1;
        #5 if (PCValue == 6'b011000)
            passed = passed + 1;
        else
            $display("j start failed. Exp PCValue: 011000. Act PC: %b", PCValue);
            
        /////// DELETE AFTER JUMP IS WORKING ///////
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        /////// DELETE AFTER JUMP IS WORKING ///////
    
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // lw $s0, 4($a0)
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("lw $s0, 4($a0) failed. Exp WriteData: 1. Act WD: %d", WriteData);

        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // lw $s0, 8($a0)
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("lw $s0, 8($a0) failed. Exp WriteData: 2. Act WD: %d", WriteData);
            
        // sw $s0, 0($a0)
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // sw $s0, 12($a0)
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
    
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // lw $s1, 0($a0)
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("lw $s1, 0($a0) failed. Exp WriteData: 2. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // lw $s2, 12($a0)
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("lw $s2, 12($a0) failed. Exp WriteData: 2. Act WD: %d", WriteData);
            
        // beq $s0, $zero, branch1 
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // add $s1, $s0, $zero
        tests = tests + 1;
        #5 if (WriteData == 32'd2)
            passed = passed + 1;
        else
            $display("add $s1, $s0, $zero failed. Exp WriteData: 2. Act WD: %d", WriteData);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(posedge Clk);
        
        // branch $s0, $s1, branch1
        tests = tests + 1;
        #5 if (PCValue == 32'd336)
            passed = passed + 1;
        else
            $display("branch $s0, $s1, branch1 failed. Exp PCValue: 336. Act PC: %d", PCValue);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi    $s0, $zero, -1	
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("branch1 addi $s0, $zero, -1 failed. Exp WriteData: -1. Act WD: %d", WriteData);
                
        // bgez    $s0, start 
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // add $s0, $s0, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("branch1 add $s0, $s0, 1 failed. Exp WriteData: 0. Act WD: %d", WriteData);

        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(posedge Clk);
        
        // bgez $s0, branch2
        tests = tests + 1;
        #5 if (PCValue == 32'd336)
            passed = passed + 1;
        else
            $display("bgez $s0, branch2 failed. Exp PCValue: 336. Act PC: %d", PCValue);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $zero, -1
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("branch2 addi $s0, $zero, -1 failed. Exp WriteData: -1. Act WD: %d", WriteData);
    
        // bgtz    $s0, branch3
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // b/c there's an extra nop
        @(negedge Clk);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $zero, 1
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("branch2 addi $s0, $zero, 1 failed. Exp WriteData: 1. Act WD: %d", WriteData);

        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        // b/c there's an extra nop
        @(negedge Clk);
        @(posedge Clk);
        
        // bgtz $s0, branch3
        tests = tests + 1;
        #5 if (PCValue == 32'd336)
            passed = passed + 1;
        else
            $display("bgtz $s0, branch3 failed. Exp PCValue: 336. Act PC: %d", PCValue);
        
        // bltz $s0, branch4
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);

        // addi $s0, $zero, -1
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("branch3 addi $s0, $zero, -1 failed. Exp WriteData: -1. Act WD: %d", WriteData);
     
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(posedge Clk);
        
        // bltz $s0, branch4
        tests = tests + 1;
        #5 if (PCValue == 32'd336)
            passed = passed + 1;
        else
            $display("bltz $s0, branch4 failed. Exp PCValue: 336. Act PC: %d", PCValue);
        
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s1, $zero, -1
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("branch4 addi $s1, $zero, -1 failed. Exp WriteData: -1. Act WD: %d", WriteData);
            
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
    end
               
endmodule

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
        @(posedge Clk);
        
        // j start
        tests = tests + 1;
        #5 if (PCValue == 8'b01100000)
            passed = passed + 1;
        else
            $display("j start failed. Exp PCValue: 011000. Act PC: %b", PCValue);
    
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
        
        // beq $s0, $s1, branch1
        tests = tests + 1;
        #5 if (PCValue == 32'd336)
            passed = passed + 1;
        else
            $display("beq $s0, $s1, branch1 failed. Exp PCValue: 336. Act PC: %d", PCValue);
            
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
        #5 if (PCValue == 32'd456)
            passed = passed + 1;
        else
            $display("bgez $s0, branch2 failed. Exp PCValue: 456. Act PC: %d", PCValue);
        
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
        #5 if (PCValue == 32'd584)
            passed = passed + 1;
        else
            $display("bgtz $s0, branch3 failed. Exp PCValue: 584. Act PC: %d", PCValue);
        
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
        #5 if (PCValue == 32'd680)
            passed = passed + 1;
        else
            $display("bltz $s0, branch4 failed. Exp PCValue: 680. Act PC: %d", PCValue);
        
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
            
        // bne    $s0, $s1, branch5
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
        @(posedge Clk);
        
        // bne $s0, $zero branch5
        tests = tests + 1;
        #5 if (PCValue == 32'd776)
            passed = passed + 1;
        else
            $display("bne $s0, $zero, branch5 failed. Exp PCValue: 776. Act PC: %d", PCValue);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $zero, 128
        tests = tests + 1;
        #5 if (WriteData == 32'd128)
            passed = passed + 1;
        else
            $display("branch5 addi $s0, $zero, 128 failed. Exp WriteData: 128. Act WD: %d", WriteData);
           
        // sb $s0, 0($a0)
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
          
        // lb $s0, 0($a0)
        tests = tests + 1;
        #5 if (WriteData == 32'hffffff80)
            passed = passed + 1;
        else
            $display("lb $s0, 0($a0) 128 failed. Exp WriteData: 0xffffff80 . Act WD: %h", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(posedge Clk);
        
        // blez $s0, branch6
        tests = tests + 1;
        #5 if (PCValue == 32'd896)
            passed = passed + 1;
        else
            $display("blez $s0, branch6 failed. Exp PCValue: 896. Act PC: %d", PCValue);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $zero, -1
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("branch6 addi $s0, $zero, -1 failed. Exp WriteData: -1. Act WD: %d", WriteData);
           
        // sh $s0, 0($a0)
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
                
        // addi $s0, $zero, 0
        tests = tests + 1;
        #5 if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("branch6 addi $s0, $zero, 0 failed. Exp WriteData: 0. Act WD: %d", WriteData);
                                                       
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
                
        // lh $s0, 0($a0)
        tests = tests + 1;
        #5 if (WriteData == 32'hffffffff)
            passed = passed + 1;
        else
            $display("branch6 lh $s0, 0($a0) failed. Exp WriteData: ffffffff. Act WD: %h", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(posedge Clk);
        
        // blez $s0, branch7
        tests = tests + 1;
        #5 if (PCValue == 32'd1040)
            passed = passed + 1;
        else
            $display("blez $s0, branch7 failed. Exp PCValue: 1040. Act PC: %d", PCValue);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        
        // addi $s0, $zero, -1
        tests = tests + 1;
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("branch7 addi $s0, $zero, -1 failed. Exp WriteData: -1. Act WD: %d", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
                
        // lui $s0, 1
        tests = tests + 1;
        #5 if (WriteData == 32'h10000)
            passed = passed + 1;
        else
            $display("branch7 lui $s0, 1 failed. Exp WriteData: 0x10000. Act WD: %h", WriteData);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(posedge Clk);
        
        // bgez $s0, branch8
        tests = tests + 1;
        #5 if (PCValue == 32'd1136)
            passed = passed + 1;
        else
            $display("bgez $s0, branch8 failed. Exp PCValue: 1136. Act PC: %d", PCValue);
            
        @(negedge Clk);
        @(posedge Clk);
        
        // j jump1
        tests = tests + 1;
        #5 if (PCValue == 32'd1184)
            passed = passed + 1;
        else
            $display("j jump1 failed. Exp PCValue: 1184. Act PC: %d", PCValue);
        
        @(negedge Clk);
        @(posedge Clk);
            
        // jal jal1
        tests = tests + 1;
        #5 if (PCValue == 32'd1232)
            passed = passed + 1;
        else
            $display("jal jal1 failed. Exp PCValue: 1232. Act PC: %d", PCValue);
            
        @(negedge Clk);
        @(posedge Clk);
        
        // jr $ra
        tests = tests + 1;
        #5 if (PCValue == 32'd1192)
            passed = passed + 1;
        else
            $display("jr $ra failed. Exp PCValue: 1192. Act PC: %d", PCValue);
            
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(negedge Clk);
        @(posedge Clk);
        
        // j start
        tests = tests + 1;
        #5 if (PCValue == 32'd96)
            passed = passed + 1;
        else
            $display("j start failed. Exp PCValue: 96. Act PC: %d", PCValue);
            
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        
        // lw $s0, 4($a0)
        tests = tests + 1;
        #5 if (WriteData == 32'd1)
            passed = passed + 1;
        else
            $display("lw $s0, 4($a0) failed. Exp WriteData: 1. Act WD: %d", WriteData);
                                                                   
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
    end
               
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2017 12:03:58 AM
// Design Name: 
// Module Name: TopLevel_tb_Forwarding
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


module TopLevel_tb_Forwarding();

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
        
        // main:
        
        // Had to add this after implementing hazard detection.
        @(negedge Clk);
        
        // la $s2, asize0        
        @(negedge Clk);
        tests = tests + 1; // Test #1
        #5 if (WriteData == 32'h00000000)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #1: la $s2, asize0. Exceptect WriteData: 00000000. Actual WriteData: %h", $time, WriteData);
        
        // lw $s2, 0($s2)        
        @(negedge Clk);
        tests = tests + 1; // Test #2
        #5 if (WriteData == 32'h64)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #2: lw $s2, 0($s2). Exceptect WriteData: 64. Actual WriteData: %h", $time, WriteData);
        
        // la $s3, asize0
        @(negedge Clk);
        
        // lw $s3, 4($s3)        
        @(negedge Clk);
        tests = tests + 1; // Test #3
        #5 if (WriteData == 32'hc8)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #3: lw $s3, 4($s3). Exceptect WriteData: c8. Actual WriteData: %h", $time, WriteData);
        
        
        //// Read After Write(RAW) case 1 ////
        
        // Stalling. 
        @(negedge Clk);
        
        // add $s1, $s2, $s3        
        @(negedge Clk);
        tests = tests + 1; // Test #4
        #5 if (WriteData == 32'h12c)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #4: add $s1, $s2, $s3. Exceptect WriteData: 12c. Actual WriteData: %h", $time, WriteData);
        
        // sub $s4, $s1, $s3        
        @(negedge Clk);
        tests = tests + 1; // Test #5
        #5 if (WriteData == 32'h64)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #5: sub $s4, $s1, $s3. Exceptect WriteData: 64. Actual WriteData: %h", $time, WriteData);
        
        // sub $s1, $s1, $s4        
        @(negedge Clk);
        tests = tests + 1; // Test #6
        #5 if (WriteData == 32'hc8)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #6: sub $s1, $s1, $s4. Exceptect WriteData: c8. Actual WriteData: %h", $time, WriteData);
        
        // mul $s4, $s1, $s3        
        @(negedge Clk);
        tests = tests + 1; // Test #7
        #5 if (WriteData == 32'h9c40)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #7: mul $s4, $s1, $s3. Exceptect WriteData: 9c40. Actual WriteData: %h", $time, WriteData);
        
        
        //// Write after read case 2 ////
        
        // sub $s4, $s1, $s3        
        @(negedge Clk);
        tests = tests + 1; // Test #8
        #5 if (WriteData == 32'h0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #8: sub $s4, $s1, $s3. Exceptect WriteData: 0. Actual WriteData: %h", $time, WriteData);
        
        // add $s1, $s2,$s3        
        @(negedge Clk);
        tests = tests + 1; // Test #9
        #5 if (WriteData == 32'h12c)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #9: add $s1, $s2,$s3. Exceptect WriteData: 12c. Actual WriteData: %h", $time, WriteData);
        
        // mul $s6, $s1, $s4        
        @(negedge Clk);
        tests = tests + 1; // Test #10
        #5 if (WriteData == 32'h0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #10: mul $s6, $s1, $s4. Exceptect WriteData: 0. Actual WriteData: %h", $time, WriteData);
        
        
        //// write after write case 3 ////
        
        // sub $s1, $s4, $s6        
        @(negedge Clk);
        tests = tests + 1; // Test #11
        #5 if (WriteData == 32'h0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #11: sub $s1, $s4, $s6. Exceptect WriteData: 0. Actual WriteData: %h", $time, WriteData);
        
        // add $s1, $s2, $s6        
        @(negedge Clk);
        tests = tests + 1; // Test #12
        #5 if (WriteData == 32'h64)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #12: add $s1, $s2, $s6. Exceptect WriteData: 64. Actual WriteData: %h", $time, WriteData);
        
        // ori $s1, $s1, 0xaaaa    
        @(negedge Clk);
        tests = tests + 1; // Test #13
        #5 if (WriteData == 32'haaee)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #13: ori $s1, $s1, 0xaaaa. Exceptect WriteData: aaee. Actual WriteData: %h", $time, WriteData);
        
        // sll $s1, $s1, 10        
        @(negedge Clk);
        tests = tests + 1; // Test #14
        #5 if (WriteData == 32'h2abb800)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #14: sll $s1, $s1, 10. Exceptect WriteData: 2abb800. Actual WriteData: %h", $time, WriteData);
        
        
        //// Stall case 4 ////
        
        // addi $s5, $s1, 0        
        @(negedge Clk);
        tests = tests + 1; // Test #15
        #5 if (WriteData == 32'h2abb800)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #15: addi $s5, $s1, 0. Exceptect WriteData: 2abb800. Actual WriteData: %h", $time, WriteData);
        
        // addi $s7, $s5, 0        
        @(negedge Clk);
        tests = tests + 1; // Test #16
        #5 if (WriteData == 32'h2abb800)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #16: addi $s7, $s5, 0. Exceptect WriteData: 2abb800. Actual WriteData: %h", $time, WriteData);
        
        // la $s2, asize1            
        @(negedge Clk);
        
        // lw $s1, 0($s2)            
        @(negedge Clk);
        tests = tests + 1; // Test #17
        #5 if (WriteData == 32'h2bc)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #17: lw $s1, 0($s2). Exceptect WriteData: 2bc. Actual WriteData: %h", $time, WriteData);
        
        // Stalling. 
        @(negedge Clk);
        
        // sub $s4, $s1, $s5        
        @(negedge Clk);
        tests = tests + 1; // Test #18
        #5 if (WriteData == 32'hfd544abc)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #18: sub $s4, $s1, $s5. Exceptect WriteData: fd544abc. Actual WriteData: %h", $time, WriteData);
        
        // and $s6, $s1, $s7        
        @(negedge Clk);
        tests = tests + 1; // Test #19
        #5 if (WriteData == 32'h0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #19: and $s6, $s1, $s7. Exceptect WriteData: 0. Actual WriteData: %h", $time, WriteData);
        
        // or $s7, $s1, $s6        
        @(negedge Clk);
        tests = tests + 1; // Test #20
        #5 if (WriteData == 32'h2bc)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #20: or $s7, $s1, $s6. Exceptect WriteData: 2bc. Actual WriteData: %h", $time, WriteData);
        
        
        //// text book example case 5 ////
        
        // sub $s2, $s1, $s3        
        @(negedge Clk);
        tests = tests + 1; // Test #21
        #5 if (WriteData == 32'h1f4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #21: sub $s2, $s1, $s3. Exceptect WriteData: 1f4. Actual WriteData: %h", $time, WriteData);
        
        // and $t0, $s2, $s5        
        @(negedge Clk);
        tests = tests + 1; // Test #22
        #5 if (WriteData == 32'h0)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #22: and $t0, $s2, $s5. Exceptect WriteData: 0. Actual WriteData: %h", $time, WriteData);
        
        // or $t1, $s6, $s2        
        @(negedge Clk);
        tests = tests + 1; // Test #23
        #5 if (WriteData == 32'h1f4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #23: or $t1, $s6, $s2. Exceptect WriteData: 1f4. Actual WriteData: %h", $time, WriteData);
        
        // add $t2, $s2, $s2        
        @(negedge Clk);
        tests = tests + 1; // Test #24
        #5 if (WriteData == 32'h3e8)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #24: add $t2, $s2, $s2. Exceptect WriteData: 3e8. Actual WriteData: %h", $time, WriteData);
        
        // la $s1 , asize0            
        @(negedge Clk);
        
        // sw $t1, 4($s1)            
        @(negedge Clk);
        
        // lw $t2, 4($s1)            
        @(negedge Clk);
        tests = tests + 1; // Test #25
        #5 if (WriteData == 32'h1f4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #25: lw $t2, 4($s1). Exceptect WriteData: 1f4. Actual WriteData: %h", $time, WriteData);
        
        
        //// case 6 ////
        
        // sub   $s2,    $s1,   $s3    
        @(negedge Clk);
        tests = tests + 1; // Test #26
        #5 if (WriteData == 32'hffffff38)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #26: sub   $s2,    $s1,   $s3. Exceptect WriteData: ffffff38. Actual WriteData: %h", $time, WriteData);
        
        // or    $t3,  $s2,   $s5        
        @(negedge Clk);
        tests = tests + 1; // Test #27
        #5 if (WriteData == 32'hffffff38)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #27: or    $t3,  $s2,   $s5. Exceptect WriteData: ffffff38. Actual WriteData: %h", $time, WriteData);
        
        // add   $t4,  $s2,   $s2        
        @(negedge Clk);
        tests = tests + 1; // Test #28
        #5 if (WriteData == 32'hfffffe70)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #28: add   $t4,  $s2,   $s2. Exceptect WriteData: fffffe70. Actual WriteData: %h", $time, WriteData);
        
        // or    $t2, $s2, $s2        
        @(negedge Clk);
        tests = tests + 1; // Test #29
        #5 if (WriteData == 32'hffffff38)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #29: or    $t2, $s2, $s2. Exceptect WriteData: ffffff38. Actual WriteData: %h", $time, WriteData);
        
        // add   $s4,   $s7,    $t2    
        @(negedge Clk);
        tests = tests + 1; // Test #30
        #5 if (WriteData == 32'h000001f4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #30: add   $s4,   $s7,    $t2. Exceptect WriteData: 000001f4. Actual WriteData: %h", $time, WriteData);
        
        
        //// case 7 ////
        
        // la $t1, asize0                
        @(negedge Clk);
        
        // lw $t0, 0($t1)                
        @(negedge Clk);
        tests = tests + 1; // Test #31
        #5 if (WriteData == 32'h64)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #31: lw $t0, 0($t1). Exceptect WriteData: 64. Actual WriteData: %h", $time, WriteData);
        
        // lw $t2, 4($t1)                
        @(negedge Clk);
        tests = tests + 1; // Test #32
        #5 if (WriteData == 32'h1f4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #32: lw $t2, 4($t1). Exceptect WriteData: 1f4. Actual WriteData: %h", $time, WriteData);
        
        // sw $t2, 0($t1)                
        @(negedge Clk);
        
        // sw $t0, 4($t1)                
        @(negedge Clk);
        
        // lw $t0, 0($t1)                
        @(negedge Clk);
        tests = tests + 1; // Test #33
        #5 if (WriteData == 32'h1f4)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #33: lw $t0, 0($t1). Exceptect WriteData: 1f4. Actual WriteData: %h", $time, WriteData);
        
        // lw $t2, 4($t1)                
        @(negedge Clk);
        tests = tests + 1; // Test #34
        #5 if (WriteData == 32'h64)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #34: lw $t2, 4($t1). Exceptect WriteData: 64. Actual WriteData: %h", $time, WriteData);
        
        
        //// branch  cases 8,9,10 ////
        
        // la      $a0, asize1            
        @(negedge Clk);
        
        // j       start               
        @(negedge Clk);
        
        // stall
        @(negedge Clk);
        
        // start:
        
        // lw      $s0, 4($a0)    
        @(negedge Clk);
        tests = tests + 1; // Test #35
        #5 if (WriteData == 32'h320)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #35: lw      $s0, 4($a0). Exceptect WriteData: 320. Actual WriteData: %h", $time, WriteData);
        
        // sw      $s0, 0($a0)
        @(negedge Clk);
        
        // stall
        @(negedge Clk);
        
        // branch1:
        
        // bgez    $s0, branch2     
        @(negedge Clk);
        
        // stall
        @(negedge Clk);
        
        // branch2:
        
        // addi    $s0, $zero, -1  
        @(negedge Clk);
        tests = tests + 1; // Test #36
        #5 if (WriteData == -32'd1)
            passed = passed + 1;
        else
            $display("Time: %0d. Failed Test #36: addi    $s0, $zero, -1. Exceptect WriteData: -1. Actual WriteData: %d", $time, WriteData);
        
        // bltz    $s0, branch3    
        @(negedge Clk);
        
        // branch3:
        
        // bltz    $s0, done        
        @(negedge Clk);
        
        // done:
        
        // j done
        @(negedge Clk);
        
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%3d out of %3d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
    end
endmodule

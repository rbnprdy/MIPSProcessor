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
        
        // la $s2, asize0
        tests = tests + 1;
        @(negedge Clk) #5;
        if (WriteData == 32'd0)
            passed = passed + 1;
        else
            $display("Failed: la $s2, asize0.");
        
        // lw $s2, 0($s2)
        tests = tests + 1;
        @(negedge Clk) #5;
        if (WriteData == 32'h64)
            passed = passed + 1;
        else
            $display("Failed: lw $s2, 0($s2): %d", WriteData);
        
        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d tests passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");

    end
endmodule

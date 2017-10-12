`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;
	
	integer tests;
	integer passed;

	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

    initial begin
        
        // Intial Definitions
        ReadRegister1 <= 5'd0;
        ReadRegister2 <= 5'd0;
        WriteRegister <= 5'd0;
        WriteData <= 32'd0;
        RegWrite <= 0;
        tests <= 0;
        passed <= 0;
        #5
        
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        
        // Test Writing and then Reading into a register
        tests = tests + 1;
        WriteRegister <= 5'd9;
        WriteData <= 32'd7;
        RegWrite <= 1;
        @(posedge Clk);
        ReadRegister1 <= 5'd9;
        @(negedge Clk);
        #5 if (ReadData1 == WriteData)
            passed = passed + 1;
        else
            $display("Test Writing and then Reading Failed. Expected ReadData1: 7. Actual ReadData1: %d", ReadData1);
        
        // Test That Reads Occur on Falling Edge
        tests = tests + 1;
        WriteRegister <= 5'd9;
        WriteData <= 32'd5;
        @(posedge Clk);
        ReadRegister1 <= 5'd9;
        #2 if (ReadData1 == 32'd7)
            passed = passed + 1;
        else
            $display("Test that Reads Occur on Falling Edge Failed. Expected ReadData1: 7. Actual ReadData1: %d", ReadData1);
            
        // Test Overwriting Register
        @(negedge Clk);
        tests = tests + 1;
        #2 if (ReadData1 == 32'd5)
            passed = passed + 1;
        else
            $display("Test Overwriting Register Failed. Expected ReadData1: 5. Actual ReadData1: %d", ReadData1);
            
        // Test Writing to new register and Reading Two Registers
        tests = tests + 1;
        WriteRegister <= 5'd11;
        WriteData <= 32'd45;
        RegWrite <= 1;
        @(posedge Clk);
        ReadRegister1 <= 5'd9;
        ReadRegister2 <= 5'd11;
        @(negedge Clk);
        #5 if (ReadData1 == 32'd5 && ReadData2 == 32'd45)
            passed = passed + 1;
        else
            $display("Test Writing to new register and Reading Two Registers Failed. Expected ReadData1: 5. Actual ReadData1: %d. Expected ReadData2: 45. Actual ReadData2: %d.", ReadData1, ReadData2);
         
        // Test RegWrite
        tests = tests + 1;
        WriteRegister <= 5'd9;
        WriteData <= 32'd23;
        RegWrite <= 0;
        @(posedge Clk);
        ReadRegister1 <= 5'd9;
        #2 if (ReadData1 == 32'd5)
            passed = passed + 1;
        else
            $display("Test RegWrite Failed. Expected ReadData1: 5. Actual ReadData1: %d", ReadData1);

	    // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d test passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");

	end

endmodule

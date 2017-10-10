`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;
    
    integer passed;
    integer tests;

    wire    [31:0]  ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	   $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
       $display("Starting Unit Tests.");
       Address <= 32'b0;
       WriteData <= 32'b0;
       MemWrite <= 0;
       MemRead <= 0;
       passed <= 0;
       tests <= 0;
       #10;
       // Test Writing and then Reading next clock
       tests <= tests + 1;
       Address <= 32'd5;
       WriteData <= 32'd15;
       MemWrite <= 1;
       MemRead <= 1;
       @(posedge Clk);
       #5 if (ReadData == WriteData)
           passed <= passed + 1;
       else
           $display("%t: Test Writing and then Reading Failed. Expected ReadData: %d; ReadData: %d", $time, WriteData, ReadData);
       #10;
       // Test Overwriting data
       tests <= tests + 1;
       Address <= 32'd5;
       WriteData <= 32'd20;
       MemWrite <= 1;
       MemRead <= 1;
       @(posedge Clk);
       MemWrite <= 0;
       #5 if (ReadData == WriteData)
           passed <= passed + 1;
       else
           $display("%t: Test Overwritting Data Failed. Expected ReadData: %d; ReadData: %d", $time, WriteData, ReadData);
       #10;
       // Test MemRead = 0
       tests <= tests + 1;
       MemRead <= 0;
       #5 if(ReadData == 32'b0)
           passed = passed + 1;
       else
           $display("%t: Test MemRead = 0 Failed. Expected ReadData: 0, ReadData: %d", $time, ReadData);
       #20;
       // Test MemWrite = 0
       tests <= tests + 1;
       MemRead <= 1;
       MemWrite <= 0;
       WriteData <= 32'd5;
       @(posedge Clk);
       #5 if(ReadData == 32'd20)
           passed = passed + 1;
       else
           $display("%t: Test MemWrite = 0 Failed. Expected ReadData: 20; ReadData: %d", $time, ReadData);
       // Test writing to different memory address
       #10;
       tests <= tests + 1;
       Address <= 32'd24;
       WriteData <= 32'd7;
       MemWrite <= 1;
       @(posedge Clk);
       #5 if(ReadData == 32'd7)
           passed = passed + 1;
       else
           $display("%t: Test Writting to Different Address Failed. Expected ReadData: %d; ReadData: %d", $time, WriteData, ReadData);
       // Test reading from original memory address
       #10;
       tests <= tests + 1;
       Address <= 32'd5;
       WriteData <= 32'd7;
       MemWrite <= 0;
       #5 if(ReadData == 32'd20)
           passed = passed + 1;
       else
           $display("%t: Test Reading from Original Address Failed. Expected ReadData: %d; ReadData: %d", $time, WriteData, ReadData);
	   
	   // Report results
       if (passed == tests)
           $display("All tests passed.");
       else
           $display("%2d out of %2d test passed.", passed, tests);
       $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");

	end

endmodule


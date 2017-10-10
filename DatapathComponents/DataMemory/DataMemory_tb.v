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
    
    reg    [2:0]   passed;

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
	
        Address <= 32'b0;
        WriteData <= 32'b0;
        MemWrite <= 0;
        MemRead <= 0;
        passed <= 3'd0;
        #10;
        Address <= 32'd5;
        WriteData <= 32'd15;
        #10;
        MemWrite <= 1;
        #20;
        MemRead <= 1;
        #10;
        if (ReadData == WriteData)
            passed <= passed + 1;
        else
            $display("Memory read/write error; WriteDate: %d; ReadData: %d", WriteData, ReadData);
        #10;
        MemRead <= 0;
        @(posedge Clk);
        Address <= 32'd6;
        WriteData <= 32'd16;
        @(posedge Clk);
        Address <= 32'd7;
        @(posedge Clk);
        WriteData <= 32'd15;
        Address <= 32'd6;
        @(posedge Clk);
        MemRead <= 1;
        #10;
        if(WriteData == ReadData)
            passed = passed + 1;
        else
            $display("Memory overwrite error.");
        @(posedge Clk);
        MemRead <= 0;
        #5;
        if(ReadData == 32'b0)
            passed = passed + 1;
        else
            $display("ReadData update error, should be 0, instead is %d", ReadData);
         #20;
         Address <= 32'd8;
         WriteData <= 32'd17;
         @(posedge Clk);
         Address <= 32'd9;
         WriteData <= 32'd18;
         @(posedge Clk);
         Address <= 32'd10;
         WriteData <= 32'd19;
         @(posedge Clk);
         MemWrite <= 0;
         @(posedge Clk);
         Address <= 32'd6;
         MemRead <= 1;
         #10;
         if(ReadData == 32'd15)
            passed = passed + 1;
         else
            $display("Memory Read error after multiple writes.");
	end

endmodule


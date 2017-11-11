`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 

    localparam MEMORY_SIZE = 10; // MEMORY_SIZE of 30 => memory is [0:2**30], Indexed using Address[31:2]
    
    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    
    //reg [31:0] memory [0:2**MEMORY_SIZE]; //memory array
    reg [31:0] memory [0:1024];
    
    output reg[31:0] ReadData; // Contents of memory location at Address
    
    // setup initial memory
    initial begin
//        memory[0] = 32'd0;
//        memory[1] = 32'd1;
//        memory[2] = 32'd2;
//        memory[3] = 32'd3;
//        memory[4] = 32'd4;
//        memory[5] = -32'd1;
        memory[0] = 32'd100;
        memory[1] = 32'd200;
        memory[2] = 32'd300;
        memory[3] = 32'd400;
        memory[4] = 32'd500;
        memory[5] = 32'd600;
        memory[6] = 32'd700;
        memory[7] = 32'd800;
        memory[8] = 32'd900;
        memory[9] = 32'd1000;
        memory[10] = 32'd1100;
        memory[11] = 32'd1200;
    end

    always @(posedge Clk) begin
        if (MemWrite == 1)
            //memory[Address[MEMORY_SIZE+1:2]] <= WriteData;
            memory[Address[11:2]] <= WriteData;
    end
    
    always @(*) begin
        if (MemRead == 1)
            //ReadData <= memory[Address[MEMORY_SIZE+1:2]];
            ReadData <= memory[Address[11:2]];
        else
            ReadData <= 32'b0;
    end

endmodule

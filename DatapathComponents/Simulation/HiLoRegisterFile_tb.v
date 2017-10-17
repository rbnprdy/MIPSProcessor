`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 12:57:46 PM
// Design Name: 
// Module Name: HiLoRegisterFile_tb
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


module HiLoRegisterFile_tb();
    reg Clk, Madd, Msub, WriteEn;
    reg [31:0] WriteHiData;
    reg [31:0] WriteLoData;
    
    reg [31:0] HiReg;
    reg [31:0] LoReg;
    
    reg [63:0] TempReg;
    
    wire [31:0] ReadHi;
    wire [31:0] ReadLo;
    
    HiLoRegisterFile(
        .Clk(Clk),
        .WriteHiData(WriteHiData),
        .WriteLoData(WriteLoData),
        .ReadHi(ReadHi),
        .ReadLo(ReadLo),
        .Madd(Madd),
        .Msub(Msub),
        .WriteEn(WriteEn)
    );


endmodule

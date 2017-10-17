`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2017 03:46:38 PM
// Design Name: 
// Module Name: HiLoRegisterFile
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


module HiLoRegisterFile(
    Clk,
    WriteHiData,
    WriteLoData,
    ReadHi,
    ReadLo,
    Madd,
    Msub,
    WriteEn
);
    input Clk, Madd, Msub, WriteEn;
    input [31:0] WriteHiData;
    input [31:0] WriteLoData;
    
    reg [31:0] HiReg;
    reg [31:0] LoReg;
    
    reg [63:0] TempReg;
    
    output reg [31:0] ReadHi;
    output reg [31:0] ReadLo;
    
    initial begin
        HiReg <= 32'd0;
        LoReg <= 32'd0;
    end
    
    always @(posedge Clk) begin
        if (WriteEn) begin
            HiReg <= WriteHiData;
            LoReg <= WriteLoData;
        end
        if(Madd) begin
            HiReg <= HiReg + WriteHiData;
            LoReg <= LoReg + WriteLoData;
        end else if(Msub) begin
            HiReg <= HiReg - WriteHiData;
            LoReg <= LoReg - WriteLoData;
        end
    end

//    always @(posedge Clk, WriteEn) begin
//        if (WriteEn) begin
//            HiReg <= WriteHiData;
//            LoReg <= WriteLoData;
//        end
//        if(Madd) begin
//            TempReg = {HiReg, LoReg} + {WriteHiData, WriteLoData};
//            HiReg <= TempReg[63:33];
//            LoReg <= TempReg[32:0];
//        end else if(Msub) begin
//            TempReg = {HiReg, LoReg} - {WriteHiData, WriteLoData};
//            HiReg <= TempReg[63:33];
//            LoReg <= TempReg[32:0];
//        end
//    end
    
    always @(negedge Clk) begin
        ReadHi <= HiReg;
        ReadLo <= LoReg;
    end

endmodule
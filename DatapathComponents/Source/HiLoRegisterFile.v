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
    WriteEnHi,
    WriteEnLo
);
    input Clk, Madd, Msub, WriteEnHi, WriteEnLo;
    input signed [31:0] WriteHiData;
    input signed [31:0] WriteLoData;
    
    reg [31:0] HiReg;
    reg [31:0] LoReg;
    
    reg [63:0] TempReg;
    
    output reg signed [31:0] ReadHi;
    output reg signed [31:0] ReadLo;
    
    initial begin
        HiReg <= 32'd0;
        LoReg <= 32'd0;
        TempReg <= 64'd0;
    end

    always @(posedge Clk) begin
        if (WriteEnHi)
            HiReg <= WriteHiData;
        if (WriteEnLo)
            LoReg <= WriteLoData;
        if(Madd) begin
            TempReg = {HiReg, LoReg} + {WriteHiData, WriteLoData};
            HiReg <= TempReg[63:32];
            LoReg <= TempReg[31:0];
        end else if(Msub) begin
            TempReg = {HiReg, LoReg} - {WriteHiData, WriteLoData};
            HiReg <= TempReg[63:32];
            LoReg <= TempReg[31:0];
        end
    end
    
    always @(negedge Clk) begin
        ReadHi <= HiReg;
        ReadLo <= LoReg;
    end

endmodule
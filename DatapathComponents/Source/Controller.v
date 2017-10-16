`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2017 03:14:57 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
        Instruction, 
        PCSrc, 
        RegWrite, 
        ALUSrc, 
        InstructionToALU,
        RegDst,
        HiLoWrite, 
        Madd, 
        Msub, 
        MemWrite, 
        MemRead, 
        Branch,
        MemToReg, 
        HiOrLo, 
        HiToReg, 
        DontMove, 
        MoveOnNotZero
    );
    
    input [31:0] Instruction;
    output reg PCSrc, RegWrite, ALUSrc, RegDst, HiLoWrite, Madd, Msub, MemWrite, MemRead, Branch, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero;
    output reg [31:0] InstructionToALU;
    
    always@(Instruction) begin
        InstructionToALU <= Instruction; // Initialize OpCode and Function

        if (Instruction == 32'd0) begin // This is a nop
            PCSrc <= 1;
            RegWrite <= 0;
            Msub <= 0;
            Madd <= 0;
            HiLoWrite <= 0;
            MemWrite <= 0;
        end
        
        else begin
            case(Instruction[31:26])
                
                6'b000000 : begin // R-type instructions
                    PCSrc <= 0;
                    ALUSrc <= 0;
                    RegDst <= 1;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    if (Instruction[5:0] == 6'b011000 || Instruction[5:0] == 6'b011001) begin // mult or multu
                        RegWrite <= 0;
                        HiLoWrite <= 1;
                        DontMove <= 1;
                    end
                    else if (Instruction[5:0] == 6'b001011) begin // movn
                        RegWrite <= 1;
                        HiLoWrite <= 0;
                        DontMove <= 0;
                        MoveOnNotZero <= 1;
                    end
                    else if (Instruction[5:0] == 6'b001010) begin // movz
                        RegWrite <= 1;
                        HiLoWrite <= 0;
                        DontMove <= 0;
                        MoveOnNotZero <= 0;
                    end
                    else begin
                        RegWrite <= 1;
                        HiLoWrite <= 0;
                        DontMove <= 1;
                    end
                end
                
                6'b001000 : begin // Addi
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b001001 : begin // Addiu
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b001010 : begin // Slti
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b001011 : begin // Sltiu
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b001100 : begin // Andi
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b001101 : begin // Ori
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b001110 : begin // Xori
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiLoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b011100 : begin // Mul, Madd, or Msub
                    PCSrc <= 0;
                    ALUSrc <= 0;
                    HiLoWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    DontMove <= 1;
                    if (Instruction[5:0] == 6'b000010) begin // Mul
                        RegWrite <= 1;
                        RegDst <= 1;
                        Madd <= 0;
                        Msub <= 0;
                        MemToReg <= 1;
                        HiToReg <= 0;
                    end
                    if (Instruction[5:0] == 6'b000000) begin // Madd
                        RegWrite <= 0;
                        Madd <= 1;
                        Msub <= 0;
                    end
                    if (Instruction[5:0] == 6'b000100) begin // Msub
                        RegWrite <= 0;
                        Madd <= 0;
                        Msub <= 1;
                    end     
                end    
                
                6'b011111 : begin // Seb or Seh
                    if (Instruction[5:0] == 6'b100000) begin // Seb or Seh
                        PCSrc <= 0;
                        RegWrite <= 1;
                        ALUSrc <= 0;
                        RegDst <= 1;
                        HiLoWrite <= 0;
                        Madd <= 0;
                        Msub <= 0;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 0;
                        MemToReg <= 1;
                        HiToReg <= 0;
                        DontMove <= 1;
                    end
                end
            endcase
        end
    end 
endmodule

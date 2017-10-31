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
        HiWrite,
        LoWrite, 
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
    output reg PCSrc, RegWrite, ALUSrc, RegDst, HiWrite, LoWrite, Madd, Msub, MemWrite, MemRead, Branch, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero;
    output reg [31:0] InstructionToALU;
    
    always@(Instruction) begin
        InstructionToALU <= Instruction; // Initialize OpCode and Function

        if (Instruction == 32'd0) begin // This is a nop
            PCSrc <= 1;
            RegWrite <= 0;
            ALUSrc <= 0;
            RegDst <= 0;
            Msub <= 0;
            Madd <= 0;
            HiWrite <= 0;
            LoWrite <= 0;
            MemWrite <= 0;
            MemRead <= 0;
            Branch <= 0;
            MemToReg <= 0;
            HiOrLo <= 0;
            HiToReg <= 0;
            DontMove <= 1;
            MoveOnNotZero <= 0;
        end
        
        else begin
            case(Instruction[31:26])
                
                6'b000000 : begin // R-type instructions
                    PCSrc <= 0;
                    ALUSrc <= 0;
                    RegDst <= 1;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    if (Instruction[5:0] == 6'b010001) begin // mthi
                        RegWrite <= 0;
                        HiWrite <= 1;
                        LoWrite <= 0;
                        DontMove <= 1;
                    end
                    else if (Instruction[5:0] == 6'b010011) begin // mtlo
                        RegWrite <= 0;
                        HiWrite <= 0;
                        LoWrite <= 1;
                        DontMove <= 1;
                    end
                    else if (Instruction[5:0] == 6'b011000 || Instruction[5:0] == 6'b011001) begin // mult or multu
                        RegWrite <= 0;
                        HiWrite <= 1;
                        LoWrite <= 1;
                        DontMove <= 1;
                    end
                    else if (Instruction[5:0] == 6'b010010) begin // mflo
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiOrLo <= 0;
                        HiToReg <= 1;
                        DontMove <= 1;
                    end
                    else if (Instruction[5:0] == 6'b010000) begin // mfhi
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiOrLo <= 1;
                        HiToReg <= 1;
                        DontMove <= 1;
                    end
                    else if (Instruction[5:0] == 6'b001010) begin // movz
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiToReg <= 0;
                        DontMove <= 0;
                        MoveOnNotZero <= 0;
                    end
                    else if (Instruction[5:0] == 6'b001011) begin // movn
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiToReg <= 0;
                        DontMove <= 0;
                        MoveOnNotZero <= 1;
                    end
                    else begin
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiToReg <= 0;
                        DontMove <= 1;
                    end
                end
                
                6'b000001, // bgez or bltz
                6'b000111, // bgtz
                6'b000110, // blez
                6'b000100, // beq
                6'b000101: begin // bne
                    PCSrc <= 1;
                    RegWrite <= 0;
                    ALUSrc <= 0;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 1;
                end
                
                6'b001000, // addi
                6'b001001, // addiu
                6'b001010, // slti
                6'b001011, // sltiu
                6'b001100, // andi
                6'b001101, // ori
                6'b001110, // xori
                6'b001111: begin // lui
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b011100 : begin // madd, msub, mul
                    PCSrc <= 0;
                    ALUSrc <= 0;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    DontMove <= 1;
                    if (Instruction[5:0] == 6'b000000) begin // madd
                       RegWrite <= 0; 
                       Madd <= 1;
                       Msub <= 0;
                    end
                    else if (Instruction[5:0] == 6'b000100) begin // msub
                        RegWrite <= 0;
                        Madd <= 0;
                        Msub <= 1;
                    end
                    else begin // mul
                        RegWrite <= 1;
                        RegDst <= 1;
                        Madd <= 0;
                        Msub <= 0;
                        MemToReg <= 1;
                        HiToReg <= 0;
                    end
                end
                
                6'b011111 : begin // seb, seh
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 0;
                    RegDst <= 1;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b100000, // lb
                6'b100001, // lh
                6'b100011 : begin // lw
                    PCSrc <= 0;
                    RegWrite <= 1;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 1;
                    Branch <= 0;
                    MemToReg <= 0;
                    HiToReg <= 0;
                    DontMove <= 1;
                end
                
                6'b101000, // sb
                6'b101001, // sh
                6'b101011 : begin // sw
                    PCSrc <= 0;
                    RegWrite <= 0;
                    ALUSrc <= 1;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 1;
                    MemRead <= 0;
                    Branch <= 0;
                end
            endcase
        end
    end 
endmodule

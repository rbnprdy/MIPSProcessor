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
        RegWrite, 
        ALUSrc, 
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
        MoveOnNotZero,
        Jump,
        JumpAndLink,
        Lb,
        LoadExtended
    );
    
    input [31:0] Instruction;
    output reg RegWrite, ALUSrc, RegDst, HiWrite, LoWrite, Madd, Msub, MemWrite, MemRead, Branch, MemToReg, HiOrLo, HiToReg, DontMove, MoveOnNotZero, Jump, JumpAndLink, Lb, LoadExtended;
    
    always@(Instruction) begin

        if (Instruction == 32'd0) begin // This is a nop
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
            Jump <= 0;
            JumpAndLink <= 0;
            Lb <= 0;
            LoadExtended <= 0;
        end
        
        else begin
            case(Instruction[31:26])
                
                6'b000000 : begin // R-type instructions
                    ALUSrc <= 0;
                    RegDst <= 1;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    JumpAndLink <= 0;
                    LoadExtended <= 0;
                    if (Instruction[5:0] == 6'b010001) begin // mthi
                        RegWrite <= 0;
                        HiWrite <= 1;
                        LoWrite <= 0;
                        HiOrLo <= 0;
                        HiToReg <= 0;
                        DontMove <= 1;
                        MoveOnNotZero <= 0;
                        Jump <= 0;
                        Lb <= 0;
                    end
                    else if (Instruction[5:0] == 6'b010011) begin // mtlo
                        RegWrite <= 0;
                        HiWrite <= 0;
                        LoWrite <= 1;
                        HiOrLo <= 0;
                        HiToReg <= 0;
                        DontMove <= 1;
                        MoveOnNotZero <= 0;
                        Jump <= 0;
                        Lb <= 0;
                    end
                    else if (Instruction[5:0] == 6'b011000 || Instruction[5:0] == 6'b011001) begin // mult or multu
                        RegWrite <= 0;
                        HiWrite <= 1;
                        LoWrite <= 1;
                        HiOrLo <= 0;
                        HiToReg <= 0;
                        DontMove <= 1;
                        MoveOnNotZero <= 0;
                        Jump <= 0;
                        Lb <= 0;
                    end
                    else if (Instruction[5:0] == 6'b010010) begin // mflo
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiOrLo <= 0;
                        HiToReg <= 1;
                        DontMove <= 1;
                        MoveOnNotZero <= 0;
                        Jump <= 0;
                        Lb <= 0;
                    end
                    else if (Instruction[5:0] == 6'b010000) begin // mfhi
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiOrLo <= 1;
                        HiToReg <= 1;
                        DontMove <= 1;
                        MoveOnNotZero <= 0;
                        Jump <= 0;
                        Lb <= 0;
                    end
                    else if (Instruction[5:0] == 6'b001010) begin // movz
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiOrLo <= 0;
                        HiToReg <= 0;
                        DontMove <= 0;
                        MoveOnNotZero <= 0;
                        Jump <= 0;
                        Lb <= 0;
                    end
                    else if (Instruction[5:0] == 6'b001011) begin // movn
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiOrLo <= 0;
                        HiToReg <= 0;
                        DontMove <= 0;
                        MoveOnNotZero <= 1;
                        Jump <= 0;
                        Lb <= 0;
                    end
                    else if (Instruction[5:0] == 6'b001000) begin // jr
                        RegWrite <= 0;
                        HiWrite <=0;
                        LoWrite <= 0;
                        HiOrLo <= 0;
                        HiToReg <= 0;
                        DontMove <= 0;
                        MoveOnNotZero <= 1;
                        Jump <= 1;
                        Lb <= 0;
                    end
                    else begin
                        RegWrite <= 1;
                        HiWrite <= 0;
                        LoWrite <= 0;
                        HiOrLo <= 0;
                        HiToReg <= 0;
                        DontMove <= 1;
                        MoveOnNotZero <= 1;
                        Jump <= 0;
                        Lb <= 0;
                    end
                end
                
                6'b000001, // bgez or bltz
                6'b000111, // bgtz
                6'b000110, // blez
                6'b000100, // beq
                6'b000101: begin // bne
                    RegWrite <= 0;
                    ALUSrc <= 0;
                    RegDst <= 0;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 1;
                    MemToReg <= 0;
                    HiOrLo <= 0;
                    HiToReg <= 0;
                    DontMove <= 0;
                    MoveOnNotZero <= 0;
                    Jump <= 0;
                    JumpAndLink <= 0;
                    Lb <= 0;
                    LoadExtended <= 0;
                end
                
                6'b001000, // addi
                6'b001001, // addiu
                6'b001010, // slti
                6'b001011, // sltiu
                6'b001100, // andi
                6'b001101, // ori
                6'b001110, // xori
                6'b001111: begin // lui
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
                    HiOrLo <= 0;
                    HiToReg <= 0;
                    DontMove <= 1;
                    MoveOnNotZero <= 0;
                    Jump <= 0;
                    JumpAndLink <= 0;
                    Lb <= 0;
                    LoadExtended <= 0;
                end
                
                6'b011100 : begin // madd, msub, mul
                    ALUSrc <= 0;
                    RegDst <= 1;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 1;
                    HiOrLo <= 0;
                    HiToReg <= 0;
                    DontMove <= 1;
                    MoveOnNotZero <= 0;
                    Jump <= 0;
                    JumpAndLink <= 0;
                    Lb <= 0;
                    LoadExtended <= 0;
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
                        Madd <= 0;
                        Msub <= 0;
                    end
                end
                
                6'b011111 : begin // seb, seh
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
                    HiOrLo <= 0;
                    HiToReg <= 0;
                    DontMove <= 1;
                    MoveOnNotZero <= 0;
                    Jump <= 0;
                    JumpAndLink <= 0;
                    Lb <= 0;
                    LoadExtended <= 0;
                end
                
                6'b100000, // lb
                6'b100001, // lh
                6'b100011 : begin // lw
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
                    HiOrLo <= 0;
                    HiToReg <= 0;
                    DontMove <= 1;
                    MoveOnNotZero <= 0;
                    Jump <= 0;
                    JumpAndLink <= 0;
                    if (Instruction[31:26] == 6'b100000) begin // lb
                        Lb <= 1;
                        LoadExtended <= 1;
                    end
                    else if (Instruction[31:26] == 6'b100001) begin // lh
                        Lb <= 0; 
                        LoadExtended <= 1;
                    end
                    else begin // if (Instruction[31:26] == 6'b100011) begin // lw
                        Lb <= 0;
                        LoadExtended <= 0;
                    end
                end
                
                6'b101000, // sb
                6'b101001, // sh
                6'b101011 : begin // sw
                    RegWrite <= 0;
                    ALUSrc <= 1;
                    RegDst <= 0;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 1;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 0;
                    HiOrLo <= 0;
                    HiToReg <= 0;
                    DontMove <= 0;
                    MoveOnNotZero <= 0;
                    Jump <= 0;
                    JumpAndLink <= 0;
                    Lb <= 0;
                    LoadExtended <= 0;
                end
                
                6'b000011, // jal
                6'b000010 : begin // j
                    ALUSrc <= 0;
                    RegDst <= 0;
                    HiWrite <= 0;
                    LoWrite <= 0;
                    Madd <= 0;
                    Msub <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    Branch <= 0;
                    MemToReg <= 0;
                    HiOrLo <= 0;
                    HiToReg <= 0;
                    MoveOnNotZero <= 0;
                    Jump <= 1;
                    Lb <= 0;
                    LoadExtended <= 0;
                    if (Instruction[31:26] == 6'b000010) begin// j
                        DontMove <= 0;
                        JumpAndLink <= 0;
                        RegWrite <= 0;
                    end
                    else begin // jal
                        DontMove <= 1;
                        JumpAndLink <= 1;
                        RegWrite <= 1;
                    end
                end
                default : begin
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
                    Jump <= 0;
                    JumpAndLink <= 0;
                    Lb <= 0;
                    LoadExtended <= 0;
                end
            endcase
        end
    end 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2017 01:48:19 PM
// Design Name: 
// Module Name: HazardDetectionUnit
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


module HazardDetectionUnit(Rs_ID, Rt_ID, Rt_EX, Instruction_31_26, Instruction_5_0, MemRead_EX, PCWrite, IF_ID_Write, FlushControl, RegWrite_Ex, MemRead_Mem, Rd_Mem, Rd_Ex, Branch_Ex, Jump_Ex);
    input [4:0] Rs_ID, Rt_ID, Rt_EX, Rd_Mem, Rd_Ex;
    input [5:0] Instruction_31_26, Instruction_5_0;
    input MemRead_EX, RegWrite_Ex, MemRead_Mem, Branch_Ex, Jump_Ex;
    
    output reg PCWrite, IF_ID_Write, FlushControl;
    
    always@(*) begin
        // Flush
        if ((Branch_Ex == 1) || (Jump_Ex == 1)) begin
            PCWrite <= 1;
            IF_ID_Write <= 1;
            FlushControl <= 1;
        end
        // lw followed by r-type
        else if ((MemRead_EX == 1) && (Instruction_31_26 != 6'b101000) && (Instruction_31_26 != 6'b101001) && (Instruction_31_26 != 6'b101011) && (Instruction_31_26 != 6'b100000) && (Instruction_31_26 != 6'b100001) && (Instruction_31_26 != 6'b100011) && ((Rt_EX == Rs_ID) || (Rt_EX == Rt_ID))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            
            FlushControl <= 1;
        end
        // lw followed by sw, sh, or sb, or lw, lh, lb where lw.rt == sw.rs/lw.rs
        else if ((MemRead_EX == 1) && ((Instruction_31_26 == 6'b101000) || (Instruction_31_26 == 6'b101001) || (Instruction_31_26 == 6'b101011) || (Instruction_31_26 == 6'b100000) || (Instruction_31_26 == 6'b100001) || (Instruction_31_26 == 6'b100011)) && (Rt_EX == Rs_ID)) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end 
        // bgez immediately after add
        else if (((Instruction_31_26 == 6'b000001) || (Instruction_31_26 == 6'b000010) || (Instruction_31_26 == 6'b000011) || (Instruction_31_26 == 6'b000100) || (Instruction_31_26 == 6'b000101) || (Instruction_31_26 == 6'b000110) || (Instruction_31_26 == 6'b000111)) && (RegWrite_Ex == 1) && ((Rs_ID == Rd_Ex) || (Rt_ID == Rd_Ex))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        // bgez immediately after lw
        else if (((Instruction_31_26 == 6'b000001) || (Instruction_31_26 == 6'b000010) || (Instruction_31_26 == 6'b000011) || (Instruction_31_26 == 6'b000100) || (Instruction_31_26 == 6'b000101) || (Instruction_31_26 == 6'b000110) || (Instruction_31_26 == 6'b000111)) && (MemRead_EX == 1) && ((Rs_ID == Rd_Ex) || (Rt_ID == Rd_Ex))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        // bgez after lw with one stall cycle in between
        else if (((Instruction_31_26 == 6'b000001) || (Instruction_31_26 == 6'b000010) || (Instruction_31_26 == 6'b000011) || (Instruction_31_26 == 6'b000100) || (Instruction_31_26 == 6'b000101) || (Instruction_31_26 == 6'b000110) || (Instruction_31_26 == 6'b000111)) && (MemRead_Mem == 1) && ((Rs_ID == Rd_Mem) || (Rt_ID == Rd_Mem))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        // jr after r-type
        else if ((Instruction_31_26 == 6'b000000) && (Instruction_5_0 == 6'b001000) && (Rd_Ex == Rs_ID) && (RegWrite_Ex == 1)) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        // jr after lw
        else if ((Instruction_31_26 == 6'b000000) && (Instruction_5_0 == 6'b001000) && (Rt_EX == Rs_ID) && (MemRead_EX == 1)) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        // jr after lw with one stall cycle in between
        else if ((Instruction_31_26 == 6'b000000) && (Instruction_5_0 == 6'b001000) && (Rd_Mem == Rs_ID) && (MemRead_Mem == 1)) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        else begin
            PCWrite <= 1;
            IF_ID_Write <= 1;
            FlushControl <= 0;
        end
    end
endmodule

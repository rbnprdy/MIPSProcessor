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


module HazardDetectionUnit(Rs_ID, Rt_ID, Rt_EX, Instruction_31_26, MemRead_EX, PCWrite, IF_ID_Write, FlushControl, RegWrite_Ex, Branch, MemRead_Mem, Rd_Mem, Rd_Ex);
    input [4:0] Rs_ID, Rt_ID, Rt_EX, Rd_Mem, Rd_Ex;
    input [5:0] Instruction_31_26;
    input MemRead_EX, RegWrite_Ex, Branch, MemRead_Mem;
    
    output reg PCWrite, IF_ID_Write, FlushControl;
    
    always@(*) begin
        // lw followed by r-type
        if ((MemRead_EX == 1) && (Instruction_31_26 != 6'b101000) && (Instruction_31_26 != 6'b101001) && (Instruction_31_26 != 6'b101011) && (Instruction_31_26 != 6'b100000) && (Instruction_31_26 != 6'b100001) && (Instruction_31_26 != 6'b100011) && ((Rt_EX == Rs_ID) || (Rt_EX == Rt_ID))) begin
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
        else begin
            PCWrite <= 1;
            IF_ID_Write <= 1;
            FlushControl <= 0;
        end
        // bgez immediately after add
        if ((RegWrite_Ex == 1) && (Branch == 1) && ((Rs_ID == Rd_Ex) || (Rt_ID == Rd_Ex))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        // bgez immediately after lw
        if ((MemRead_EX == 1) && (Branch == 1) && ((Rs_ID == Rd_Ex) || (Rt_ID == Rd_Ex))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
        // bgez after lw with one stall cycle
        if ((MemRead_Mem == 1) && (Branch == 1) && ((Rs_ID == Rd_Mem) || (Rt_ID == Rd_Mem))) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            FlushControl <= 1;
        end
    end
endmodule

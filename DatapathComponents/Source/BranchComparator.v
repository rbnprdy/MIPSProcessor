`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2017 10:34:28 AM
// Design Name: 
// Module Name: BranchComparator
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


module BranchComparator(ReadData1, ReadData2, OpCode, Instruction_20_16, Out);
    input [31:0] ReadData1, ReadData2;
    input [5:0] OpCode;
    input [4:0] Instruction_20_16;
    output reg Out;
    
    always@(*) begin
        // beq
        if (OpCode == 6'b000100) begin
            if (ReadData1 == ReadData2)
                Out <= 1;
            else
                Out <= 0;
        end
        // bne
        else if (OpCode == 6'b000101) begin
            if (ReadData1 == ReadData2)
                Out <= 1;
            else
                Out <= 0;
        end
        // blez
        else if (OpCode == 6'b000110) begin
            if ($signed(ReadData1) <= $signed(32'd0))
                Out <= 1;
            else
                Out <= 0;
        end
        // bgtz
        else if (OpCode == 6'b000111) begin
            if ($signed(ReadData1) > $signed(32'd0))
                Out <= 1;
            else
                Out <= 0;
        end
        // bltz or bgez
        else if (OpCode == 6'b000001) begin
            // bltz
            if (Instruction_20_16 == 5'd0) begin
                if ($signed(ReadData1) < $signed(32'd0))
                    Out <= 1;
                else
                    Out <= 0;
            end
            // bgez
            else if (Instruction_20_16 == 5'b00001) begin
                if ($signed(ReadData1) >= $signed(32'd0))
                    Out <= 1;
                else
                    Out <= 0;
            end
            else begin
                Out <= 0;
            end
        end
        // default
        else
            Out <= 0;
    end

endmodule

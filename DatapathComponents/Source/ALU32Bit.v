`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 0010
// SUB  | 0110
// AND  | 0000
// OR   | 0001
// SLT  | 0111
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ShiftAmount, ALUResult, HiResult, Zero);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input [4:0] ShiftAmount;

	output reg signed [31:0] ALUResult, HiResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	reg signed [63:0] TempResult;
	reg [31:0] temp1, temp2;
	integer i;

    /* Please fill in the implementation here... */
    always@(ALUControl, A, B, ShiftAmount) begin
        case(ALUControl)
            5'b00000 : ALUResult <= $signed(A) + $signed(B); // Add
            5'b00001 : ALUResult <= $signed(A) - $signed(B); // Subtract
            5'b00010 : begin // Multiply
                TempResult = $signed(A) * $signed(B);
                ALUResult <= TempResult[31:0];
                HiResult <= TempResult[63:32];
            end
            5'b00011 : ALUResult <= A & B; // And
            5'b00100 : ALUResult <= A | B; // Or
            5'b00101 : ALUResult <= A ^ B; // Xor
            5'b00110 : ALUResult <= ~(A | B); // Nor
            5'b00111 : ALUResult <= B << ShiftAmount; // Sll
            5'b01000 : ALUResult <= B >> ShiftAmount; // Srl
            5'b01001 : begin // Rotate Right
                    temp1 = B >> ShiftAmount;
                    temp2 = B << (32 - ShiftAmount);
                    ALUResult <= temp1 | temp2;
            end
            5'b01010 : ALUResult <= $signed(B) >>> ShiftAmount; // Sra
            5'b01011 : ALUResult <= { {16{B[15]}}, B[15:0] }; // Sign-extend half word
            5'b01100 : ALUResult <= A + B; // Add Unsigned
            5'b01101 : begin // Multiply Unsigned
                TempResult = A * B;
                ALUResult <= TempResult[31:0];
                HiResult <= TempResult[63:32];
            end
            5'b01110 : ALUResult <= $signed(A) < $signed(B); // Slt
            5'b01111 : ALUResult <= { {24{B[7]}}, B[7:0] }; // Sign-extend byte
            5'b10000 : ALUResult <= A < B; // Slt Unsigned
            5'b10001 : ALUResult <= B << A; //Shift Left logical variable
            5'b10010 : ALUResult <= B >> A; //Shift Right Logical variable
            5'b10011 : ALUResult <= $signed(B) >>> A; //Shift Right Arithmetic Variable
            5'b10100 : begin //Rotate Right logical Variable
                temp1 = B >> A;
                temp2 = B << (32 - A);
                ALUResult <= temp1 | temp2;
            end
            5'b10101 : begin
                ALUResult <= A;
                HiResult <= A; //Move
            end
            5'b10110 : ALUResult <= B << 16; // SLL 16 B (for LUI)
            5'b10111 : begin // A < 0
                if ($signed(A) < 0)
                    ALUResult <= 0;
                else
                    ALUResult <= 1;
            end
            5'b11000 : begin // A <= 0
                if ($signed(A) <= 0)
                    ALUResult <= 0;
                else
                    ALUResult <= 1;
            end
            5'b11001 : begin // A > 0
                if ($signed(A) > 0)
                    ALUResult <= 0;
                else
                    ALUResult <= 1;
            end
            5'b11010 : begin // A >= 0
                if ($signed(A) >= 0)
                    ALUResult <= 0;
                else
                    ALUResult <= 1;
            end
            default : ALUResult <= 1; // Default
        endcase
    end
    
    always@(ALUResult) begin
        if (ALUResult == 0)
            Zero <= 1;
        else
            Zero <= 0;
    end

endmodule


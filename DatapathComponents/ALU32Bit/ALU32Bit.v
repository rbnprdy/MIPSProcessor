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

module ALU32Bit(ALUControl, A, B, ALUResult, HiResult, Zero);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs

	output reg signed [31:0] ALUResult, HiResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	reg signed [63:0] TempResult;
	integer i;

    /* Please fill in the implementation here... */
    always@(ALUControl, A, B) begin
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
            5'b00111 : ALUResult <= A << B; // Sll
            5'b01000 : ALUResult <= A >> B; // Srl
            5'b01001 : begin // Rotate Right
                ALUResult = A;
                for (i = 0; i < B; i = i + 1) begin // Rotate Right once B times
                    ALUResult = { ALUResult[0], ALUResult[31:1] };
                end  
            end
            5'b01010 : ALUResult <= $signed(A) >>> B; // Sra
            5'b01011 : ALUResult <= { {16{A[15]}}, A[15:0] }; // Sign-extend half word
            5'b01100 : ALUResult <= A + B; // Add Unsigned
            5'b01101 : begin // Multiply Unsigned
                TempResult = A * B;
                ALUResult <= TempResult[31:0];
                HiResult <= TempResult[63:32];
            end
            5'b01110 : ALUResult <= $signed(A) < $signed(B); // Slt
            5'b01111 : ALUResult <= { {24{A[7]}}, A[7:0] }; // Sign-extend byte
            5'b10000 : ALUResult <= A < B; // Slt Unsigned
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


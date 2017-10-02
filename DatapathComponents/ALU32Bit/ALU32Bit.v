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

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs

	output reg [63:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	integer i;

    /* Please fill in the implementation here... */
    always@(ALUControl, A, B) begin
        case(ALUControl)
            4'b0000 : ALUResult <= A + B; // Add
            4'b0001 : ALUResult <= A - B; // Subtract
            4'b0010 : ALUResult <= A * B; // Multiply
            4'b0011 : ALUResult <= A & B; // And
            4'b0100 : ALUResult <= A | B; // Or
            4'b0101 : ALUResult <= A ^ B; // Xor
            4'b0110 : ALUResult <= ~(A | B); // Nor
            4'b0111 : ALUResult <= A << B; // Sll
            4'b1000 : ALUResult <= A >> B; // Srl
            4'b1001 : begin // Rotate Right
                ALUResult <= A;
                for (i = 0; i < B; i = i + 1) begin // Rotate Right once B times
                    ALUResult <= { ALUResult[0], ALUResult[31:1] };
                end  
            end
            4'b1010 : ALUResult <= A >>> B; // Sra
            4'b1011 : ALUResult <= { {16{A[15]}}, A[15:0] }; // FIXME: Sign-extend half word
            4'b1100 : ALUResult <= 1; // FIXME: Madd
            4'b1101 : ALUResult <= 1; // FIXME: Msub
            4'b1110 : ALUResult <= A < B; // Slt
            4'b1111 : ALUResult <= { {24{A[7]}}, A[7:0] }; // Sign-extend byte
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


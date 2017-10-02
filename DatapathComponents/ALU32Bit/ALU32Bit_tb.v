`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
        ALUControl <= 0;
        A <= 4'd0;
        B <= 4'd0;
        #5;
        A <= 32'd12;
        B <= 32'd10;
        #5;
        ALUControl <= 4'b0001;
        #5;
        ALUControl <= 4'b0010;
        #5;
        ALUControl <= 4'b0011;
        A <= 32'd1;
        B <= 32'd5;
        #5;
        ALUControl <= 4'b0100;
        #5;
        ALUControl <= 4'b0101;
        #5;
        ALUControl <= 4'b0110;
        #5;
        ALUControl <= 4'b0111;
        A <= 32'd8;
        B <= 32'd2;
        #5;
        ALUControl <= 4'b1000;
        #5;
	
	end
endmodule


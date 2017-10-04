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
        #5; //testing Add
        A <= 32'd12;
        B <= 32'd10;
        #5; //testing Subtract
        ALUControl <= 4'b0001;
        #5; //testing Multiply
        ALUControl <= 4'b0010;
        #5; //testing And
        ALUControl <= 4'b0011;
        A <= 32'd1;
        B <= 32'd5;
        #5; //testing Or
        ALUControl <= 4'b0100;
        #5; //testing Xor
        ALUControl <= 4'b0101;
        #5; //testing Nor
        ALUControl <= 4'b0110;
        #5; //testing Shift left logical
        ALUControl <= 4'b0111;
        A <= 32'd8;
        B <= 32'd2;
        #5; //testing Shift Right Logical
        ALUControl <= 4'b1000;
        #5; //testing Rotate Right FIXME
        A <= 32'd1;
        ALUControl <= 4'b1001;
        #5; //testing Shift Right Arithmetic
        A <= 32'b11110000111100001111000011110000;
        ALUControl <= 4'b1010;
        #5; //testing Sign-Extend (negative)
        A <= 16'b1000000000011000;
        ALUControl <= 4'b1011;
        #5; //testing Sign-Extend (positive)
        A <= 16'b000000000001100;
        #5; //testing MAdd
        A <= 32'd8;
        B <= 32'd10;
        ALUControl <= 4'b1100;
        #5; //testing MSub
        ALUControl <= 4'b1101;
        #5; //testing Set if Less Than (false)
        ALUControl <= 4'b1110;
        #5; //testing Set if Less Than (true)
        A <= 32'd12;
        #5; // testing Sign-Extend Byte (negative)
        A <= 8'b10001100;
        ALUControl <= 4'b1111;
        #5; //testing Sign-Extend Byte (positive)
        A <= 8'b00001100;
	
	end
endmodule


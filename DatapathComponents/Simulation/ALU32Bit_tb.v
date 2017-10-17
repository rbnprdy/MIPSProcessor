`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [4:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs
	reg [3:0] ShiftAmount;

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0
	
	integer tests;
	integer passed;

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ShiftAmount(ShiftAmount),
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

    initial begin
        // Initial Assigments
        tests <= 0;
        passed <= 0;
        ALUControl <= 0;
        A <= 4'd0;
        B <= 4'd0;
        $display("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("Starting Unit Tests.");
        
        #5; // Test Add #1
        ALUControl <= 5'b00000;
        tests = tests + 1;
        A <= 32'd12;
        B <= 32'd10;
        #5 if(ALUResult == 32'd22)
            passed = passed + 1;
        else
            $display("Add #1 Test Failed. Expected: 22. Actual: %d", ALUResult);
        #5; // Test Add #2
        tests = tests + 1;
        A <= 32'd0;
        B <= 32'd0;
        #5 if(ALUResult == 32'd0)
            passed = passed + 1;
        else
            $display("Add #2 Test Failed. Expected: 0. Actual: %d", ALUResult);
        #5; // Test Add #3
        tests = tests + 1;
        #5 if(Zero == 1'd1)
            passed = passed + 1;
        else
            $display("Add #3 Test Failed. Expected: 1. Actual: %d", Zero);
        #5; // Test Add #4
        tests = tests + 1;
        A <= -32'd12;
        B <= 32'd10;
        #5 if(ALUResult == -32'd2)
            passed = passed + 1;
        else
            $display("Add #4 Test Failed. Expected: -2. Actual: %d", ALUResult);
        #5; // Test Add #5
        tests = tests + 1;
        A <= 32'b1001;
        B <= 32'd0001;
        #5 if(ALUResult == 32'b1010)
            passed = passed + 1;
        else
            $display("Add #5 Test Failed. Expected: 1010. Actual: %b", ALUResult);        
        
        ALUControl <= 5'b00001;
        #5; // Test Subtract #1
        tests = tests + 1;
        A <= 32'd12;
        B <= 32'd10;
        #5 if(ALUResult == 32'd2)
            passed = passed + 1;
        else
            $display("Subtract #1 Test Failed. Expected: 2. Actual: %d", ALUResult);
        #5; // Test Subtract #2
        tests = tests + 1;
        A <= 32'd10;
        B <= 32'd12;
        #5 if(ALUResult == -32'd2)
            passed = passed + 1;
        else
            $display("Subtract #2 Test Failed. Expected: -2. Actual: %d", ALUResult);
        #5; // Test Subtract #3
        tests = tests + 1;
        A <= 32'd12;
        B <= -32'd10;
        #5 if(ALUResult == 32'd22)
            passed = passed + 1;
        else
            $display("Subtract #3 Test Failed. Expected: 22. Actual: %d", ALUResult);
        #5; // Test Subtract #4
        tests = tests + 1;
        A <= 32'b1010;
        B <= 32'b0010;
        #5 if(ALUResult == 32'b1000)
            passed = passed + 1;
        else
            $display("Subtract #4 Test Failed. Expected: 1000. Actual: %b", ALUResult);
                
        #5; // Test Multiply #1
        ALUControl <= 5'b00010;
        tests = tests + 1;
        A <= 32'd5;
        B <= 32'd7;
        #5 if(ALUResult == 32'd35)
            passed = passed + 1;
        else
            $display("Multiply #1 Test Failed. Expected: 35. Actual: %d", ALUResult);
        #5; // Test Multiply #2  
        tests = tests + 1;      
        A <= -32'd4;
        B <= 32'd3;
        #5 if(ALUResult == -32'd12)
            passed = passed + 1;
        else
            $display("Multiply #2 Test Failed. Expected: -12. Actual: %d", ALUResult);
        #5; // Test Multiply #3  
        tests = tests + 1;     
        A <= 32'd4;
        B <= -32'd3;
        #5 if(ALUResult == -32'd12)
            passed = passed + 1;
        else
            $display("Multiply #3 Test Failed. Expected: -12. Actual: %d", ALUResult);
        #5; // Test Multiply #4 
        tests = tests + 1;       
        A <= -32'd4;
        B <= -32'd3;
        #5 if(ALUResult == 32'd12)
            passed = passed + 1;
        else
            $display("Multiply #4 Test Failed. Expected: 12. Actual: %d", ALUResult);
        #5; // Test Multiply #5    
        tests = tests + 1;    
        A <= 32'b1001;
        B <= 32'b0111;
        #5 if(ALUResult == 32'b111111)
            passed = passed + 1;
        else
            $display("Multiply #5 Test Failed. Expected: 111111. Actual: %b", ALUResult);
        
        #5; // Test And #1
        ALUControl <= 5'b00011; 
        tests = tests + 1;       
        A <= 32'b1010;
        B <= 32'b0110;
        #5 if(ALUResult == 32'b0010)
            passed = passed + 1;
        else
            $display("And #1 Test Failed. Expected: 0010. Actual: %b", ALUResult);

        #5; // Test Or #1
        ALUControl <= 5'b00100;
        tests = tests + 1;       
        A <= 32'b1010;
        B <= 32'b0110;
        #5 if(ALUResult == 32'b1110)
            passed = passed + 1;
        else
            $display("Or #1 Test Failed. Expected: 1110. Actual: %b", ALUResult);

        #5; // Test Xor #1
        ALUControl <= 5'b00101;
        tests = tests + 1;       
        A <= 32'b1010;
        B <= 32'b0110;
        #5 if(ALUResult == 32'b1100)
            passed = passed + 1;
        else
            $display("Test Xor #1 Test Failed. Expected: 1100. Actual: %b", ALUResult);

        #5; // Test Nor #1
        ALUControl <= 5'b00110;
        tests = tests + 1;       
        A <= 32'b1010;
        B <= 32'b0110;
        #5 if(ALUResult == 32'b11111111111111111111111111110001)
            passed = passed + 1;
        else
            $display("Nor #1 Test Failed. Expected: 11111111111111111111111111110001. Actual: %b", ALUResult);

        #5; // Test Shift Left Logical #1
        ALUControl <= 5'b00111;
        tests = tests + 1;       
        B <= 32'b001010;
        ShiftAmount <= 32'd2;
        #5 if(ALUResult == 32'b101000)
            passed = passed + 1;
        else
            $display("Shift Left Logical #1 Test Failed. Expected: 101000. Actual: %b", ALUResult);

        #5; // Test Shift Right Logical #1
        ALUControl <= 5'b01000;
        tests = tests + 1;       
        B <= 32'b11010;
        ShiftAmount <= 32'd2;
        #5 if(ALUResult == 32'b00110)
            passed = passed + 1;
        else
            $display("Shift Right Logical #1 Test Failed. Expected: 101000. Actual: %b", ALUResult);

        #5; // Test Rotate Right #1
        ALUControl <= 5'b01001;
        tests = tests + 1;       
        B <= 32'b10110100000000000000000000000010;
        ShiftAmount <= 32'd2;
        #5 if(ALUResult == 32'b10101101000000000000000000000000)
            passed = passed + 1;
        else
            $display("Rotate Right #1 Test Failed. Expected: 10101101000000000000000000000000. Actual: %b", ALUResult);

        #5; // Test Shift Right Arithmetic #1
        ALUControl <= 5'b01010;
        tests = tests + 1;       
        B <= 32'b10110100000000000000000000000010;
        ShiftAmount <= 32'd2;
        #5 if(ALUResult == 32'b11101101000000000000000000000000)
            passed = passed + 1;
        else
            $display("Shift Right Arithmetic #1 Test Failed. Expected: 11101101000000000000000000000000. Actual: %b", ALUResult);
        
        #5; // Test Shift Right Arithmetic #2
        tests = tests + 1;       
        B <= 32'b00110100000000000000000000000010;
        ShiftAmount <= 32'd2;
        #5 if(ALUResult == 32'b00001101000000000000000000000000)
            passed = passed + 1;
        else
            $display("Shift Right Arithmetic #2 Test Failed. Expected: 00001101000000000000000000000000. Actual: %b", ALUResult);

        #5; // Test Sign-Extend Half-Word #1
        ALUControl <= 5'b01011;
        tests = tests + 1;       
        B <= 32'b0110001111000100;
        #5 if(ALUResult == 32'b00000000000000000110001111000100)
            passed = passed + 1;
        else
            $display("Sign-Extend Half-Word #1 Test Failed. Expected: 00000000000000000110001111000100. Actual: %b", ALUResult);
        #5; //testing Sign-Extend Half-Word #2
        tests = tests + 1;       
        B <= 32'b1110001111000100;
        #5 if(ALUResult == 32'b11111111111111111110001111000100)
            passed = passed + 1;
        else
            $display("Sign-Extend Half-Word #2 Test Failed. Expected: 11111111111111110110001111000100. Actual: %b", ALUResult);
        
        #5; // Test Unsigned Add #1
        ALUControl <= 5'b01100;
        tests = tests + 1;
        A <= 32'd12;
        B <= 32'd10;
        #5 if(ALUResult == 32'd22)
            passed = passed + 1;
        else
            $display("Unsigned Add #1 Test Failed. Expected: 22. Actual: %d", ALUResult);
       
        #5; // Test Unsigned Multiply #1
        ALUControl <= 5'b01101;
        tests = tests + 1;
        A <= 32'd3;
        B <= 32'd4;
        #5 if(ALUResult == 32'd12)
            passed = passed + 1;
        else
            $display("Unsigned Multiply #1 Test Failed. Expected: 12. Actual: %d", ALUResult);
       
        #5; // Test Set Less Than #1
        ALUControl <= 5'b01110;
        tests = tests + 1;
        A <= 32'd12;
        B <= 32'd10;
        #5 if(ALUResult == 32'b0)
            passed = passed + 1;
        else
            $display("Set Less Than #1 Test Failed. Expected: 0. Actual: %d", ALUResult);
        #5; // Test Set Less Than #2
        tests = tests + 1;
        A <= 32'd10;
        B <= 32'd12;
        #5 if(ALUResult == 32'b1)
            passed = passed + 1;
        else
            $display("Set Less Than #2 Test Failed. Expected: 1. Actual: %d", ALUResult);
        #5; // Test Set Less Than #3
        tests = tests + 1;
        A <= -32'd12;
        B <= 32'd10;
        #5 if(ALUResult == 32'b1)
            passed = passed + 1;
        else
            $display("Set Less Than #3 Test Failed. Expected: 1. Actual: %d", ALUResult);
        #5; // Test Set Less Than #4
        tests = tests + 1;
        A <= 32'd10;
        B <= -32'd12;
        #5 if(ALUResult == 32'b0)
            passed = passed + 1;
        else
            $display("Set Less Than #4 Test Failed. Expected: 0. Actual: %b", ALUResult);

        #5; // Test Sign-Extend Byte #1
        ALUControl <= 5'b01111;
        tests = tests + 1;       
        B <= 32'b11000100;
        #5 if(ALUResult == 32'b11111111111111111111111111000100)
            passed = passed + 1;
        else
            $display("Sign-Extend Byte #1 Test Failed. Expected: 11111111111111111111111111000100. Actual: %b", ALUResult);
        #5; //testing Sign-Extend Byte #2
        tests = tests + 1;       
        B <= 32'b01000100;
        #5 if(ALUResult == 32'b00000000000000000000000001000100)
            passed = passed + 1;
        else
            $display("Sign-Extend Byte #2 Test Failed. Expected: 00000000000000000000000001000100. Actual: %b", ALUResult);
  
        #5; // Test Set Less Than Unsigned #1
        ALUControl <= 5'b10000;
        tests = tests + 1;
        A <= 32'd12;
        B <= 32'd10;
        #5 if(ALUResult == 32'b0)
            passed = passed + 1;
        else
            $display("Set Less Than Unsigned #1 Test Failed. Expected: 0. Actual: %d", ALUResult);
        #5; // Test Set Less Than Unsigned #2
        tests = tests + 1;
        A <= 32'd9;
        B <= 32'd11;
        #5 if(ALUResult == 32'b1)
            passed = passed + 1;
        else
            $display("Set Less Than unsigned #2 Test Failed. Expected: 1. Actual: %d", ALUResult);
        
        #5; //Test Shift Left Logical Variable #1
        ALUControl <= 5'b10001;
        tests = tests + 1;
        A <= 32'd1;
        B <= 32'd2;
        #5 if(ALUResult == 32'd4)
            passed = passed + 1;
        else
            $display("Shift Left Logical Variable #1 Test Failed. Expected: 4. Actual: %d", ALUResult);
        
        #5; //Test Shift Right Logical Variable #1
        ALUControl <= 5'b10010;
        tests = tests + 1;
        A <= 32'd2;
        B <= 32'd4;
        #5 if(ALUResult == 32'd1)
            passed = passed + 1;
        else
            $display("Shift Right Logical Variable #1 Test Failed. Expected: 1. Actual: %d", ALUResult);
        
        #5; // Test Shift Right Arithmetic Variable #1
        ALUControl <= 5'b10011;
        tests = tests + 1;       
        B <= 32'b10110100000000000000000000000010;
        A <= 32'd2;
        #5 if(ALUResult == 32'b11101101000000000000000000000000)
            passed = passed + 1;
        else
            $display("Shift Right Arithmetic Variable #1 Test Failed. Expected: 11101101000000000000000000000000. Actual: %b", ALUResult);
        
        #5; // Test Shift Right Arithmetic Variable #2
        tests = tests + 1;       
        B <= 32'b00110100000000000000000000000010;
        A <= 32'd2;
        #5 if(ALUResult == 32'b00001101000000000000000000000000)
            passed = passed + 1;
        else
            $display("Shift Right Arithmetic Variable #2 Test Failed. Expected: 00001101000000000000000000000000. Actual: %b", ALUResult);
        
        #5; // Test Rotate Right #1
        ALUControl <= 5'b10100;
        tests = tests + 1;       
        B <= 32'b10110100000000000000000000000010;
        A <= 32'd2;
        #5 if(ALUResult == 32'b10101101000000000000000000000000)
            passed = passed + 1;
        else
            $display("Rotate Right Logical Variable #1 Test Failed. Expected: 10101101000000000000000000000000. Actual: %b", ALUResult);
            
        #5; // Test Move #1
        ALUControl <= 5'b10101;
        tests = tests + 1;       
        B <= 32'd0;
        #5 if(ALUResult == 32'd0)
            passed = passed + 1;
        else
            $display("Move #1 Test Failed. Expected: 00000000000000000000000000000000. Actual: %b", ALUResult);

        #5; // Test Move #2
        ALUControl <= 5'b10101;
        tests = tests + 1;       
        B <= 32'd1;
        #5 if(ALUResult == 32'd1)
            passed = passed + 1;
        else
            $display("Move #2 Test Failed. Expected: 00000000000000000000000000000001. Actual: %b", ALUResult);

        // Report results
        if (passed == tests)
            $display("All tests passed.");
        else
            $display("%2d out of %2d test passed.", passed, tests);
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
	end
endmodule


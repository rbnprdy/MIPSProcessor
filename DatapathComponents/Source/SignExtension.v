`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, opcode, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    // To choose between zero-extend and sign-extend
    input [5:0] opcode;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @(in, opcode)
    begin
        // Zero-extend if this is a logical-immediate function
        if (opcode == 6'b001100 || opcode == 6'b001101 || opcode == 6'b001110)
            out <= {16'd0, in[15:0]};
        // Otherwise sign-extend
        else
            out <= { {16{in[15]}}, in[15:0]}; 
    end

endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Ruben Purdy and Kray Althaus
// Overall percent effort of each team meber: 50/50
// 
// ECE369A - Computer Architecture
// Laboratory 3 (PostLab)
// Module - InstructionFetchUnit.v
// Description - Fetches the instruction from the instruction memory based on 
//               the program counter (PC) value.
// INPUTS:-
// Reset: 1-Bit input signal. 
// Clk: Input clock signal.
//
// OUTPUTS:-
// Instruction: 32-Bit output instruction from the instruction memory. 
//              Decimal value diplayed on the LCD usng the wrapper given in Lab 2
//
// FUNCTIONALITY:-
// Please connect up the following implemented modules to create this
// 'InstructionFetchUnit':-
//   (a) ProgramCounter.v
//   (b) PCAdder.v
//   (c) InstructionMemory.v
// Connect the modules together in a testbench so that the instruction memory
// outputs the contents of the next instruction indicated by the memory location
// in the PC at every clock cycle. Please initialize the instruction memory with
// some preliminary values for debugging purposes.
//
// @@ The 'Reset' input control signal is connected to the program counter (PC) 
// register which initializes the unit to output the first instruction in 
// instruction memory.
// @@ The 'Instruction' output port holds the output value from the instruction
// memory module.
// @@ The 'Clk' input signal is connected to the program counter (PC) register 
// which generates a continuous clock pulse into the module.
////////////////////////////////////////////////////////////////////////////////

module InstructionFetchUnit(Instruction, PCAddResult, Branch, BranchAddress, Reset, Clk);
    
    input Reset, Clk, Branch; // Inputs to ProgramCounter
    input [31:0] BranchAddress;
    output [31:0] Instruction, PCAddResult; // Output of InstructionMemory
    
    wire [31:0] BranchMuxOut, PCResult; // Output by ProgramCounter and input to PCAdder and InstructionMemory
    
    Mux32Bit2To1 BranchMux(
        .out(BranchMuxOut),
        .inA(PCAddResult),
        .inB(BranchAddress),
        .sel(Branch)
    );
    ProgramCounter m2(
        .Address(BranchMuxOut),
        .PCResult(PCResult),
        .Reset(Reset),
        .Clk(Clk)
    );
        
    PCAdder m1(
        .PCResult(PCResult),
        .PCAddResult(PCAddResult)
    );
    
    InstructionMemory m3(
        .Address(PCResult),
        .Instruction(Instruction)
    );
    
endmodule


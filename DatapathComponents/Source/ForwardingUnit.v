`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2017 06:33:12 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(Rs_Id, Rt_Id, Rs_Ex, Rt_Ex, Rd_Mem, Rd_Wb, ALUSrc, MemWrite_Ex, RegWrite_Mem, MemWrite_Mem, MemRead_Wb, RegWrite_Wb, ForwardA, ForwardB, ForwardC, ForwardD, ForwardE, ForwardF, Branch);
    input [4:0] Rs_Id, Rt_Id, Rs_Ex, Rt_Ex, Rd_Mem, Rd_Wb;
    input ALUSrc, MemWrite_Ex, RegWrite_Mem, MemWrite_Mem, MemRead_Wb, RegWrite_Wb, Branch;
    
    output reg [1:0] ForwardA, ForwardB, ForwardE, ForwardF;
    output reg ForwardC, ForwardD;
    
    always@(*) begin
        // Forwarding from Mem to ALU input A
        if ((RegWrite_Mem == 1) && (Rd_Mem != 5'd0) && (Rd_Mem == Rs_Ex))
            ForwardA <= 2'b10;
        // Forwarding from Wb to ALU input A
        else if ((RegWrite_Wb == 1) && (Rd_Wb != 5'd0) && (Rd_Wb == Rs_Ex))
            ForwardA <= 2'b01;
        else
            ForwardA <= 2'b00;
            
        // Forwarding from Mem to ALU input B
        if ((RegWrite_Mem == 1) && (Rd_Mem != 5'd0) && (Rd_Mem == Rt_Ex) && (ALUSrc == 0))
            ForwardB <= 2'b10;
        // Forwarding from Wb to ALU input B
        else if ((RegWrite_Wb == 1) && (Rd_Wb != 5'd0) && (Rd_Wb == Rt_Ex) && (ALUSrc == 0))
            ForwardB <= 2'b01;
        else
            ForwardB <= 2'b00; 
            
        // Forwarding from Wb to Ex WriteData
        if ((MemWrite_Ex == 1) && (Rd_Wb != 5'd0) && (Rd_Wb == Rt_Ex) && ((MemRead_Wb == 1) || (RegWrite_Wb)))
            ForwardC <= 1;
        else
            ForwardC <= 0;
            
        // Forwarding from Wb to Mem WriteData
        if ((MemWrite_Mem == 1) && (Rd_Wb != 5'd0) && (Rd_Wb == Rd_Mem) && ((MemRead_Wb == 1) || (RegWrite_Wb)))
            ForwardD <= 1;
        else
            ForwardD <= 0;   
            
        // Forwarding from Mem to Id Branch A
        if ((Rs_Id == Rd_Mem) && (RegWrite_Mem == 1) && (Branch == 1))
            ForwardE <= 2'b01;
        // Forwarding from Wb to Id Branch A
        else if ((Rs_Id == Rd_Wb) && (RegWrite_Wb == 1) && (Branch == 1))
            ForwardE <= 2'b10;
        else
            ForwardE <= 2'b00;
        // Forwarding from Mem to Id Branch B
        if ((Rt_Id == Rd_Mem) && (RegWrite_Mem == 1) && (Branch == 1))
            ForwardF <= 2'b01;
        // Forwarding from Wb to Id Branch B
        else if ((Rt_Id == Rd_Wb) && (RegWrite_Wb == 1) && (Branch == 1))
            ForwardF <= 2'b10;
        else
            ForwardF <= 2'b00;
    end
endmodule

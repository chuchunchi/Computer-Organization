`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
always@(*) begin
    if(ALUOp==2'b10)begin //R-type
        if(instr==4'b0000) ALU_Ctrl_o <= 4'b0010; //add
        if(instr==4'b1000) ALU_Ctrl_o <= 4'b0110; //sub
        if(instr==4'b0111) ALU_Ctrl_o <= 4'b0000; //and
        if(instr==4'b0110) ALU_Ctrl_o <= 4'b0001; //or
        if(instr==4'b0100) ALU_Ctrl_o <= 4'b1000; //xor
        if(instr==4'b0010) ALU_Ctrl_o <= 4'b0111; //slt
        if(instr==4'b0001) ALU_Ctrl_o <= 4'b1001; //sll
        if(instr==4'b1101) ALU_Ctrl_o <= 4'b1011; //sra
    end
endmodule

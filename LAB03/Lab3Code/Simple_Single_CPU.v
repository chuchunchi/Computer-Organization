`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signals
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire [1:0] ALUOp;
wire [3:0]ALU_control;
wire zero,cout,overflow;
wire [31:0]imm_4 = 4;
wire branch;	
ProgramCounter PC(
        .clk_i(),      
	    .rst_i(),     
	    .pc_i(),   
	    .pc_o() 
	    );

Instr_Memory IM(
        .addr_i(),  
	    .instr_o()    
	    );
		
Reg_File RF(
        .clk_i(),      
		.rst_i(),     
        .RSaddr_i(),  
		.RTaddr_i(),  
 		.RDaddr_i(),  
        .RDdata_i(), 
 		.RegWrite_i(),
 		.RSdata_o(),  
        .RTdata_o()   
	    );
		
Decoder Decoder(
		.instr_i(),
		.ALUSrc(),
		.RegWrite(),
		.Branch(),
		.ALUOp()
	    );	

Adder PC_plus_4_Adder(
		.src1_i(),
		.src2_i(),
		.sum_o()
	    );
			
ALU_Ctrl ALU_Ctrl(
		.instr(),
		.ALUOp(),
		.ALU_Ctrl_o()
		);
		
alu alu(
		.rst_n(),
		.src1(),
		.src2(),
		.ALU_control(),
		.result(),
		.zero(),
		.cout(),
		.overflow()
		);
	
		
endmodule
		  



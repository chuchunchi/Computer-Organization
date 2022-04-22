`timescale 1ns/1ps

module alu_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input				less,       //1 bit less      (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);
wire a,b,tempresult;

/* Write your code HERE */
MUX2to1 muxa(.src1(src1),
	.src2(~src1),
	.select(Ainvert),
	.result(a));
	
MUX2to1 muxb(.src1(src2),
	.src2(~src2),
	.select(Binvert),
	.result(b));
	
MUX4to1 muxop(.src1(a&b),
	.src2(a|b),
	.src3(a^b^cin),
	.src4(less),
	.select(operation),
	.result(tempresult));
always @(*) begin
    if(operation[1]==1'b0)begin
        cout<=0;
    end
    else if(operation==2'b10)begin
        cout<=(a&b)|(a&cin)|(b&cin);
    end
    else if(operation==2'b11)begin
        cout<=(a&b)|(a&cin)|(b&cin);
    end
    result<=tempresult;
end
endmodule

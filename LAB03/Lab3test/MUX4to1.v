module MUX4to1(
	input			src1,
	input			src2,
	input			src3,
	input			src4,
	input   [2-1:0] select,
	output reg		result
	);
/* Write your code HERE */
always@(*)begin
    if(select==2'b00)
        assign result=src1;	
    if(select==2'b01)
        assign result=src2;
    if(select==2'b10)
        assign result=src3;
    if(select==2'b11)
        assign result=src4;
end
endmodule

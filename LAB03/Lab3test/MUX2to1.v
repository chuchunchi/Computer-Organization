module MUX2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);
/* Write your code HERE */
always @(*)begin
    result<=(select==0)?src1:src2;
end
endmodule

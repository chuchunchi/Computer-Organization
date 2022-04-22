
module alu(
	input                   rst_n,         // negative reset            (input)
	input signed [32-1:0]   src1,          // 32 bits source 1          (input)
	input signed [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

reg [1:0] op;
reg ain,bin,c;
reg less_0;
/* Write your code HERE */
always@(*) begin
    if(rst_n) begin
        op <= 2'b00;
        ain <= 1'b0;
        bin <= 1'b0;
        c <= 1'b0;
        less_0 <= 1'b0;
    end
    if(ALU_control==4'b0000)begin //and
        op<=2'b00;
        ain<=0;
        bin<=0;
        c<=0;
    end
    if(ALU_control==4'b0001)begin //or
        op<=2'b01;
        ain<=0;
        bin<=0;
        c<=0;
    end
    if(ALU_control==4'b0010)begin //add
        op<=2'b10;
        ain=0;
        bin=0;
        c=0;
    end
    if(ALU_control==4'b0110)begin //sub
        op<=2'b10;
        ain<=0;
        bin<=1;
        c<=1;
        
    end
    if(ALU_control==4'b0111)begin //slt
        op<=2'b11;
        ain<=0;
        bin<=1;
        c<=1;
    end
end 

wire [31:0] tempcout;
wire [31:0] tempresult;
alu_1bit a0_1bit(
    .src1 (src1[0]),
    .src2 (src2[0]),
    .less (src1[31]^(~src2[31])^tempcout[30]),
    .Ainvert(ain),
    .Binvert(bin),
    .cin(c),
    .operation (op),
    .result (tempresult[0]),
    .cout(tempcout[0])
);

genvar i;
generate 
    for (i=1;i<32;i=i+1) begin
        alu_1bit a_1bit(
            .src1 (src1[i]),
            .src2 (src2[i]),
            .less (1'b0),
            .Ainvert(ain),
            .Binvert(bin),
            .cin(tempcout[i-1]),
            .operation (op),
            .result (tempresult[i]),
            .cout(tempcout[i])
        );
    end
endgenerate
integer j;
always@(*) begin
    if(ALU_control==4'b0000 || ALU_control==4'b0001 || ALU_control==4'b0010 || ALU_control==4'b0110) begin
        zero<=1'b1;
        for(j=0;j<32;j=j+1) begin
            if(result[j]!=0)begin
                zero<=1'b0;
            end
        end
        for(j=0;j<32;j=j+1) begin
            result[j]<=tempresult[j];
        end
        overflow<=0;
        if(ALU_control==4'b0010)begin
            if(~(src1[31]^src2[31])&(src1[31]^result[31])) overflow<=1;
        end
        else if(ALU_control==4'b0110)begin
            if((src1[31]^src2[31])&(src1[31]^result[31])) overflow<=1;
        end
        //else overflow<=0;
        cout<=0;
        if(ALU_control[1:0]==2'b10) cout<=tempcout[31];
    end
    else if(ALU_control==4'b1000)begin //XOR
        result <= src1 ^ src2; 
        zero<=1'b0;
        cout<=1'b0;
        overflow<=1'b0;
    end
    else if(ALU_control==4'b1001)begin //shift left logical
        result <= src1 << src2;
        zero<=1'b0;
        cout<=1'b0;
        overflow<=1'b0;
    end
    else if(ALU_control==4'b1011)begin //shift right arithmetic
        result <= src1 >>> src2;
        zero<=1'b0;
        cout<=1'b0;
        overflow<=1'b0;
    end
end



endmodule

module FloatMult (
    input [31:0] floatA,
    input [31:0] floatB,

    output reg[31:0] floatProduct
);
    reg sign = 1'b0;
    reg [7:0] exponent, exponentA, exponentB;
    reg [23:0] fraction, fractionA, fractionB;
    reg normalize_flag = 1'b0;

    
endmodule
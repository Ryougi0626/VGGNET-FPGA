module ComputeUnit(
    input [31:0] floatA, floatB,
    output reg [31:0] result
);

    wire [31:0] FloatMult;

    FloatMult FM(
        .floatA(floatA),
        .floatB(floatB),
        .floatProduct(FloatMult)
    );

    FloatAdd FA(
        .floatA(FloatMult),
        .floatB(result),
        .floatSum(result)
    );

endmodule

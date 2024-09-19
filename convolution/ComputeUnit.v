module ComputeUnit #(
    parameter DATA_WIDTH = 32
)(
    input clk, reset,
    input [DATA_WIDTH-1:0] floatA, floatB,
    output reg [DATA_WIDTH-1:0] result
);

    wire [DATA_WIDTH-1:0] MultResult;
    wire [DATA_WIDTH-1:0] AddResult;

    FloatMult FM(
        .floatA(floatA),
        .floatB(floatB),
        .floatProd(MultResult)
    );

    FloatAdd FA(
        .floatA(MultResult),
        .floatB(result),
        .floatSum(AddResult)
    );

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            result <= 32'b0;
        end else begin
            result <= AddResult;
        end
    end
endmodule

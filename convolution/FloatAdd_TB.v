`timescale 10ns/1ps

module FloatAdd_TB ();

reg [31:0] floatA;
reg [31:0] floatB;
wire [31:0] floatSum;

initial begin
    $dumpfile("FloatAdd_TB.vcd");
    $dumpvars(0, FloatAdd_TB);

    floatA = 32'b0;
    floatB = 32'b0;
    // 0

    #5
    floatA = 32'b00111111110000000000000000000000; //1.5
    floatB = 32'b01000000000100000000000000000000; //2.25
              // 01000000011100000000000000000000

    #5
    floatA = 32'b01111111100000000000000000000000; // Positive infinity
    floatB = 32'b01000000000100000000000000000000; // 2.25
              // 01111111100000000000000000000000

    #5
    floatA = 32'b11111111100000000000000000000000; // Negative infinity
    floatB = 32'b01000000000100000000000000000000; // 2.25
              // 11111111100000000000000000000000
	#1000
    $stop;
end

FloatAdd FA
(
	.floatA(floatA),
	.floatB(floatB),
	.floatSum(floatSum)
);

endmodule
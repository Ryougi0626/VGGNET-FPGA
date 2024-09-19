`timescale 1ns / 1ps

module ComputeUnit_TB();

    reg clk, reset;
    reg [31:0] floatA, floatB;
    wire [31:0] result;
    
    initial begin
        $dumpfile("ComputeUnit_TB.vcd");
        $dumpvars(0, ComputeUnit_TB);


        clk = 0;
        reset = 1;
        floatA = 32'b0;
        floatB = 32'b0;

        #10
        clk = 1;
        reset = 1;

        #10 
        clk = 0;
        reset = 0;

        #10
        clk = 1;
        floatA = 32'b01000000101000000000000000000000; // 5
        floatB = 32'b01000000001000000000000000000000;// 2.5
               //32'b01000001010010000000000000000000 12.5
        #10
        clk = 0;

        #10
        clk = 1;
        floatA = 32'b00111101010011001100110011001101; //0.05
        floatB = 32'b01000000000000000000000000000000; // 2
               //32'b01000001010010011001100110011010 12.6
        #10
        clk = 0;

        #10 
        clk = 1;
        floatA = 32'b00000000000000000000000000000000; // 0
        floatB = 32'b01000000000000000000000000000000; // 2
               //32'b01000001010010011001100110011010 12.6
        #10
        clk = 0;

        #10
        clk = 1;
        floatA = 32'b00111111101000000000000000000000; //1.25
        floatB = 32'b01000000101100000000000000000000; //5.5
               //32'b01000001100110111100110011001101 19.475

        #10
        clk = 0;

        #10
        clk = 1;

        #10
        clk = 0;
        
        #1000
        $stop;
    end

    ComputeUnit CU(
        .clk(clk),
        .reset(reset),
        .floatA(floatA),
        .floatB(floatB),
        .result(result)
    );

endmodule
`timescale 1ns / 1ps

module ConvolutionUnit_TB();

    parameter DATA_WIDTH = 32;
    parameter KERNEL_SIZE = 3;

    reg clk, reset;
    reg [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0] filter;
    reg [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0] image;
    wire [DATA_WIDTH-1:0] result;
    
    parameter PERIOD = 100;

    always #(PERIOD/2) begin
        clk = ~clk;
    end

    initial begin
        $dumpfile("ConvolutionUnit_TB.vcd");
        $dumpvars(0, ConvolutionUnit_TB);

        reset = 1;
        image = 0;
        filter = 0;
        clk = 0;

        #PERIOD
        reset = 0;

        #PERIOD
        reset = 1;

        // #PERIOD
        // floatA = 32'b01000000101000000000000000000000; // 5
        // floatB = 32'b01000000001000000000000000000000;// 2.5
        //        //32'b01000001010010000000000000000000 12.5
        // #PERIOD
        // clk = 0;
        // #PERIOD
        // clk = 1;
        // floatA = 32'b00111101010011001100110011001101; //0.05
        // floatB = 32'b01000000000000000000000000000000; // 2
        //        //32'b01000001010010011001100110011010 12.6
        // #PERIOD
        // clk = 0;

        // #PERIOD 
        // clk = 1;
        // floatA = 32'b00000000000000000000000000000000; // 0
        // floatB = 32'b01000000000000000000000000000000; // 2
        //        //32'b01000001010010011001100110011010 12.6
        // #PERIOD
        // clk = 0;

        // #PERIOD
        // clk = 1;
        // floatA = 32'b00111111101000000000000000000000; //1.25
        // floatB = 32'b01000000101100000000000000000000; //5.5
        //        //32'b01000001100110111100110011001101 19.475
        // #PERIOD
        // clk = 0;

        // #PERIOD 
        // clk = 1;
        // floatA = 32'b00000000000000000000000000000000; // 0
        // floatB = 32'b01000000000000000000000000000000; // 2
        //        //32'b01000001100110111100110011001101 19.475
        // #PERIOD
        // clk = 0;

        // #PERIOD
        // clk = 1;
        // floatA = 32'b00111111101000000000000000000000; //1.25
        // floatB = 32'b01000000101100000000000000000000; //5.5
        //        //32'b01000001110100101100110011001101  //26.35
        // #PERIOD
        // clk = 0;

        // #PERIOD
        // clk = 1;
        // floatA = 32'b00111101010011001100110011001101; //0.05
        // floatB = 32'b01000000100000000000000000000000; // 4
        //        //32'b01000001110100101100110011001101  //26.55
        // #PERIOD
        // clk = 0;

        // #PERIOD
        // clk = 1;
        // floatA = 32'b00111111101000000000000000000000; //1.25
        // floatB = 32'b01000000100000000000000000000000; // 4
        //        //32'b01000001110100101100110011001101  //31.55
        // #PERIOD
        // clk = 0;

        // #PERIOD
        // clk = 1;
        // floatA = 32'b01000001001000000000000000000000; //10
        // floatB = 32'b00111110100000000000000000000000; //0.25
        //        //32'b01000010000010000011001100110011  //34.05


        #PERIOD
        filter = 288'b010000001010000000000000000000000011110101001100110011001100110100000000000000000000000000000000001111111010000000000000000000000000000000000000000000000000000000111111101000000000000000000000001111010100110011001100110011010011111110100000000000000000000001000001001000000000000000000000;
        image  = 288'b010000000010000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000001011000000000000000000000100000000000000000000000000000001000000101100000000000000000000010000001000000000000000000000000100000010000000000000000000000000111110100000000000000000000000;

        #(PERIOD*20)

        $stop;
    end

    ConvolutionUnit #(
        .DATA_WIDTH(32),
        .KERNEL_SIZE(3)
    ) CU(
        .clk(clk),
        .reset(reset),
        .filter(filter),
        .image(image),
        .result(result)
    );

endmodule
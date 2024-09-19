`timescale 1ps/1ps

module FloatMult_TB();

    reg [31:0] floatA, floatB;
    wire [31:0] floatProd;

    initial begin

        $dumpfile("FloatMult_TB.vcd");
        $dumpvars(0, FloatMult_TB);

        floatA = 32'b00110101110000001010001111010111; // 0.0004125
        floatB = 32'b00000000000000000000000000000000; // 0
               //32'b0
        #10;
       
 
        floatA = 32'b01000000100000000000000000000000; // 4
        floatB = 32'b01000000101000000000000000000000; // 5
               //32'b01000001101000000000000000000000
        #10;

        floatA = 32'b00111001000000110001001001101111; // 0.000125
        floatB = 32'b01000000000000000000000000000000; // 2
               //32'b00111001100000110001001001101111

        #10;
        
        #1000
        $stop;
    end

    FloatMult FM(
        .floatA(floatA),
        .floatB(floatB),
        .floatProd(floatProd)
    );

endmodule
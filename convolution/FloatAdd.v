module FloatAdd(
    input [31:0] floatA,
    input [31:0] floatB,

    output reg[31:0] floatSum
);
    reg sign = 1'b0;
    reg [7:0] exponent, exponentA, exponentB;
    reg [23:0] fraction, fractionA, fractionB;
    reg normalize_flag = 1'b0;


    always @(*) begin
        // sepcial case
        if (floatA == 32'b0) begin
            floatSum = floatB;
        end 
        else if (floatB == 32'b0)begin
            floatSum = floatA;
        end 
        else if ((floatA[31] == !floatB[31]) && (floatA[30:0] == floatB[30:0])) begin
            floatSum = 0;
        end 
        // normal case
        else begin 
            // 1.separate the sign, exponent and fraction
            exponentA = floatA[30:23];  exponentB = floatB[30:23];
            fractionA = {1'b1, floatA[22:0]};   fractionB = {1'b1, floatB[22:0]};

            // 2. calculate the exponent and shift the fractionA,B
            if (exponentA > exponentB) begin
                exponent = exponentA;
                if (exponentA - exponentB > 23) begin
                    fraction = fractionA;
                end
                else begin
                    fractionB = fractionB >> (exponentA - exponentB);
                end
            end
            else if (exponentA < exponentB) begin
                exponent = exponentB;
                if (exponentB - exponentA > 23) begin 
                    fraction = fractionB;
                end
                else begin
                    fractionA = fractionA >> (exponentB - exponentA);
                end
            end

            // 3. add the fraction
            if (floatA[31] == floatB[31]) begin  // same sign
                {normalize_flag, fraction} = fractionA + fractionB;
            end
            else if (floatA[31] == ~floatB[31]) begin  // different sign
                if (floatA[31] == 1'b1) begin 
                    {normalize_flag, fraction} = fractionB - fractionA; 
                end
                else begin
                    {normalize_flag, fraction} = fractionA - fractionB;
                end
            end
            sign = normalize_flag;

            // 4. normalize the fraction
            if (normalize_flag == 1) begin
                exponent = exponent + 1;
                fraction = fraction >> 1;
            end
            else begin
                if (fraction[23] == 0) begin
                    if (fraction[22] == 1'b1) begin
                        fraction = fraction << 1;
                        exponent = exponent - 1;
                    end else if (fraction[21] == 1'b1) begin
                        fraction = fraction << 2;
                        exponent = exponent - 2;
                    end else if (fraction[20] == 1'b1) begin
                        fraction = fraction << 3;
                        exponent = exponent - 3;
                    end else if (fraction[19] == 1'b1) begin
                        fraction = fraction << 4;
                        exponent = exponent - 4;
                    end else if (fraction[18] == 1'b1) begin
                        fraction = fraction << 5;
                        exponent = exponent - 5;
                    end else if (fraction[17] == 1'b1) begin
                        fraction = fraction << 6;
                        exponent = exponent - 6;
                    end else if (fraction[16] == 1'b1) begin
                        fraction = fraction << 7;
                        exponent = exponent - 7;
                    end else if (fraction[15] == 1'b1) begin
                        fraction = fraction << 8;
                        exponent = exponent - 8;
                    end else if (fraction[14] == 1'b1) begin
                        fraction = fraction << 9;
                        exponent = exponent - 9;
                    end else if (fraction[13] == 1'b1) begin
                        fraction = fraction << 10;
                        exponent = exponent - 10;
                    end else if (fraction[12] == 1'b1) begin
                        fraction = fraction << 11;
                        exponent = exponent - 11;
                    end else if (fraction[11] == 1'b1) begin
                        fraction = fraction << 12;
                        exponent = exponent - 12;
                    end else if (fraction[10] == 1'b1) begin
                        fraction = fraction << 13;
                        exponent = exponent - 13;
                    end else if (fraction[9] == 1'b1) begin
                        fraction = fraction << 14;
                        exponent = exponent - 14;
                    end else if (fraction[8] == 1'b1) begin
                        fraction = fraction << 15;
                        exponent = exponent - 15;
                    end else if (fraction[7] == 1'b1) begin
                        fraction = fraction << 16;
                        exponent = exponent - 16;
                    end else if (fraction[6] == 1'b1) begin
                        fraction = fraction << 17;
                        exponent = exponent - 17;
                    end else if (fraction[5] == 1'b1) begin
                        fraction = fraction << 18;
                        exponent = exponent - 18;
                    end else if (fraction[4] == 1'b1) begin
                        fraction = fraction << 19;
                        exponent = exponent - 19;
                    end else if (fraction[3] == 1'b1) begin
                        fraction = fraction << 20;
                        exponent = exponent - 20;
                    end else if (fraction[2] == 1'b1) begin
                        fraction = fraction << 21;
                        exponent = exponent - 21;
                    end else if (fraction[1] == 1'b1) begin
                        fraction = fraction << 22;
                        exponent = exponent - 22;
                    end else if (fraction[0] == 1'b1) begin
                        fraction = fraction << 23;
                        exponent = exponent - 23;
                    end
                end
            end

            // 5. check the exponent overflow and underflow
            if (exponent == 255 || exponent == 0) begin
                floatSum = {sign, exponent, 23'b0};
            end
            else begin
                floatSum = {sign, exponent, fraction[22:0]};
            end
        end
    end

endmodule
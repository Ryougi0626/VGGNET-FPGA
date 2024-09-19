module FloatMult (
    input [31:0] floatA, floatB,
    output reg [31:0] floatProd
);
    reg sign; 
    reg [7:0] exponent;
    reg [23:0] fractionA, fractionB;
    reg [47:0] fraction;
    
    integer shift;

    always @(*) begin
        // 1. sign bit
        sign = floatA[31] ^ floatB[31];
        
        if (floatA == 32'b0 || floatB == 32'b0) begin
            floatProd = {sign, 31'b0};
        end
        else begin
            // 2. exponent
            exponent = floatA[30:23] + floatB[30:23] - 8'd127;

            // 3. fraction mult
            fractionA = {1'b1, floatA[22:0]};
            fractionB = {1'b1, floatB[22:0]};
            fraction = fractionA * fractionB;

            // 4. normalize 
            if (fraction[47] == 1'b1) begin
                fraction = fraction >> 1;
                exponent = exponent + 1;
            end else begin
                for (shift = 0; shift < 48 && fraction != 0 && exponent > 0 && fraction[46] == 1'b0; shift = shift + 1) begin
                    if (fraction[46] == 1'b1) begin
                        shift = 48;
                    end
                    fraction = fraction << 1;
                    exponent = exponent - 1;
                end
            end

            // 5. check overflow and underflow
            if (exponent >= 8'd255) begin
                floatProd = {sign, 8'd255, 23'd0}; //overflow
            end else if (exponent <= 8'd0) begin
                floatProd = {sign, 8'd0, 23'd0}; //underflow
            end else begin
                if (fraction[46:24] != 0 || fraction[24] == 1) begin 
                    fraction = fraction + 1;
                end
                floatProd = {sign, exponent, fraction[45:23]};
            end
        end
    end
endmodule
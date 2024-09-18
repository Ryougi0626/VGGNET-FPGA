module PulseGenerator(
    input clk, reset,
    input [31:0] CLK_PERIOD,

    output reg pulse_start
);

    reg [31:0] count;

    always @(posedge clk or negedge reset) begin
        if(!reset) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
            if (count == CLK_PERIOD) begin
                pulse_start <= 1;
                count <= 0;
            end
            else begin
                pulse_start <= 0;
            end
        end
    end

endmodule
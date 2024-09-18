module ConvolutionUnit #(
    parameter DATA_WIDTH = 32,
    parameter KERNEL_SIZE = 3
) (
    input clk, reset,
    input [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0] filter, image,

    output reg [DATA_WIDTH-1:0] result
);
    parameter CLK_PERIOD = 10;

    wire pulse_start;

    integer i;

    PulseGenerator #(
        .CLK_PERIOD(CLK_PERIOD)
    ) PG(
        .clk(clk),
        .reset(reset),
        .pulse_start(pulse_start)
    );

    ComputeUnit CU(
        .floatA(filter_buf),
        .floatB(image_buf),
        .result(result)
    );

    reg [31:0] filter_buf, image_buf;

    always @(posedge pulse_start or negedge reset) begin
        if(!reset) begin
            i = 1'b0;
            filter_buf = 1'b0;
            image_buf = 1'b0;
        end
        else begin
            filter_buf = filter[DATA_WIDTH*i+:DATA_WIDTH];
            image_buf = image[DATA_WIDTH*i+:DATA_WIDTH];
        end
    end
endmodule
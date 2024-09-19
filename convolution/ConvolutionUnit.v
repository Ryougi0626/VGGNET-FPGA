module ConvolutionUnit #(
    parameter DATA_WIDTH = 32,
    parameter KERNEL_SIZE = 3
) (
    input clk, reset,
    input [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0] filter, image,

    output reg [DATA_WIDTH-1:0] result
);
    integer i;


    reg [DATA_WIDTH-1:0] filter_buf, image_buf;
    wire [DATA_WIDTH-1:0] result_buf;

    ComputeUnit CU(
        .clk(clk),
        .reset(reset),
        .floatA(filter_buf),
        .floatB(image_buf),
        .result(result_buf)
    );

    always @(posedge clk or negedge reset) begin
        if(!reset) begin
            i = 0;
            result = 0;
            filter_buf = 0;
            image_buf = 0;
        end
        else if (i < KERNEL_SIZE*KERNEL_SIZE) begin
            filter_buf = filter[DATA_WIDTH*i+:DATA_WIDTH];
            image_buf = image[DATA_WIDTH*i+:DATA_WIDTH];
            result = result + result_buf;
            i = i + 1;
        end else begin
            i = 0;
            result = 0;
        end
    end
endmodule
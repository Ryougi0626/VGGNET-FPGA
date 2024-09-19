module ConvolutionLayer #(
    parameter IMAGE_WIDTH = 224,
    parameter IMAGE_HEIGHT = 224,
    parameter KERNEL_SIZE = 3,
    parameter KERNEL_NUM = 64
)(
    input clk, reset,
    input []
)

    ImageSelector #(
        .IMAGE_WIDTH(IMAGE_WIDTH),
        .IMAGE_HEIGHT(IMAGE_HEIGHT),
        .KERNEL_SIZE(KERNEL_SIZE),
        .KERNEL_NUM(KERNEL_NUM)
    ) IS(
        .image(image),
        .window_data(window_data)
    );

    genvar i;
    generate 
        for (i = 0; i < KERNEL_NUM; i++) begin
            ConvolutionUint #(
                .DATA_WIDTH(DATA_WIDTH),
                .KERNEL_SIZE(KERNEL_SIZE),
            ) CU(
                .clk(clk),
                .reset(reset),
                .filter(filter),
                .image()
            )
        end
    endgenerate

endmodule

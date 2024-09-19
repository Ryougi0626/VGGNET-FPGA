module ImageSeletor #(
    parameter IMAGE_WIDTH = 224,
    parameter IMAGE_HEIGHT = 224,
    parameter KERNEL_SIZE = 3,
    parameter KERNEL_NUM = 64
)(
    input clk, reset,
    input [31:0] image [IMAGE_WIDTH * IMAGE_HEIGHT - 1:0],
    output reg [31:0] window_data [KERNEL_SIZE * KERNEL_SIZE * KERNEL_NUM - 1:0],
);

    reg [$clog2(IMAGE_WIDTH)-1:0] col_count;
    reg [$clog2(IMAGE_HEIGHT)-1:0] row_count;
    
    integer i, j, k;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            col_count <= 0;
            row_count <= 0;
            for (k = 0; k < KERNEL_SIZE * KERNEL_SIZE * KERNEL_NUM; k = k + 1) begin
                window_data[k] <= 32'b0;
            end
        end else begin
            for (i = 0; i < KERNEL_SIZE; i = i + 1) begin
                for (j = 0; j < KERNEL_SIZE; j = j + 1) begin
                    for (k = 0; k < KERNEL_NUM; k = k + 1) begin
                        window_data[k*KERNEL_SIZE*KERNEL_SIZE + i*KERNEL_SIZE + j] <= 
                            image[(row_count+i)*IMAGE_WIDTH + (col_count+j)];
                    end
                end
            end

            if (col_count < IMAGE_WIDTH - KERNEL_SIZE) begin
                col_count <= col_count + 1;
            end else if (row_count < IMAGE_HEIGHT - KERNEL_SIZE) begin
                col_count <= 0;
                row_count <= row_count + 1;
            end else begin
                col_count <= 0;
                row_count <= 0;
            end

            data_valid = 1'b1;
        end
    end

endmodule


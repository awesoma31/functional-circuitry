`timescale 1ns / 1ps


module decoder3to8_nand_tb;
    reg a, b, c;
    wire [7:0] y;

    decoder3to8_nand uut (
        .a(a), .b(b), .c(c),
        .y0(y[0]), .y1(y[1]), .y2(y[2]), .y3(y[3]),
        .y4(y[4]), .y5(y[5]), .y6(y[6]), .y7(y[7])
    );

    initial begin
        $display(" A B C | Y7 Y6 Y5 Y4 Y3 Y2 Y1 Y0");
        $display("-------------------------------");
        for (integer i = 0; i < 8; i = i + 1) begin
            {a, b, c} = i[2:0];
            #5; 
            $display(" %b %b %b |  %b  %b  %b  %b  %b  %b  %b  %b",
                     a, b, c, y[7], y[6], y[5], y[4], y[3], y[2], y[1], y[0]);
        end
        $finish;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2025 04:28:47 PM
// Design Name: 
// Module Name: decoder3to8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder3to8_nand (
    input  wire a, b, c,
    output wire y0, y1, y2, y3, y4, y5, y6, y7
);
    wire na, nb, nc;
    nand(na, a, a);
    nand(nb, b, b);
    nand(nc, c, c);

    wire y0n, y1n, y2n, y3n, y4n, y5n, y6n, y7n;
    nand(y0n, na, nb, nc); // 000
    nand(y1n, na, nb, c);  // 001
    nand(y2n, na, b,  nc); // 010
    nand(y3n, na, b,  c);  // 011
    nand(y4n, a,  nb, nc); // 100
    nand(y5n, a,  nb, c);  // 101
    nand(y6n, a,  b,  nc); // 110
    nand(y7n, a,  b,  c);  // 111

    nand(y0, y0n, y0n);
    nand(y1, y1n, y1n);
    nand(y2, y2n, y2n);
    nand(y3, y3n, y3n);
    nand(y4, y4n, y4n);
    nand(y5, y5n, y5n);
    nand(y6, y6n, y6n);
    nand(y7, y7n, y7n);
endmodule

`timescale 1ns / 1ps

module MUX_2x1_8b(
    input [7:0] IP_1,
    input [7:0] IP_2,
    input SELECT,
    output [7:0] OUTPUT
    );
    
    assign OUTPUT = (SELECT) ? IP_2 : IP_1;
endmodule

`timescale 1ns / 1ps

module HYBRID_32b(
    input [31:0] A,
    input [31:0] B,
    input C_IN,
    output reg [31:0] SUM,
    output reg C_OUT
    );
    
    wire [7:0] A0, A1, A2, A3;
    assign A0 = A[7:0];
    assign A1 = A[15:8];
    assign A2 = A[23:16];
    assign A3 = A[31:24];
    
    wire [7:0] B0, B1, B2, B3;
    assign B0 = B[7:0];
    assign B1 = B[15:8];
    assign B2 = B[23:16];
    assign B3 = B[31:24];
    
    wire [7:0] S00, S01, S02, S03, S10, S11, S12, S13;
    wire C00, C01, C02, C03, C10, C11, C12, C13;
    
    BKA_8_bit BKA00 (A0, B0, 0, S00, C00);
    BKA_8_bit BKA01 (A1, B1, C00, S01, C01);
    BKA_8_bit BKA02 (A2, B2, C01, S02, C02);
    BKA_8_bit BKA03 (A3, B3, C02, S03, C03);
    
    BKA_8_bit BKA10 (A0, B0, 1, S10, C10);
    BKA_8_bit BKA11 (A1, B1, C10, S11, C11);
    BKA_8_bit BKA12 (A2, B2, C11, S12, C12);
    BKA_8_bit BKA13 (A3, B3, C12, S13, C13);
    
    wire [7:0] S0, S1, S2, S3;
    wire C_O;
    
    MUX_2x1_8b M0 (S00, S10, C_IN, S0);
    MUX_2x1_8b M1 (S01, S11, C_IN, S1);
    MUX_2x1_8b M2 (S02, S12, C_IN, S2);
    MUX_2x1_8b M3 (S03, S13, C_IN, S3);

    MUX_2x1 CARRY_OUT (C03, C13, C_IN, C_O);
    
    always @(*)
    begin
        SUM[7:0] = S0;
        SUM[15:8] = S1;
        SUM[23:16] = S2;
        SUM[31:24] = S3;
        C_OUT = C_O;
    end
    
endmodule
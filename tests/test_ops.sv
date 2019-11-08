`timescale 1ns / 1ps

`include "svreal.sv"

module test_ops;

    // create signals
    `MAKE_SVREAL(a, 16, -8);
    `MAKE_SVREAL(b, 17, -9);

    // min
    `MAKE_SVREAL(min_o, 18, -10);
    `SVREAL_MIN(a, b, min_o);

    // max
    `MAKE_SVREAL(max_o, 18, -10);
    `SVREAL_MAX(a, b, max_o);

    // add
    `MAKE_SVREAL(add_o, 18, -10);
    `SVREAL_ADD(a, b, add_o);

    // sub
    `MAKE_SVREAL(sub_o, 18, -10);
    `SVREAL_SUB(a, b, sub_o);

    // mul
    `MAKE_SVREAL(mul_o, 18, -10);
    `SVREAL_MUL(a, b, mul_o);

    // mux
    `MAKE_SVREAL(mux_o, 18, -10);
    logic sel;
    `SVREAL_MUX(sel, a, b, mux_o);

    // negate
    `MAKE_SVREAL(neg_o, 18, -10);
    `SVREAL_NEGATE(a, neg_o);

    // real to integer
    logic signed [7:0] r2i_o;
    `SVREAL_TO_INT(a, r2i_o, 8);

    // integer to real
    logic signed [7:0] i2r_i;
    `MAKE_SVREAL(i2r_o, 16, -8);
    `INT_TO_SVREAL(i2r_i, i2r_o, 8);

    // comparisons
    logic lt_o, le_o, gt_o, ge_o;
    `SVREAL_LT(a, b, lt_o);
    `SVREAL_LE(a, b, le_o);
    `SVREAL_GT(a, b, gt_o);
    `SVREAL_GE(a, b, ge_o);

    task print_signals();
        `SVREAL_PRINT(a);
        `SVREAL_PRINT(b);
        `SVREAL_PRINT(min_o);
        `SVREAL_PRINT(max_o);
        `SVREAL_PRINT(add_o);
        `SVREAL_PRINT(sub_o);
        `SVREAL_PRINT(mul_o);
        `SVREAL_PRINT(mux_o);
        `SVREAL_PRINT(neg_o);
        `SVREAL_PRINT(i2r_o);
        $display("r2i_o=%0d", r2i_o);
        $display("lt_o=%0b", lt_o);
        $display("le_o=%0b", le_o);
        $display("gt_o=%0b", gt_o);
        $display("ge_o=%0b", ge_o);
    endtask

    // create testbench
    initial begin
        // print header
        $display("SVREAL TEST START");
        #(1ns);

        // test set #1
        $display("SVREAL TEST SET 1");
        `SVREAL_SET(a, 1.23);
        `SVREAL_SET(b, 4.56);
        sel = 1'b0;
        i2r_i = 78;
        #(1ns);
        print_signals();

        // test set #2
        $display("SVREAL TEST SET 2");
        `SVREAL_SET(a, 1.23);
        `SVREAL_SET(b, 4.56);
        sel = 1'b1;
        i2r_i = 78;
        #(1ns);
        print_signals();

        // test set #3
        $display("SVREAL TEST SET 3");
        `SVREAL_SET(a, 4.56);
        `SVREAL_SET(b, 1.23);
        sel = 1'b0;
        i2r_i = 78;
        #(1ns);
        print_signals();

        // test set #4
        $display("SVREAL TEST SET 4");
        `SVREAL_SET(a, 56.0);
        `SVREAL_SET(b, 1.23);
        sel = 1'b0;
        i2r_i = 78;
        #(1ns);
        print_signals();

        // print footer
        $display("SVREAL TEST END");
        #(1ns);
    end

endmodule

`timescale 1ns / 1ps

`include "svreal.sv"

module test_dff;

    // create signals
    `MAKE_SVREAL(d, 16, -8);
    `MAKE_SVREAL(q, 17, -9);
    `MAKE_SVREAL(init, 18, -10);
    logic clk, rst, cke;
    `SVREAL_DFF(d, q, rst, clk, cke, init);

    task print_signals();
        `SVREAL_PRINT(d);
        `SVREAL_PRINT(q);
        `SVREAL_PRINT(init);
        $display("clk=%0b", clk);
        $display("rst=%0b", rst);
        $display("cke=%0b", cke);
    endtask

    // create testbench
    initial begin
        // print header
        $display("SVREAL TEST START");
        #(1ns);

        // read out the reset value
        `SVREAL_SET(init, 1.23);
        `SVREAL_SET(d, 2.34);
        clk = 1'b0;
        rst = 1'b1;
        cke = 1'b1;
        #(1ns);
        clk = 1'b1;
        #(1ns);
        $display("SVREAL TEST SET 1");
        print_signals();

        // clock in the first value
        `SVREAL_SET(d, 2.34);
        clk = 1'b0;
        rst = 1'b0;
        cke = 1'b1;
        #(1ns);
        clk = 1'b1;
        $display("SVREAL TEST SET 2");
        print_signals();
        #(1ns);
        $display("SVREAL TEST SET 3");
        print_signals();

        // clock in the second value
        `SVREAL_SET(d, 3.45);
        clk = 1'b0;
        rst = 1'b0;
        cke = 1'b1;
        #(1ns);
        $display("SVREAL TEST SET 4");
        print_signals();
        clk = 1'b1;
        #(1ns);
        $display("SVREAL TEST SET 5");
        print_signals();

        // disable clock
        `SVREAL_SET(d, 4.56);
        clk = 1'b0;
        rst = 1'b0;
        cke = 1'b0;
        #(1ns);
        $display("SVREAL TEST SET 6");
        print_signals();
        clk = 1'b1;
        #(1ns);
        $display("SVREAL TEST SET 7");
        print_signals();

        // print footer
        $display("SVREAL TEST END");
        #(1ns);
    end

endmodule

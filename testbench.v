`timescale 1ns/1ps
// `include "risc_v_processor.v"

module testbench;
    reg clock;
    reg reset;
    
    risc_v_processor uut (
        .clock(clock),
        .reset(reset)
    );

    always #5 clock = ~clock;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);

        clock = 0;
        reset = 1;

        #10 reset = 0;

        #200 $finish;
    end
endmodule

`timescale 1ns/1ps

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
        $dumpvars(0);

        clock = 0;
        reset = 1;

        #10 reset = 0;

        #200 $finish;
    end
endmodule

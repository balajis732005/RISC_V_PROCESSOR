`timescale 1ns/1ps

module risc_v_processor_tb();
    reg clock;
    reg reset;
    
    risc_v_processor uut (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        clock = 0;
        reset = 1;
    end

    always #5 clock = ~clock;

    initial begin
        #10 reset = 0;
        #200 $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
endmodule

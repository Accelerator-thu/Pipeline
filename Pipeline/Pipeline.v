module Pipeline (
    clk,
    reset,
    AN,
    BCD,
    led
);
    input clk;
    input reset;
    output wire [3:0] AN;
    output wire [7:0] BCD;
    output wire [7:0] led;

    Display dsp(clk, display, result, AN, BCD);
    












    
endmodule
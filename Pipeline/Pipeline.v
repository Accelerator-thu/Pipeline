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
    output wire [15:0] led;

    reg [15:0] result;

    Display dsp(clk, display, result, AN, BCD);














    
endmodule
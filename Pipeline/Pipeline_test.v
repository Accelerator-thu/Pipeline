module Pipeline_test ();
    
    reg clk, reset;
    wire [3:0] AN;
    wire [7:0] BCD;
    wire [15:0] led;
    
    Pipeline CPU(clk, reset, AN, BCD, led);
    
    initial begin
        forever begin
            #50 clk = ~clk;
        end
    end
    
    initial begin
        reset      = 1;
        clk        = 1;
        #100 reset = 0;
    end
    
endmodule

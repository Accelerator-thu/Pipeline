module RegIFID (clk,
                reset,
                IPCAdd4,
                IInst,
                CFlush,
                CStall,
                OPCAdd4,
                OInst);
    input clk, reset;
    input [31:0] IPCAdd4, IInst;
    input CFlush, CStall;
    output reg [31:0] OPCAdd4, OInst;
    // Hazard is realized in the overall design of pipeline. Used when deciding the input of IF/ID.
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            OInst <= 32'b0;
        else if (CFlush)
            OInst <= 32'b0;
        else if (!CStall) begin
            OPCAdd4 <= IPCAdd4;
            OInst   <= IInst;
        end
            end
            endmodule

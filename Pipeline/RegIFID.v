module RegIFID (clk,
                reset,
                IPCAdd4,
                IInst,
                CFlush,
                OPCAdd4,
                OInst);
    input clk, reset;
    input [31:0] IPCAdd4, IInst;
    input CFlush;
    output reg [31:0] OPCAdd4, OInst;
    // Hazard is realized in the overall design of pipeline. Used when deciding the input of IF/ID.
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            OPCAdd4 <= 32'b0;
            OInst   <= 32'b0;
            end else begin
            if (CFlush) begin
                OPCAdd4 <= 32'b0;
                OInst   <= 32'b0;
                end else begin
                OPCAdd4 <= IPCAdd4;
                OInst   <= IInst;
            end
        end
    end
    
    
endmodule

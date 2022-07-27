module RegMEMWB (clk,
                 reset,
                 IMemData,
                 IALUOut,
                 IWriteReg,
                 IPCAdd4,
                 ICRegWrite,
                 ICMemtoReg,
                 OMemData,
                 OALUOut,
                 OWriteReg,
                 OPCAdd4,
                 OCRegWrite,
                 OCMemtoReg);
    input clk, reset;
    input [31:0] IMemData, IALUOut, IPCAdd4;
    input [4:0] IWriteReg;
    input [1:0] ICMemtoReg;
    input ICRegWrite;
    // input CFlush;
    output reg [31:0] OMemData, OALUOut, OPCAdd4;
    output reg [4:0] OWriteReg;
    output reg [1:0] OCMemtoReg;
    output reg OCRegWrite;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ICRegWrite <= 0;
            // end else if (CFlush) begin
            // ICRegWrite <= 0;
            end else begin
            OMemData   <= IMemData;
            OALUOut    <= IALUOut;
            OWriteReg  <= IWriteReg;
            OPCAdd4    <= IPCAdd4;
            OCRegWrite <= ICRegWrite;
            OCMemtoReg <= ICMemtoReg;
        end
    end
    
endmodule

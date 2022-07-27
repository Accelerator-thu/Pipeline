module RegMEMWB (clk,
                 reset,
                 IMemData,
                 IALUOut,
                 IWriteReg,
                 ICRegWrite,
                 ICMemtoReg,
                 OMemData,
                 OALUOut,
                 OWriteReg,
                 OCRegWrite,
                 OCMemtoReg);
    input clk, reset;
    input [31:0] IMemData, IALUOut;
    input [4:0] IWriteReg;
    input [1:0] ICMemtoReg;
    input ICRegWrite;
    // input CFlush;
    output reg [31:0] OMemData, OALUOut;
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
            OCRegWrite <= ICRegWrite;
            OCMemtoReg <= ICMemtoReg;
        end
    end
    
endmodule

module RegEXMEM (clk,
                 reset,
                 IALUResult,
                 IMemWrData,
                 IWriteReg,
                 ICRegWrite,
                 ICMemtoReg,
                 ICMemRead,
                 ICMemWrite,
                 OALUResult,
                 OMemWrData,
                 OWriteReg,
                 OCRegWrite,
                 OCMemtoReg,
                 OCMemRead,
                 OCMemWrite);
    input clk, reset;
    input [31:0] IALUResult, IMemWrData;
    input [4:0] IWriteReg;
    input [1:0] ICMemtoReg;
    input ICRegWrite, ICMemRead, ICMemWrite;
    // input CFlush;
    output reg [31:0] OALUResult, OMemWrData;
    output reg [4:0] OWriteReg;
    output reg [1:0] OCMemtoReg;
    output reg OCRegWrite, OCMemRead, OCMemWrite;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            OCRegWrite <= 0;
            OCMemRead  <= 0;
            OCMemWrite <= 0;
            // end else if (CFlush) begin
            // OCRegWrite <= 0;
            // OCMemRead  <= 0;
            // OCMemWrite <= 0;
            end else begin
            OALUResult <= IALUResult;
            OMemWrData <= IMemWrData;
            OWriteReg  <= IWriteReg;
            OCRegWrite <= ICRegWrite;
            OCMemtoReg <= ICMemtoReg;
            OCMemRead  <= ICMemRead;
            OCMemWrite <= ICMemWrite;
        end
    end
    
endmodule

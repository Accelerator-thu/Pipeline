module RegIDEX (clk,
                reset,
                IDataA,
                IDataB,
                IImmExt,
                IRs,
                IRt,
                IRd,
                IShamt,
                ICRegWrite,
                ICMemtoReg,
                ICBranch,
                ICMemRead,
                ICMemWrite,
                ICRegDst,
                ICALUOp,
                ICALUSrc1,
                ICALUSrc2,
                CFlush,
                ODataA,
                ODataB,
                OImmExt,
                ORs,
                ORt,
                ORd,
                OShamt,
                OCRegWrite,
                OCMemtoReg,
                OCBranch,
                OCMemRead,
                OCMemWrite,
                OCRegDst,
                OCALUOp,
                OCALUSrc1,
                OCALUSrc2,
                );
    // I: input; IC: input control; C: control; O: output; OC: output control;
    input clk, reset;
    input [31:0] IDataA, IDataB, IImmExt;
    input [4:0] IRs, IRt, IRd, IShamt;
    input [4:0] ICRegDst;
    input [3:0] ICALUOp;
    input [1:0] ICMemtoReg;
    input ICRegWrite, ICBranch, ICMemRead, ICMemWrite, ICALUSrc1, ICALUSrc2;
    input CFlush;
    output reg [31:0] ODataA, ODataB, OImmExt;
    output reg [4:0] ORs, ORt, ORd, OShamt;
    output reg [4:0] OCRegDst;
    output reg [3:0] OCALUOp;
    output reg [1:0] OCMemtoReg;
    output reg OCRegWrite, OCBranch, OCMemRead, OCMemWrite, OCALUSrc1, OCALUSrc2;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ORs        <= 0;
            ORt        <= 0;
            ORd        <= 0;
            OShamt     <= 0;
            OCRegWrite <= 0;
            OCBranch   <= 0;
            OCMemRead  <= 0;
            OCMemWrite <= 0;
            end else if (CFlush) begin
            ORs        <= 0;
            ORt        <= 0;
            ORd        <= 0;
            OShamt     <= 0;
            OCRegWrite <= 0;
            OCBranch   <= 0;
            OCMemRead  <= 0;
            OCMemWrite <= 0;
            end else begin
            ODataA     <= IDataA;
            ODataB     <= IDataB;
            OImmExt    <= IImmExt;
            ORs        <= IRs;
            ORt        <= IRt;
            ORd        <= IRd;
            OShamt     <= IShamt;
            OCRegWrite <= ICRegWrite;
            OCMemtoReg <= ICMemtoReg;
            OCBranch   <= ICBranch;
            OCMemRead  <= ICMemRead;
            OCMemWrite <= ICMemWrite;
            OCRegDst   <= ICRegDst;
            OCALUOp    <= ICALUOp;
            OCALUSrc1  <= ICALUSrc1;
            OCALUSrc2  <= ICALUSrc2;
        end
    end
    
endmodule

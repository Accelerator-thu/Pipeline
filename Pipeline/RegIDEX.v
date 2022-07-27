module RegIDEX (clk,
                reset,
                IDataA,
                IDataB,
                IImmExt,
                IRs,
                IRt,
                IRd,
                IShamt,
                IPCAdd4,
                ICRegWrite,
                ICMemtoReg,
                ICMemRead,
                ICMemWrite,
                ICRegDst,
                ICALUOp,
                ICALUSrc1,
                ICALUSrc2,
                ICLUOp,
                CFlush,
                ODataA,
                ODataB,
                OImmExt,
                ORs,
                ORt,
                ORd,
                OShamt,
                OPCAdd4,
                OCRegWrite,
                OCMemtoReg,
                OCMemRead,
                OCMemWrite,
                OCRegDst,
                OCALUOp,
                OCALUSrc1,
                OCALUSrc2,
                OCLUOp);
    // I: input; IC: input control; C: control; O: output; OC: output control;
    input clk, reset;
    input [31:0] IDataA, IDataB, IImmExt, IPCAdd4;
    input [4:0] IRs, IRt, IRd, IShamt;
    // input [4:0] ICRegDst;
    input [3:0] ICALUOp;
    input [1:0] ICMemtoReg;
    input ICRegWrite, ICMemRead, ICMemWrite, ICRegDst, ICALUSrc1, ICALUSrc2, ICLUOp;
    input CFlush;
    output reg [31:0] ODataA, ODataB, OImmExt, OPCAdd4;
    output reg [4:0] ORs, ORt, ORd, OShamt;
    // output reg [4:0] OCRegDst;
    output reg [3:0] OCALUOp;
    output reg [1:0] OCMemtoReg;
    output reg OCRegWrite, OCMemRead, OCMemWrite, OCRegDst, OCALUSrc1, OCALUSrc2, OCLUOp;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ORs        <= 0;
            ORt        <= 0;
            ORd        <= 0;
            OShamt     <= 0;
            OCRegWrite <= 0;
            OCMemRead  <= 0;
            OCMemWrite <= 0;
            end else if (CFlush) begin
            ORs        <= 0;
            ORt        <= 0;
            ORd        <= 0;
            OShamt     <= 0;
            OCRegWrite <= 0;
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
            OPCAdd4    <= IPCAdd4;
            OCRegWrite <= ICRegWrite;
            OCMemtoReg <= ICMemtoReg;
            OCMemRead  <= ICMemRead;
            OCMemWrite <= ICMemWrite;
            OCRegDst   <= ICRegDst;
            OCALUOp    <= ICALUOp;
            OCALUSrc1  <= ICALUSrc1;
            OCALUSrc2  <= ICALUSrc2;
            OCLUOp     <= ICLUOp;
        end
    end
    
endmodule

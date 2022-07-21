module RegIDEX (clk,
                reset,
                IDataA,
                IDataB,
                IImmExt,
                IRs,
                IRt,
                IRd,
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
    input [4:0] IRs, IRt, IRd;
    input ICRegWrite, ICMemtoReg, ICBranch, ICMemRead, ICMemWrite, ICRegDst, ICALUOp, ICALUSrc1, ICALUSrc2;
    input CFlush;
    output reg [31:0] ODataA, ODataB, OImmExt;
    output reg [4:0] ORs, ORt, ORd;
    output reg OCRegWrite, OCMemtoReg, OCBranch, OCMemRead, OCMemWrite, OCRegDst, OCALUOp, OCALUSrc1, OCALUSrc2;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            
        end
    end
    
endmodule

module ImmProc (ExtOp,
                LUOp,
                IImm,
                OImm,
                SImm);
    input ExtOp, LUOp;
    input [31:0] IImm;
    output reg [31:0] OImm;
    
    wire [31:0] ExtResult;
    
    assign ExtResult = {ExtOp ? {16{IImm[15]}} : 16'h0000, IImm};
    assign SImm      = ExtResult << 2;
    assign OImm      = LuiOp ? {IImm, 16'h0000} : ExtResult;
    
endmodule

module ImmProc (ExtOp,
                IImm,
                OImm,
                SImm);
    input ExtOp;
    input [15:0] IImm;
    output wire [31:0] OImm, SImm;
    
    wire [31:0] ExtResult;
    
    assign ExtResult = {ExtOp ? {16{IImm[15]}} : 16'h0000, IImm};
    assign OImm      = ExtResult;
    assign SImm      = ExtResult << 2;
    // assign OImm   = LUOp ? {IImm, 16'h0000} : ExtResult;
    
endmodule

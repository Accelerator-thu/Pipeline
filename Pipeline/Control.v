module Control (OpCode,
                Funct,
                RegWrite,
                MemtoReg,
                MemWrite,
                ALUControl,
                ALUSrc1,
                ALUSrc2,
                RegDst,
                Branch,
                BranchType,
                ExtOp,
                LUOp,
                PCSrc);
    input [5:0] OpCode, Funct;
    output reg [1:0] MemtoReg;
    output reg RegWrite, MemWrite, RegDst, Branch;
    
    // OpCode,
    //                 Funct,
    //                 RegWrite,
    //                 MemtoReg,
    //                 MemWrite,
    //                 ALUControl,
    //                 ALUSrc1,
    //                 ALUSrc2,
    //                 RegDst,
    //                 Branch,
    //                 BranchType,
    //                 ExtOp,
    //                 LUOp,
    //                 PCSrc
    
    
    
    
endmodule

module Forward (MEM_RegWrite,
                MEM_WriteReg,
                EX_Rs,
                EX_Rt,
                WB_RegWrite,
                WB_WriteReg,
                EX_ForwardA,
                EX_ForwardB,
                ID_Rs,
                ID_Rt,
                ID_Branch,
                ID_PCSrc,
                MEM_RegWrite,
                MEM_WriteReg,
                ID_ForwardA,
                ID_ForwardB);
    input MEM_RegWrite;
    input [4:0] MEM_WriteReg;
    input [31:0] EX_Rs, EX_Rt;
    input WB_RegWrite;
    input [4:0] WB_WriteReg;
    output [1:0] EX_ForwardA, EX_ForwardB;
    reg [1:0] EX_ForwardA, EX_ForwardB;
    input [31:0] ID_Rs, ID_Rt;
    input ID_Branch, MEM_RegWrite;
    input [1:0] ID_PCSrc;
    input [4:0] MEM_WriteReg;
    output reg ID_ForwardA, ID_ForwardB;
    always@(*)
    begin
        if ((ID_Branch || ID_PCSrc[1]) && MEM_WriteReg && ID_Rs == MEM_WriteReg && MEM_RegWrite)
            ID_ForwardA = 1;
        else
            ID_ForwardA = 0;
        
        if ((ID_Branch || ID_PCSrc[1]) && MEM_WriteReg && ID_Rt == MEM_WriteReg && MEM_RegWrite)
            ID_ForwardB = 1;
        else
            ID_ForwardB = 0;
        
        if (MEM_RegWrite && MEM_WriteReg && MEM_WriteReg == EX_Rs)
            EX_ForwardA = 2'b10;
        else if (WB_RegWrite && WB_WriteReg && WB_WriteReg == EX_Rs && (MEM_WriteReg != EX_Rs || ~MEM_RegWrite))
            EX_ForwardA = 2'b01;
        else
            EX_ForwardA = 2'b00;
        
        if (MEM_RegWrite && MEM_WriteReg && MEM_WriteReg == EX_Rt)
            EX_ForwardB = 2'b10;
        else if (WB_RegWrite && WB_WriteReg && WB_WriteReg == EX_Rt && (MEM_WriteReg != EX_Rt || ~MEM_RegWrite))
            EX_ForwardB = 2'b01;
        else
            EX_ForwardB = 2'b00;
        
    end
endmodule

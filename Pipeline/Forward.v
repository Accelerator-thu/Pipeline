module Forward (ID_Rs,
                ID_Rt,
                ID_Branch,
                ID_PCSrc,
                EX_Rs,
                EX_Rt,
                MEM_RegWrite,
                MEM_WriteReg,
                WB_RegWrite,
                WB_WriteReg,
                EX_ForwardA,
                EX_ForwardB,
                ID_ForwardA,
                ID_ForwardB);
    input [4:0] MEM_WriteReg, WB_WriteReg;
    input [31:0] ID_Rs, ID_Rt, EX_Rs, EX_Rt;
    input [1:0] ID_PCSrc;
    input ID_Branch, MEM_RegWrite, WB_RegWrite;
    output reg [1:0] EX_ForwardA, EX_ForwardB;
    output reg ID_ForwardA, ID_ForwardB;
    always @(*) begin
        if (MEM_WriteReg && (ID_Branch || ID_PCSrc[1]) && MEM_RegWrite && ID_Rs == MEM_WriteReg)
            ID_ForwardA = 1'b1;
        else
            ID_ForwardA = 1'b0;
        
        if (MEM_WriteReg && ID_Branch && MEM_RegWrite && ID_Rt == MEM_WriteReg)
            ID_ForwardB = 1'b1;
        else
            ID_ForwardB = 1'b0;
        
        if (MEM_RegWrite && MEM_WriteReg && MEM_WriteReg == EX_Rs)
            EX_ForwardA = 2'b10;
        else if (WB_RegWrite && WB_WriteReg && WB_WriteReg == EX_Rs && (MEM_RegWrite == 0 || MEM_WriteReg != EX_Rs))
            EX_ForwardA = 2'b01;
        else
            EX_ForwardA = 2'b00;
        
        if (MEM_RegWrite && MEM_WriteReg && MEM_WriteReg == EX_Rt)
            EX_ForwardB = 2'b10;
        else if (WB_RegWrite && WB_WriteReg && WB_WriteReg == EX_Rt && (MEM_RegWrite == 0 || MEM_WriteReg != EX_Rt))
            EX_ForwardB = 2'b01;
        else
            EX_ForwardB = 2'b00;
    end
endmodule

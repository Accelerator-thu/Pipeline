module Hazard(ID_Rs,
              ID_Rt,
              ID_Branch,
              ID_PCSrc,
              EX_RegWrite,
              EX_MemRead,
              EX_WriteReg,
              MEM_MemRead,
              MEM_WriteReg,
              Stall);
    input [4:0] EX_WriteReg, MEM_WriteReg, ID_Rs, ID_Rt;
    input [1:0] ID_PCSrc;
    input ID_Branch, EX_MemRead, EX_RegWrite, MEM_MemRead;
    output reg Stall;
    always @(*) begin
        if (EX_MemRead && (EX_WriteReg == ID_Rs || EX_WriteReg == ID_Rt) ||
            (ID_Branch || ID_PCSrc[1]) && (EX_WriteReg == ID_Rs || EX_WriteReg == ID_Rt) && EX_RegWrite ||
            (ID_Branch || ID_PCSrc[1]) && MEM_MemRead && (MEM_WriteReg == ID_Rs || EX_WriteReg == ID_Rt))
            Stall <= 1;
        else
            Stall <= 0;
    end
    
endmodule

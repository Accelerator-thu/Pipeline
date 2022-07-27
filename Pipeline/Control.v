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
                ExtOp,
                LUOp,
                PCSrc);
    input [5:0] OpCode, Funct;
    output [3:0] ALUControl;
    output [1:0] MemtoReg, PCSrc;
    output RegWrite, MemWrite, RegDst, Branch, ALUSrc1, ALUSrc2, ExtOp, LUOp;
    
    assign ALUControl = {OpCode[0], (OpCode == 6'h00) ? 3'b010 :
    (OpCode == 6'h04) ? 3'b001 :
    (OpCode == 6'h0c) ? 3'b100 :
    (OpCode[5:1] == 5'b00101) ? 3'b101 : 3'b000};
    assign MemtoReg = (OpCode == 6'h23) ? 2'b01 :
    (OpCode == 6'h03 || (OpCode == 6'h00 && Funct == 6'h09)) ? 2'b10 : 2'b00;
    assign PCSrc = (OpCode[5:1] == 5'b00001) ? 2'b01 :
    (OpCode == 6'h00 && Funct[5:1] == 5'b00100) ? 2'b10 : 2'b00;
    assign RegWrite = (OpCode[5:2] == 4'b0001 || OpCode == 6'h2b || (OpCode[5:2] == 4'b0) && (OpCode[1:0] == 2'b01 || OpCode[1:0] == 2'b10) || OpCode == 6'h2b || (OpCode == 0 && Funct == 6'h08)) ? 0 : 1;
    assign MemWrite = (OpCode == 6'h2b) ? 1 : 0;
    assign RegDst = (OpCode == 6'h00) ? 2'b01 :
    (OpCode == 6'h03) ? 2'b10 : 2'b00;
    assign Branch  = (OpCode[5:2] == 4'b0001 || OpCode == 6'h01) ? 1 : 0;
    assign ALUSrc1 = (OpCode == 6'h00 && (Funct == 6'h00 || Funct == 6'h02 || Funct == 6'h03)) ? 1 : 0;
    assign ALUSrc2 = (OpCode == 6'h00 || OpCode == 6'h04) ? 0 : 1;
    assign ExtOp   = (OpCode == 6'h0c) ? 0 : 1;
    assign LUOp    = (OpCode == 6'h0f) ? 1 : 0;
    
endmodule

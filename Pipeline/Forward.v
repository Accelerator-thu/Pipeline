module Forward (FD_OpCode,
                FD_Funct,
                DE_Rt,
                DE_Rs,
                FD_Rs,
                FD_Rt,
                EM_Rt,
                EM_RegWrite,
                MW_RegWrite,
                EM_RegWrAddr,
                MW_RegWrAddr,
                ForwardA,
                ForwardB,
                ForwardC,
                ForwardD,
                ForwardE,
                ForwardF);
    input [5:0] FD_Funct;
    input [5:0] FD_OpCode;
    input [4:0] DE_Rt;
    input [4:0] DE_Rs;
    input [4:0] FD_Rs;
    input [4:0] FD_Rt;
    input [4:0] EM_Rt;
    input EM_RegWrite;
    input MW_RegWrite;
    input [4:0] EM_RegWrAddr;
    input [4:0] MW_RegWrAddr;
    output reg [1:0] ForwardA;
    output reg [1:0] ForwardB;
    output reg [1:0] ForwardC;
    output reg [1:0] ForwardD;
    output reg ForwardE;
    output reg ForwardF;
    
    always @(*) begin
        if (EM_RegWrite && (EM_RegWrAddr ! = 0) && (EM_RegWrAddr == DE_Rs))
            begin ForwardA <= 2'b01; end
        else if (MW_RegWrite && (MW_RegWrAddr ! = 0) && (MW_RegWrAddr == DE_Rs) && ((EM_RegWrAddr ! = DE_Rs) || (~EM_RegWrite)))
            begin ForwardA <= 2'b10; end
        else
            begin ForwardA <= 2'b00; end
        
        if (EM_RegWrite && (EM_RegWrAddr ! = 0) && (EM_RegWrAddr == DE_Rt))
            begin ForwardB <= 2'b01; end
        else if (MW_RegWrite && (MW_RegWrAddr ! = 0) && (MW_RegWrAddr == DE_Rt) && ((EM_RegWrAddr ! = DE_Rt) || (~EM_RegWrite)))
            begin ForwardB <= 2'b10; end
        else
            begin ForwardB <= 2'b00; end
        
        if (EM_RegWrite && (EM_RegWrAddr ! = 0) && EM_RegWrAddr == FD_Rs) //beq系列指令转发
            begin ForwardC <= 2'b01; end
        else if (MW_RegWrite && (MW_RegWrAddr ! = 0) && (MW_RegWrAddr == FD_Rs) && ((EM_RegWrAddr ! = FD_Rs) || (~EM_RegWrite)))
            begin ForwardC <= 2'b10; end
        else
            begin ForwardC <= 2'b00; end
        
        if (EM_RegWrite && (EM_RegWrAddr ! = 0) && EM_RegWrAddr == FD_Rt) //beq系列指令转发
            begin ForwardD <= 2'b01; end
        else if (MW_RegWrite && (MW_RegWrAddr ! = 0) && (MW_RegWrAddr == FD_Rt) && ((EM_RegWrAddr ! = FD_Rt) || (~EM_RegWrite)))
            begin ForwardD <= 2'b10; end
        else
            begin ForwardD <= 2'b00; end
        
        if (EM_RegWrAddr == FD_Rs && (FD_OpCode == 6'h00 && (FD_Funct == 6'h08 || FD_Funct == 6'h09))) //jal接jr
            begin ForwardE <= 1'b1; end
        else
            begin ForwardE <= 1'b0; end
        
        if (MW_RegWrite && (MW_RegWrAddr ! = 0) && (MW_RegWrAddr == EM_Rt)) //sw指令转发
            begin ForwardF <= 1'b1; end
        else
            begin ForwardF <= 1'b0; end
        
    end
endmodule

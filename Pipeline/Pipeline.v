module Pipeline (clk,
                 reset,
                 AN,
                 BCD,
                 led);
    input clk;
    input reset;
    output wire [3:0] AN;
    output wire [7:0] BCD;
    output wire [15:0] led;
    
    reg [15:0] result;
    reg [31:0] PC;
    reg display;
    wire [31:0] subPC, IF_PCadd4, ID_PCadd4, EX_PCadd4, MEM_PCadd4, WB_PCadd4;
    wire [31:0] IF_Inst, ID_Inst;
    wire [31:0] DataBus;
    wire Flush_FD, Flush_DE, Flush_EM, Flush_MW;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC      <= 32'h00400000; // Start of PC;
            display <= 0;
            end else begin
            PC      <= subPC;
            display <= 1;
        end
    end
    
    InstMEM IM(.Address(PC), .Instruction(IF_Inst));
    // 5-stages: F | D | E | M | W
    wire Stall;
    RegIFID FD(clk, reset,
    IF_PCadd4, IF_Inst,
    Flush_FD, Stall,
    ID_PCadd4, ID_Inst);
    wire ID_RegWrite, ID_MemRead, ID_MemWrite, ID_ALUSrc1, ID_ALUSrc2, ID_Branch, ID_ExtOp, ID_LUOp;
    wire [1:0] ID_MemtoReg, ID_RegDst, ID_PCSrc;
    wire [3:0] ID_ALUCtrl;
    Control ctrl(ID_Inst[31:26], ID_Inst[5:0], ID_RegWrite, ID_MemRead, ID_MemtoReg, ID_MemWrite,
    ID_ALUCtrl, ID_ALUSrc1, ID_ALUSrc2, ID_RegDst, ID_Branch, ID_ExtOp, ID_LUOp, ID_PCSrc);
    wire [31:0] WB_WriteData, ID_DataA, ID_DataB, ID_DataAF, ID_DataBF;
    wire [4:0] WB_WriteReg;
    wire zero;
    RegisterFile RF(reset, clk,
    ID_RegWrite, ID_Inst[25:21], ID_Inst[20:16], WB_WriteReg,
    WB_WriteData, ID_DataA, ID_DataB);
    assign ID_DataAF = ID_ForwardA ? MEM_ALUOut : ID_DataA;
    assign ID_DataBF = ID_ForwardB ? MEM_ALUOut : ID_DataB;
    assign zero = (ID_Inst[27:26] == 2'b00) ? (ID_DataAF == ID_DataBF) :
    (ID_Inst[27:26] == 2'b10) ? ~(ID_DataAF > 0) :
    (ID_Inst[27:26] == 2'b11) ? (ID_DataAF > 0) :
    (ID_Inst[28:26] == 3'b101) ? ~(ID_DataAF == ID_DataBF) : (ID_DataAF < 0);
    wire [31:0] ID_ImmExt, ID_ImmExtShift;
    ImmProc imp(ID_ExtOp, ID_Inst[15:0], ID_ImmExt, ID_ImmExtShift);
    wire [31:0] Btgt, Jtgt;
    assign Btgt = ID_PCadd4 + ID_ImmExtShift;
    assign Jtgt = {ID_PCadd4[31:28], ID_Inst[25:0], 2'b00};
    assign subPC = Stall ? PC :
    (ID_Branch & zero) ? Btgt :
    (ID_PCSrc == 2'b01) ? Jtgt :
    (ID_PCSrc == 2'b10) ? ID_DataAF :
    IF_PCadd4;
    assign Flush_FD = ID_PCSrc || ID_Branch && zero && ~Stall;
    wire EX_RegWrite, EX_MemRead, EX_MemWrite, EX_ALUSrc1, EX_ALUSrc2, EX_ExtOp, EX_LUOp;
    wire [1:0] EX_MemtoReg, EX_RegDst, EX_PCSrc;
    wire [3:0] EX_ALUCtrl;
    wire [31:0] EX_DataA, EX_DataB, EX_DataAF, EX_DataBF, EX_ImmExt, EX_LUImm, WB_RegWrData;
    wire [4:0] EX_Rs, EX_Rt, EX_Rd, EX_Shamt;
    RegIDEX DE(clk, reset,
    ID_DataAF, ID_DataBF, ID_ImmExt, ID_Inst[25:21], ID_Inst[20:16], ID_Inst[15:11], ID_Inst[10:6],
    ID_RegWrite, ID_MemtoReg, ID_MemRead, ID_MemWrite, ID_RegDst, ID_ALUCtrl, ID_ALUSrc1, ID_ALUSrc2, ID_LUOp,
    Stall,
    EX_DataA, EX_DataB, EX_ImmExt, EX_Rs, EX_Rt, EX_Rd, EX_Shamt,
    EX_RegWrite, EX_MemtoReg, EX_MemRead, EX_MemWrite, EX_RegDst, EX_ALUCtrl, EX_ALUSrc1, EX_ALUSrc2, EX_LUOp);
    assign EX_Imm = EX_LUOp ? {EX_ImmExt[15:0], 16'h0000} : EX_ImmExt;
    assign EX_DataAF = (EX_ForwardA == 2'b00) ? EX_DataA :
    (EX_ForwardA == 2'b01) ? WB_RegWrData :
    (EX_ForwardA == 2'b10) ? MEM_ALUOut : 32'b0;
    assign EX_DataBF = (EX_ForwardB == 2'b00) ? EX_DataB :
    (EX_ForwardB == 2'b01) ? WB_RegWrData :
    (EX_ForwardB == 2'b10) ? MEM_ALUOut : 32'b0;
    wire [31:0] ALU_in1, ALU_in2;
    assign ALU_in1 = EX_ALUSrc1 ? {27'b0, EX_Shamt} : EX_DataAF;
    assign ALU_in2 = EX_ALUSrc2 ? EX_Imm : EX_DataBF;
    assign EX_WriteReg = (EX_RegDst == 2'b00) ? EX_Rt :
    (EX_RegDst == 2'b01) ? EX_Rd : 5'b11111;
    
    
    RegEXMEM EM(clk, reset,
    EX_ALUResult, EX_MemWrData, EX_WriteReg,
    EX_RegWrite, EX_MemtoReg, EX_MemRead, EX_MemWrite,
    Flush_EM,
    MEM_ALUResult, MEM_MemWrData, MEM_WriteReg,
    MEM_RegWrite, MEM_MemtoReg, MEM_MemRead, MEM_MemWrite);
    RegMEMWB MW(clk, reset,
    MEM_MemData, MEM_ALUOut, MEM_WriteReg,
    MEM_RegWrite, MEM_MemtoReg,
    Flush_MW,
    WB_MemData, WB_ALUOut, WB_WriteReg,
    WB_RegWrite, WB_MemtoReg);
    ALU alu(in1, in2, ALUCtrl, Sign, out);
    ALUControl aluctrl(ALUControl, Funct, ALUOp, sign);
    DataMEM DM(reset, clk,
    Address, Write_data, Read_data, MemRead, MemWrite, led, BCD, AN);
    Display dsp(clk, display, result, AN, BCD);
    Forward fwd(ID_Rs, ID_Rt, ID_Branch, ID_PCSrc, EX_Rs, EX_Rt,
    MEM_RegWrite, MEM_WriteReg, WB_RegWrite, WB_WriteReg,
    EX_ForwardA, EX_ForwardB, ID_ForwardA, ID_ForwardB);
    Hazard hzd(ID_Rs, ID_Rt, ID_Branch, ID_PCSrc,
    EX_RegWrite, EX_MemRead, EX_WriteReg, MEM_MemRead, MEM_WriteReg, Stall);
    
    
endmodule

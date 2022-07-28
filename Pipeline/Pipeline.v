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
//    wire clk;
//    assign clk = clk ^ clk_in;
    reg [31:0] PC;
    reg display;
    wire [15:0] result;
    wire [31:0] subPC, IF_PCadd4, ID_PCadd4, EX_PCadd4, MEM_PCadd4, WB_PCadd4;
    wire [31:0] IF_Inst, ID_Inst;
    wire [31:0] MEM_ALUOut;
    wire Flush_FD, finish;
    wire ID_ForwardA, ID_ForwardB;
    wire [1:0] EX_ForwardA, EX_ForwardB;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC      <= 32'h00400000; // Start of PC;
            display <= 0;
            end else begin
            PC      <= subPC;
            display <= 1;
        end
    end
    assign IF_PCadd4 = PC + 32'd4;
    InstMEM IM(.Address(PC), .Instruction(IF_Inst));
    // 5-stages: F | D | E | M | W
    wire Stall;
    RegIFID FD(clk, reset,
    IF_PCadd4, IF_Inst,
    Flush_FD, Stall,
    ID_PCadd4, ID_Inst);
    wire ID_RegWrite, ID_MemRead, ID_MemWrite, ID_ALUSrc1, ID_ALUSrc2, ID_Branch, ID_ExtOp, ID_LUOp, WB_RegWrite;
    wire [1:0] ID_MemtoReg, ID_RegDst, ID_PCSrc;
    wire [3:0] ID_ALUCtrl;
    Control ctrl(ID_Inst[31:26], ID_Inst[5:0], ID_RegWrite, ID_MemRead, ID_MemtoReg, ID_MemWrite,
    ID_ALUCtrl, ID_ALUSrc1, ID_ALUSrc2, ID_RegDst, ID_Branch, ID_ExtOp, ID_LUOp, ID_PCSrc);
    wire [31:0] WB_RegWrData, ID_DataA, ID_DataB, ID_DataAF, ID_DataBF, F_result;
    wire [4:0] WB_WriteReg;
    wire zero;
    RegisterFile RF(reset, ~clk,
    WB_RegWrite, ID_Inst[25:21], ID_Inst[20:16], WB_WriteReg,
    WB_RegWrData, ID_DataA, ID_DataB, finish, F_result);
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
    reset ? 32'h00400000 : IF_PCadd4;
    assign Flush_FD = ID_PCSrc || ID_Branch && zero && ~Stall;
    wire EX_RegWrite, EX_MemRead, EX_MemWrite, EX_ALUSrc1, EX_ALUSrc2, EX_LUOp;
    wire [1:0] EX_MemtoReg, EX_RegDst;
    wire [3:0] EX_ALUCtrl;
    wire [31:0] EX_DataA, EX_DataB, EX_DataAF, EX_DataBF, EX_ImmExt, EX_Imm, EX_ALUout, EX_Result;
    wire [4:0] EX_Rs, EX_Rt, EX_Rd, EX_Shamt, EX_WriteReg;
    wire [5:0] EX_Funct;
    RegIDEX DE(clk, reset,
    ID_DataAF, ID_DataBF, ID_ImmExt, ID_Inst[25:21], ID_Inst[20:16], ID_Inst[15:11], ID_Inst[10:6], ID_Inst[5:0], ID_PCadd4,
    ID_RegWrite, ID_MemtoReg, ID_MemRead, ID_MemWrite, ID_RegDst, ID_ALUCtrl, ID_ALUSrc1, ID_ALUSrc2, ID_LUOp, F_result,
    Stall,
    EX_DataA, EX_DataB, EX_ImmExt, EX_Rs, EX_Rt, EX_Rd, EX_Shamt, EX_Funct, EX_PCadd4,
    EX_RegWrite, EX_MemtoReg, EX_MemRead, EX_MemWrite, EX_RegDst, EX_ALUCtrl, EX_ALUSrc1, EX_ALUSrc2, EX_LUOp, EX_Result);
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
    wire [4:0] ALUOp;
    wire sign;
    ALUControl aluctrl(EX_ALUCtrl, EX_Funct, ALUOp, sign);
    ALU alu(ALU_in1, ALU_in2, ALUOp, sign, EX_ALUout);
    wire [31:0] MEM_MemWrData, MEM_Result;
    wire [4:0] MEM_WriteReg;
    wire [1:0] MEM_MemtoReg;
    wire MEM_RegWrite, MEM_MemRead, MEM_MemWrite;
    RegEXMEM EM(clk, reset,
    EX_ALUout, EX_DataBF, EX_WriteReg, EX_PCadd4,
    EX_RegWrite, EX_MemtoReg, EX_MemRead, EX_MemWrite, EX_Result,
    // Flush_EM,
    MEM_ALUOut, MEM_MemWrData, MEM_WriteReg, MEM_PCadd4,
    MEM_RegWrite, MEM_MemtoReg, MEM_MemRead, MEM_MemWrite, MEM_Result);
    wire [31:0] MEM_MemData, Address, MEM_MemWriteData;
    wire MEM_MemWriteWL;
    assign Address          = finish ? 32'h40000010 : MEM_ALUOut;
    assign MEM_MemWriteWL   = finish ? 1 : MEM_MemWrite;
    assign MEM_MemWriteData = finish ? MEM_Result : MEM_MemWrData;
    DataMEM DM(reset, clk,
    Address, MEM_MemWriteData, MEM_MemData, MEM_MemRead, MEM_MemWriteWL, led, result);
    wire [31:0] WB_MemData, WB_ALUOut;
    wire [1:0] WB_MemtoReg;
    RegMEMWB MW(clk, reset,
    MEM_MemData, MEM_ALUOut, MEM_WriteReg, MEM_PCadd4,
    MEM_RegWrite, MEM_MemtoReg,
    // Flush_MW,
    WB_MemData, WB_ALUOut, WB_WriteReg, WB_PCadd4,
    WB_RegWrite, WB_MemtoReg);
    assign WB_RegWrData = (WB_MemtoReg == 2'b01) ? WB_MemData :
    (WB_MemtoReg == 2'b10) ? WB_PCadd4 : WB_ALUOut;
    Display dsp(clk, reset, display, result, AN, BCD);
    Forward fwd(ID_Inst[25:21], ID_Inst[20:16], ID_Branch, ID_PCSrc, EX_Rs, EX_Rt,
    MEM_RegWrite, MEM_WriteReg, WB_RegWrite, WB_WriteReg,
    EX_ForwardA, EX_ForwardB, ID_ForwardA, ID_ForwardB);
    Hazard hzd(ID_Inst[25:21], ID_Inst[20:16], ID_Branch, ID_PCSrc,
    EX_RegWrite, EX_MemRead, EX_WriteReg, MEM_MemRead, MEM_WriteReg, Stall);
    
    
endmodule

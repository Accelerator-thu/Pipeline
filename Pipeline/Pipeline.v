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
            PC <= 32'h00400000; // Start of PC;
            end else begin
            PC <= subPC;
        end
    end
    
    InstMEM IM(.Address(PC), .Instruction(IF_Inst));
    // 5-stages: F | D | E | M | W
    RegIFID FD(clk, reset,
    IF_PCadd4, IF_Inst,
    Flush_FD, Stall_FD,
    ID_PCadd4, ID_Inst);
    RegIDEX DE(clk, reset,
    ID_DataA, ID_DataB, ID_ImmExt, ID_Rs, ID_Rt, ID_Rd, ID_Shamt,
    ID_RegWrite, ID_MemtoReg, ID_Branch, ID_MemRead, ID_MemWrite, ID_RegDst, ID_ALUOp, ID_ALUSrc1, ID_ALUSrc2, ID_LUOp,
    Flush_DE,
    EX_DataA, EX_DataB, EX_ImmExt, EX_Rs, EX_Rt, EX_Rd, EX_Shamt,
    EX_RegWrite, EX_MemtoReg, EX_Branch, EX_MemRead, EX_MemWrite, EX_RegDst, EX_ALUOp, EX_ALUSrc1, EX_ALUSrc2, EX_LUOp);
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
    Control ctrl(OpCode, Funct, RegWrite, MemtoReg, MemWrite, ALUControl,
    LUSrc1, ALUSrc2, RegDst, Branch, ExtOp, LUOp, PCSrc);
    DataMEM DM(reset, clk,
    Address, Write_data, Read_data, MemRead, MemWrite, led, BCD, AN);
    Display dsp(clk, display, result, AN, BCD);
    Forward fwd(ID_Rs, ID_Rt, ID_Branch, ID_PCSrc, EX_Rs, EX_Rt,
    MEM_RegWrite, MEM_WriteReg, WB_RegWrite, WB_WriteReg,
    EX_ForwardA, EX_ForwardB, ID_ForwardA, ID_ForwardB);
    Hazard hzd(ID_Rs, ID_Rt, ID_Branch, ID_PCSrc,
    EX_RegWrite, EX_MemRead, EX_WriteReg, MEM_MemRead, MEM_WriteReg, Stall);
    ImmProc imp(ExtOp, LUOp, IImm, OImm, SImm);
    RegisterFile RF(reset, clk,
    RegWrite, Read_register1, Read_register2, Write_register,
    Write_data, Read_data1, Read_data2);
    
    
endmodule

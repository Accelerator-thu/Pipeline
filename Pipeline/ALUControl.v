module ALUControl (ALUControl,
                   Funct,
                   ALUOp,
                   Sign);
    input [5:0] Funct;
    input [3:0] ALUControl;
    output reg [4:0] ALUOp;
    output reg sign;
    
    reg [4:0] ALUCtrl;
    
    assign sign = (ALUControl[2:0] == 3'b010) ? ~Funct[0] : ~ALUControl[0];
    
    // ************************************NOTICE************************************
    // In the following control signals of ALU operations,
    // bits [1:0] denotes the operation executed, 00 for and, 01 for or, 10 for add, 11 for slt,
    // bit [2] denotes whether bnegate is set 1, i.e. whether to use 2's complement as B's input,
    // bit [3] denotes whether A should be inverted,
    // bit [4] denotes whether there is a shift operation involved.
    // ******************************************************************************
    
    parameter andOp = 5'b00000;
    parameter orOp  = 5'b00001;
    parameter addOp = 5'b00010;
    parameter subOp = 5'b00110;
    parameter sltOp = 5'b00111;
    parameter norOp = 5'b01100;
    parameter xorOp = 5'b01101;
    parameter sllOp = 5'b10000;
    parameter srlOp = 5'b11000;
    parameter sraOp = 5'b11001;
    
    always @(*) begin
        casex (ALUControl)
            4'bx010 :
            begin
                casex (Funct)
                    6'b10000x : ALUCtrl <= addOp;
                    6'b10001x : ALUCtrl <= subOp;
                    6'h24 : ALUCtrl     <= andOp;
                    6'h25 : ALUCtrl     <= orOp;
                    6'h26 : ALUCtrl     <= xorOp;
                    6'h27 : ALUCtrl     <= norOp;
                    6'h00 : ALUCtrl     <= sllOp;
                    6'h02 : ALUCtrl     <= srlOp;
                    6'h03 : ALUCtrl     <= sraOp;
                    6'b10101x : ALUCtrl <= sltOp;
                    default: ALUCtrl    <= addOp;
                endcase
            end
            4'bx000 : ALUCtrl <= addOp;
            4'bx001 : ALUCtrl <= subOp;
            4'bx100 : ALUCtrl <= andOp;
            4'bx101 : ALUCtrl <= sltOp;
            default : ALUCtrl <= addOp;
        endcase
        ALUOp <= ALUCtrl
    end
    
endmodule

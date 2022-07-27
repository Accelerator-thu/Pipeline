module ALU(in1,
           in2,
           ALUCtrl,
           Sign,
           out);
    input [31:0] in1, in2;
    input [4:0] ALUCtrl;
    input Sign;
    output reg [31:0] out;
    // zero is not calculated here for better overall performance.
    
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
    
    wire slt_output;
    assign slt_output = (in1[31] == 1 && in2[31] == 0) ? 1 :
    (in1[31] == 0 && in2[31] == 1) ? 0 :
    (in1[30 : 0] < in2[30 : 0]);
    
    always @(*) begin
        case (ALUCtrl)
            andOp : out   <= in1 & in2;
            orOp  : out   <= in1 | in2;
            addOp : out   <= in1 + in2;
            subOp : out   <= in1 - in2;
            sltOp : out   <= {31'h00000000, Sign ? slt_output : (in1 < in2)};
            norOp : out   <= ~(in1 | in2);
            xorOp : out   <= in1 ^ in2;
            sllOp : out   <= (in2 << in1[4 : 0]);
            srlOp : out   <= (in2 >> in1[4 : 0]);
            sraOp : out   <= (($signed(in2)) >>> in1[4 : 0]);
            default : out <= 32'h00000000;
        endcase
        
    end
    
endmodule

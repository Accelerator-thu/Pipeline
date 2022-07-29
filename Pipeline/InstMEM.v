module InstMEM(Address,
               Instruction);
    
    input [31:0] Address;
    output reg [31:0] Instruction;
    
    always @(*) begin
        case (Address[9:2])
            8'd0: Instruction    <= 32'b00100000000010000000000000000000;
            8'd1: Instruction    <= 32'b00100000000010010000000000000000;
            8'd2: Instruction    <= 32'b00100000000011010000000000000000;
            8'd3: Instruction    <= 32'b00100000000010100000000000000000;
            8'd4: Instruction    <= 32'b00000000101000000111000000100000;
            8'd5: Instruction    <= 32'b10001101110011000000000000000000;
            8'd6: Instruction    <= 32'b00010001100000000000000000000011;
            8'd7: Instruction    <= 32'b00100001010010100000000000000001;
            8'd8: Instruction    <= 32'b00100001110011100000000000000100;
            8'd9: Instruction    <= 32'b00001000000100000000000000000101;
            8'd10: Instruction   <= 32'b00000001010000000010000000100000;
            8'd11: Instruction   <= 32'b00100000000010100000000000000000;
            8'd12: Instruction   <= 32'b00000000111000000111000000100000;
            8'd13: Instruction   <= 32'b10001101110011000000000000000000;
            8'd14: Instruction   <= 32'b00010001100000000000000000000011;
            8'd15: Instruction   <= 32'b00100001010010100000000000000001;
            8'd16: Instruction   <= 32'b00100001110011100000000000000100;
            8'd17: Instruction   <= 32'b00001000000100000000000000001101;
            8'd18: Instruction   <= 32'b00000001010000000011000000100000;
            8'd19: Instruction   <= 32'b00100010000100001111111111011100;
            8'd20: Instruction   <= 32'b00000000000010001000000000100001;
            8'd21: Instruction   <= 32'b00000000000010011000100000100001;
            8'd22: Instruction   <= 32'b00000000000010111001000000100001;
            8'd23: Instruction   <= 32'b00000000000011011001100000100001;
            8'd24: Instruction   <= 32'b00000000000001001010000000100001;
            8'd25: Instruction   <= 32'b00000000000001011010100000100001;
            8'd26: Instruction   <= 32'b00000000000001101011000000100001;
            8'd27: Instruction   <= 32'b00000000000001111011100000100001;
            8'd28: Instruction   <= 32'b00000000000111111100000000100001;
            8'd29: Instruction   <= 32'b00000001011000000010000000100000;
            8'd30: Instruction   <= 32'b00000000110000000010100000100000;
            8'd31: Instruction   <= 32'b00000000111000000011000000100000;
            8'd32: Instruction   <= 32'b00001100000100000000000001001100;
            8'd33: Instruction   <= 32'b00000000000100000100000000100001;
            8'd34: Instruction   <= 32'b00000000000100010100100000100001;
            8'd35: Instruction   <= 32'b00000000000100100101100000100001;
            8'd36: Instruction   <= 32'b00000000000100110110100000100001;
            8'd37: Instruction   <= 32'b00000000000101000010000000100001;
            8'd38: Instruction   <= 32'b00000000000101010010100000100001;
            8'd39: Instruction   <= 32'b00000000000101100011000000100001;
            8'd40: Instruction   <= 32'b00000000000101110011100000100001;
            8'd41: Instruction   <= 32'b00000000000110001111100000100001;
            8'd42: Instruction   <= 32'b00000001000001000000100000101010;
            8'd43: Instruction   <= 32'b00010000001000000000000000011110;
            8'd44: Instruction   <= 32'b00000000000010010101000010000000;
            8'd45: Instruction   <= 32'b00000001010001110101000000100000;
            8'd46: Instruction   <= 32'b10001101010010100000000000000000;
            8'd47: Instruction   <= 32'b00000000000010000111000010000000;
            8'd48: Instruction   <= 32'b00000001110001010111000000100000;
            8'd49: Instruction   <= 32'b10001101110011100000000000000000;
            8'd50: Instruction   <= 32'b00000001010011100101000000100010;
            8'd51: Instruction   <= 32'b00010101010000000000000000001101;
            8'd52: Instruction   <= 32'b00000001001001100101000000100010;
            8'd53: Instruction   <= 32'b00100001010010100000000000000001;
            8'd54: Instruction   <= 32'b00010101010000000000000000000111;
            8'd55: Instruction   <= 32'b00100001101011010000000000000001;
            8'd56: Instruction   <= 32'b00100000110011101111111111111111;
            8'd57: Instruction   <= 32'b00000000000011100111000010000000;
            8'd58: Instruction   <= 32'b00000001110010110111000000100000;
            8'd59: Instruction   <= 32'b10001101110010010000000000000000;
            8'd60: Instruction   <= 32'b00100001000010000000000000000001;
            8'd61: Instruction   <= 32'b00001000000100000000000001000000;
            8'd62: Instruction   <= 32'b00100001000010000000000000000001;
            8'd63: Instruction   <= 32'b00100001001010010000000000000001;
            8'd64: Instruction   <= 32'b00001000000100000000000001001001;
            8'd65: Instruction   <= 32'b00000000000010010000100000101010;
            8'd66: Instruction   <= 32'b00010000001000000000000000000101;
            8'd67: Instruction   <= 32'b00100001001011101111111111111111;
            8'd68: Instruction   <= 32'b00000000000011100111000010000000;
            8'd69: Instruction   <= 32'b00000001110010110111000000100000;
            8'd70: Instruction   <= 32'b10001101110010010000000000000000;
            8'd71: Instruction   <= 32'b00001000000100000000000001001001;
            8'd72: Instruction   <= 32'b00100001000010000000000000000001;
            8'd73: Instruction   <= 32'b00001000000100000000000000101010;
            8'd74: Instruction   <= 32'b00000001101000000001000000100000;
            8'd75: Instruction   <= 32'b00001000000100000000000001110010;
            8'd76: Instruction   <= 32'b00100000000010000000000000000001;
            8'd77: Instruction   <= 32'b00100000000010010000000000000000;
            8'd78: Instruction   <= 32'b00010000101000000000000000100001;
            8'd79: Instruction   <= 32'b00100000000011010000000000000000;
            8'd80: Instruction   <= 32'b10101100100011010000000000000000;
            8'd81: Instruction   <= 32'b00000001000001010110100000101010;
            8'd82: Instruction   <= 32'b00010001101000000000000000011011;
            8'd83: Instruction   <= 32'b00000000000010000101100010000000;
            8'd84: Instruction   <= 32'b00000001011001100101100000100000;
            8'd85: Instruction   <= 32'b10001101011010110000000000000000;
            8'd86: Instruction   <= 32'b00000000000010010110000010000000;
            8'd87: Instruction   <= 32'b00000001100001100110000000100000;
            8'd88: Instruction   <= 32'b10001101100011000000000000000000;
            8'd89: Instruction   <= 32'b00000001011011000101100000100010;
            8'd90: Instruction   <= 32'b00010101011000000000000000000111;
            8'd91: Instruction   <= 32'b00000000000010000101100010000000;
            8'd92: Instruction   <= 32'b00000001011001000101100000100000;
            8'd93: Instruction   <= 32'b00100001001011000000000000000001;
            8'd94: Instruction   <= 32'b10101101011011000000000000000000;
            8'd95: Instruction   <= 32'b00100001000010000000000000000001;
            8'd96: Instruction   <= 32'b00100001001010010000000000000001;
            8'd97: Instruction   <= 32'b00001000000100000000000001101101;
            8'd98: Instruction   <= 32'b00000000000010010000100000101010;
            8'd99: Instruction   <= 32'b00010000001000000000000000000101;
            8'd100: Instruction  <= 32'b00100001001011001111111111111111;
            8'd101: Instruction  <= 32'b00000000000011000110000010000000;
            8'd102: Instruction  <= 32'b00000001100001000110000000100000;
            8'd103: Instruction  <= 32'b10001101100010010000000000000000;
            8'd104: Instruction  <= 32'b00001000000100000000000001101101;
            8'd105: Instruction  <= 32'b00000000000010000101100010000000;
            8'd106: Instruction  <= 32'b00000001011001000101100000100000;
            8'd107: Instruction  <= 32'b10101101011000000000000000000000;
            8'd108: Instruction  <= 32'b00100001000010000000000000000001;
            8'd109: Instruction  <= 32'b00001000000100000000000001010001;
            8'd110: Instruction  <= 32'b00100000000000100000000000000000;
            8'd111: Instruction  <= 32'b00000011111000000000000000001000;
            8'd112: Instruction  <= 32'b00100000000000100000000000000001;
            8'd113: Instruction  <= 32'b00000011111000000000000000001000;
            8'd114: Instruction  <= 32'b00001000000100000000000001110010;
            default: Instruction <= 32'b00000000000000000000000000000000;
        endcase
    end
endmodule

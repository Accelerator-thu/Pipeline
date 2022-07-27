module InstMEM(Address,
               Instruction);
    
    input [31:0] Address;
    output reg [31:0] Instruction;
    
    always @(*) begin
        case (Address[9:2])
            8'd0: Instruction    <= 32'h3c011001;
            8'd1: Instruction    <= 32'h34240400;
            8'd2: Instruction    <= 32'h24050000;
            8'd3: Instruction    <= 32'h24060000;
            8'd4: Instruction    <= 32'h2402000d;
            8'd5: Instruction    <= 32'h0000000c;
            8'd6: Instruction    <= 32'h00022021;
            8'd7: Instruction    <= 32'h3c011001;
            8'd8: Instruction    <= 32'h34250000;
            8'd9: Instruction    <= 32'h24060001;
            8'd10: Instruction   <= 32'h24100000;
            8'd11: Instruction   <= 32'h2a080200;
            8'd12: Instruction   <= 32'h11000008;
            8'd13: Instruction   <= 32'h2402000e;
            8'd14: Instruction   <= 32'h0000000c;
            8'd15: Instruction   <= 32'h80a80000;
            8'd16: Instruction   <= 32'h2009000a;
            8'd17: Instruction   <= 32'h11090003;
            8'd18: Instruction   <= 32'h20a50001;
            8'd19: Instruction   <= 32'h22100001;
            8'd20: Instruction   <= 32'h0810000b;
            8'd21: Instruction   <= 32'h3c011001;
            8'd22: Instruction   <= 32'h34250200;
            8'd23: Instruction   <= 32'h24060001;
            8'd24: Instruction   <= 32'h24110000;
            8'd25: Instruction   <= 32'h2a280200;
            8'd26: Instruction   <= 32'h11000008;
            8'd27: Instruction   <= 32'h2402000e;
            8'd28: Instruction   <= 32'h0000000c;
            8'd29: Instruction   <= 32'h80a80000;
            8'd30: Instruction   <= 32'h2009000a;
            8'd31: Instruction   <= 32'h11090003;
            8'd32: Instruction   <= 32'h20a50001;
            8'd33: Instruction   <= 32'h22310001;
            8'd34: Instruction   <= 32'h08100019;
            8'd35: Instruction   <= 32'h24020010;
            8'd36: Instruction   <= 32'h0000000c;
            8'd37: Instruction   <= 32'h00102021;
            8'd38: Instruction   <= 32'h3c011001;
            8'd39: Instruction   <= 32'h34250000;
            8'd40: Instruction   <= 32'h00113021;
            8'd41: Instruction   <= 32'h3c011001;
            8'd42: Instruction   <= 32'h34270200;
            8'd43: Instruction   <= 32'h0c100032;
            8'd44: Instruction   <= 32'h00022021;
            8'd45: Instruction   <= 32'h24020001;
            8'd46: Instruction   <= 32'h0000000c;
            8'd47: Instruction   <= 32'h24040000;
            8'd48: Instruction   <= 32'h24020011;
            8'd49: Instruction   <= 32'h0000000c;
            8'd50: Instruction   <= 32'h240d0000;
            8'd51: Instruction   <= 32'h00044021;
            8'd52: Instruction   <= 32'h00062080;
            8'd53: Instruction   <= 32'h24020009;
            8'd54: Instruction   <= 32'h0000000c;
            8'd55: Instruction   <= 32'h00082021;
            8'd56: Instruction   <= 32'h00029821;
            8'd57: Instruction   <= 32'h001f8821;
            8'd58: Instruction   <= 32'h00059021;
            8'd59: Instruction   <= 32'h00022821;
            8'd60: Instruction   <= 32'h0c10005f;
            8'd61: Instruction   <= 32'h00122821;
            8'd62: Instruction   <= 32'h24080000;
            8'd63: Instruction   <= 32'h24090000;
            8'd64: Instruction   <= 32'h0104082a;
            8'd65: Instruction   <= 32'h1020001b;
            8'd66: Instruction   <= 32'h00e95020;
            8'd67: Instruction   <= 32'h00a85820;
            8'd68: Instruction   <= 32'h814a0000;
            8'd69: Instruction   <= 32'h816b0000;
            8'd70: Instruction   <= 32'h154b000c;
            8'd71: Instruction   <= 32'h20010001;
            8'd72: Instruction   <= 32'h00c16022;
            8'd73: Instruction   <= 32'h152c0006;
            8'd74: Instruction   <= 32'h21ad0001;
            8'd75: Instruction   <= 32'h000c6080;
            8'd76: Instruction   <= 32'h026c6020;
            8'd77: Instruction   <= 32'h8d890000;
            8'd78: Instruction   <= 32'h21080001;
            8'd79: Instruction   <= 32'h08100052;
            8'd80: Instruction   <= 32'h21080001;
            8'd81: Instruction   <= 32'h21290001;
            8'd82: Instruction   <= 32'h0810005c;
            8'd83: Instruction   <= 32'h0009082a;
            8'd84: Instruction   <= 32'h10200006;
            8'd85: Instruction   <= 32'h20010001;
            8'd86: Instruction   <= 32'h01215822;
            8'd87: Instruction   <= 32'h000b5880;
            8'd88: Instruction   <= 32'h01735820;
            8'd89: Instruction   <= 32'h8d690000;
            8'd90: Instruction   <= 32'h0810005c;
            8'd91: Instruction   <= 32'h21080001;
            8'd92: Instruction   <= 32'h08100040;
            8'd93: Instruction   <= 32'h000d1021;
            8'd94: Instruction   <= 32'h02200008;
            8'd95: Instruction   <= 32'h24080001;
            8'd96: Instruction   <= 32'h24090000;
            8'd97: Instruction   <= 32'h20010000;
            8'd98: Instruction   <= 32'h1026001e;
            8'd99: Instruction   <= 32'haca00000;
            8'd100: Instruction  <= 32'h0106502a;
            8'd101: Instruction  <= 32'h20010000;
            8'd102: Instruction  <= 32'h102a0018;
            8'd103: Instruction  <= 32'h01075820;
            8'd104: Instruction  <= 32'h01276020;
            8'd105: Instruction  <= 32'h816b0000;
            8'd106: Instruction  <= 32'h818c0000;
            8'd107: Instruction  <= 32'h156c0006;
            8'd108: Instruction  <= 32'h00085080;
            8'd109: Instruction  <= 32'h00aa5820;
            8'd110: Instruction  <= 32'h21080001;
            8'd111: Instruction  <= 32'h21290001;
            8'd112: Instruction  <= 32'had690000;
            8'd113: Instruction  <= 32'h0810007e;
            8'd114: Instruction  <= 32'h0009082a;
            8'd115: Instruction  <= 32'h10200006;
            8'd116: Instruction  <= 32'h20010001;
            8'd117: Instruction  <= 32'h01214822;
            8'd118: Instruction  <= 32'h00094880;
            8'd119: Instruction  <= 32'h00a94820;
            8'd120: Instruction  <= 32'h8d290000;
            8'd121: Instruction  <= 32'h0810007e;
            8'd122: Instruction  <= 32'h00085080;
            8'd123: Instruction  <= 32'h00aa5020;
            8'd124: Instruction  <= 32'had400000;
            8'd125: Instruction  <= 32'h21080001;
            8'd126: Instruction  <= 32'h08100064;
            8'd127: Instruction  <= 32'h24020000;
            8'd128: Instruction  <= 32'h03e00008;
            8'd129: Instruction  <= 32'h24020001;
            8'd130: Instruction  <= 32'h03e00008;
            default: Instruction <= 32'h00000000;
        endcase
    end
endmodule

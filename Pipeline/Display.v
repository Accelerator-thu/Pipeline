module Display(clk,
               on,
               number,
               AN,
               BCD);
    input clk;
    input on;
    input [15:0] number;
    output wire [7:0] BCD;
    output reg [3:0] AN;
    reg [15:0] cnt;
    reg [3:0] digit;
    reg [1:0] shift;
    
    BCD7 bcd7(digit, BCD);
    
    always @(posedge clk) begin
        cnt <= cnt + 1;
        if (cnt == 50) begin
            cnt   <= 0;
            shift <= shift + 1;
            if (shift == 4) begin
                shift <= 0;
            end
        end
    end
    
    always @(*) begin
        if (on) begin
            case (shift)
                0: begin
                    AN    <= 4'b0111;
                    digit <= number[15:12];
                end
                1: begin
                    AN    <= 4'b1011;
                    digit <= number[11:8];
                end
                2: begin
                    AN    <= 4'b1101;
                    digit <= number[7:4];
                end
                3: begin
                    AN    <= 4'b1110;
                    digit <= number[3:0];
                end
            endcase
            end else begin
            AN    <= 4'b1111;
            digit <= 0;
        end
    end
endmodule

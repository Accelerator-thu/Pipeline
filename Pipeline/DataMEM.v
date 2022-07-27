module DataMEM(reset,
               clk,
               Address,
               Write_data,
               Read_data,
               MemRead,
               MemWrite,
               led,
               BCD,
               AN);
    input reset, clk;
    input [31:0] Address, Write_data;
    input MemRead, MemWrite;
    output [31:0] Read_data;
    output reg [7:0] led;
    output reg [7:0] BCD;
    output reg [3:0] AN;
    parameter RAM_SIZE     = 1024;
    parameter RAM_SIZE_BIT = 32;
    
    reg [31:0] RAM_data[RAM_SIZE - 1: 0];
    assign Read_data = MemRead ? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
    
    integer i;
    always @(posedge reset or posedge clk)
        if (reset) begin
            // string
            RAM_data[0] <= {24'h0, 8'd76 };  // L
            RAM_data[1] <= {24'h0, 8'd105};  // i
            RAM_data[2] <= {24'h0, 8'd110};  // n
            RAM_data[3] <= {24'h0, 8'd117};  // u
            RAM_data[4] <= {24'h0, 8'd120};  // x
            RAM_data[5] <= {24'h0, 8'd32 };  //
            RAM_data[6] <= {24'h0, 8'd105};  // i
            RAM_data[7] <= {24'h0, 8'd115};  // s
            RAM_data[8] <= {24'h0, 8'd32 };  //
            RAM_data[9] <= {24'h0, 8'd78 };  // N
            RAM_data[10] <= {24'h0, 8'd111};  // o
            RAM_data[11] <= {24'h0, 8'd116};  // t
            RAM_data[12] <= {24'h0, 8'd32 };  //
            RAM_data[13] <= {24'h0, 8'd85 };  // U
            RAM_data[14] <= {24'h0, 8'd110};  // n
            RAM_data[15] <= {24'h0, 8'd105};  // i
            RAM_data[16] <= {24'h0, 8'd120};  // x
            RAM_data[17] <= {24'h0, 8'd32 };  //
            RAM_data[18] <= {24'h0, 8'd105};  // i
            RAM_data[19] <= {24'h0, 8'd115};  // s
            RAM_data[20] <= {24'h0, 8'd32 };  //
            RAM_data[21] <= {24'h0, 8'd85 };  // U
            RAM_data[22] <= {24'h0, 8'd110};  // n
            RAM_data[23] <= {24'h0, 8'd105};  // i
            RAM_data[24] <= {24'h0, 8'd120};  // x
            RAM_data[25] <= {24'h0, 8'd32 };  //
            RAM_data[26] <= {24'h0, 8'd105};  // i
            RAM_data[27] <= {24'h0, 8'd115};  // s
            RAM_data[28] <= {24'h0, 8'd32 };  //
            RAM_data[29] <= {24'h0, 8'd85 };  // U
            RAM_data[30] <= {24'h0, 8'd110};  // n
            RAM_data[31] <= {24'h0, 8'd105};  // i
            RAM_data[32] <= {24'h0, 8'd120};  // x
            for (i = 33; i < 256; i = i + 1)
                RAM_data[i] <= 32'b0;
            // pattern
            RAM_data[256] <= {24'h0, 8'd85 };  // U
            RAM_data[257] <= {24'h0, 8'd110};  // n
            RAM_data[258] <= {24'h0, 8'd105};  // i
            RAM_data[259] <= {24'h0, 8'd120};  // x
            for (i = 260; i < RAM_SIZE; i = i + 1)
                RAM_data[i] <= 32'b0;
            led <= 0;
            BCD <= 0;
            AN <= 0;

        end else if (MemWrite) begin
            RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
            
        end
    
endmodule

`timescale 1ns / 1ps

module RegisterFile(reset,
                    clk,
                    RegWrite,
                    Read_register1,
                    Read_register2,
                    Write_register,
                    Write_data,
                    Read_data1,
                    Read_data2,
                    finish,
                    result);
    //Input Clock Signals
    input reset;
    input clk;
    //Input Control Signals
    input RegWrite;
    //Input Data Signals
    input [4:0] Read_register1;
    input [4:0] Read_register2;
    input [4:0] Write_register;
    input [31:0] Write_data;
    //Output Data Signals
    output [31:0] Read_data1;
    output [31:0] Read_data2;
    output [31:0] result;
    output finish;
    
    reg [31:0] RF_data[31:1];
    
    //read data
    assign Read_data1 = (Read_register1 == 5'b00000)? 32'h00000000: RF_data[Read_register1];
    assign Read_data2 = (Read_register2 == 5'b00000)? 32'h00000000: RF_data[Read_register2];
    
    integer i;
    always @(posedge reset or posedge clk) begin
        if (reset) begin
            // for (i = 1; i < 32; i = i + 1) begin
            //     RF_data[i] <= 32'h00000000;
            // end
            RF_data[1]  <= 32'h00000000;
            RF_data[2]  <= 32'h00000000;
            RF_data[3]  <= 32'h00000000;
            RF_data[4]  <= 32'h00000000;
            RF_data[5]  <= 32'h00000000;
            RF_data[6]  <= 32'h00000000;
            RF_data[7]  <= 32'h00000400;
            RF_data[8]  <= 32'h00000000;
            RF_data[9]  <= 32'h00000000;
            RF_data[10] <= 32'h00000000;
            RF_data[11] <= 32'h00000800;
            RF_data[12] <= 32'h00000000;
            RF_data[13] <= 32'h00000000;
            RF_data[14] <= 32'h00000000;
            RF_data[15] <= 32'h00000000;
            RF_data[16] <= 32'h00000000;
            RF_data[17] <= 32'h00000000;
            RF_data[18] <= 32'h00000000;
            RF_data[19] <= 32'h00000000;
            RF_data[20] <= 32'h00000000;
            RF_data[21] <= 32'h00000000;
            RF_data[22] <= 32'h00000000;
            RF_data[23] <= 32'h00000000;
            RF_data[24] <= 32'h00000000;
            RF_data[25] <= 32'h00000000;
            RF_data[26] <= 32'h00000000;
            RF_data[27] <= 32'h00000000;
            RF_data[28] <= 32'h00000000;
            RF_data[29] <= 32'h00000fff;
            RF_data[30] <= 32'h00000000;
            RF_data[31] <= 32'h00000000;
            end else if (RegWrite && (Write_register != 5'b00000)) begin
            RF_data[Write_register] <= Write_data;
        end
    end
    
    assign finish = ~(RF_data[2] == 0);
    assign result = RF_data[2];
    
endmodule
    

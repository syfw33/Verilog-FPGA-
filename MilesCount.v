`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/11 14:39:04
// Design Name: 
// Module Name: MilesCount
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MilesCount(
    input clk,
    input reset,  
    input work,
    input start,
    output reg [15:0] distance
    );
    reg[3:0] cnt;
    always @(posedge clk or posedge reset)      //posedge������  negedge�½���
    begin
        if (reset) begin
            distance <= 16'd0;                  //<=��������ֵ���������λʱ����������
            cnt <= 4'd0;
        end else if (!start && work) begin   
            cnt <= cnt + 1'd1;                  //x.1ʱ��1
            if(cnt == 4'd1) begin
                distance <= distance + 1'd1;
            end else if(cnt == 4'd9) begin
                cnt <= 4'd0;
            end
        end
    end
            
endmodule

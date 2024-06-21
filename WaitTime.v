`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/11 16:00:09
// Design Name: 
// Module Name: WaitTime
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


module WaitTime(
    input clk,
    input reset,
    input start,
    input work,
    output reg [15:0] minute
    );
    reg [5:0] second;
    always@(posedge clk or posedge reset or posedge work) begin
        if (reset) begin
            second <= 6'd0;
            minute <= 16'd0;
        end else if (start && work) begin  
            second <= second + 1'd1;    //x:01Ê±¼Ó1
            if(second == 1'd1) begin
                minute <= minute + 1'd1;
            end else if(second == 6'd59) begin
                second <= 6'd0;
            end 
        end
    end
endmodule

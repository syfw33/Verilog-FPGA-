`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/11 16:21:22
// Design Name: 
// Module Name: top_module
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


module top_module(clk_100m, reset,start,work,seg,dig);
   input clk_100m;                  //时钟频率100MHz，时钟周期10ns
   input reset;                     //复位信号
   input start;                     //等待时间信号，0为跑动，1为等待
   input work;                      //车辆载客信号，1为载客，0为空客
   output reg [7:0] seg = 8'h6d;    
   output reg [3:0] dig = 4'b1110; 
   wire [15:0]distance;            //miles传给fare
   wire [15:0] minute;             //wait_time传给fare
   wire [15:0] fare;               
   wire clk_car;                   //连接div分频器的时钟频率给moiles_count模块
   wire clk_clock;                 //连接div分频器的时钟频率给wait_time模块
   wire clk;
   wire [7:0] seg_res ;
   wire [3:0] dig_res ;          
   div div_init(
        .clk_100m(clk_100m),
        .clk_clock(clk_clock),
        .clk_car(clk_car),
        .clk(clk),
        .reset(reset)
    );
   MilesCount miles_count_init(
        .work(work),
        .clk(clk_car),
        .start(start),
        .reset(reset),
        .distance(distance)
   );
   WaitTime wait_time_init(
        .clk(clk_clock),
        .reset(reset),
        .start(start),
        .work(work),
        .minute(minute)
   );
   Fare fare_init(
        .distance(distance),
        .minute(minute),
        .fare(fare)
   );
   DigitalTube digital_tube_init(
        .work(work),
        .fare(fare),
        .reset(reset),
        .clk(clk),
        .dis(distance),
        .seg(seg_res),
        .dig(dig_res)
   );
   always@(posedge clk) begin
        seg = seg_res;
        dig = dig_res;
   end
endmodule

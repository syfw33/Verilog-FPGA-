`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/11 16:53:22
// Design Name: 
// Module Name: div
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


module div(
    input clk_100m,
    input reset,
    output reg clk_clock,   //ʱ��Ƶ��1hz
    output reg clk_car,     //����Ƶ��0.5hz
    output reg clk          //100hz
    );
    reg [31:0] count_clock;  
    reg [31:0] count_car;    
    reg [31:0] count;
    always @(posedge clk_100m or posedge reset) begin
        if (reset) begin
            clk_clock <= 0;
            clk_car <= 0;
            clk <= 0;
            count_clock <= 0;
            count_car <= 0;
            count <= 0;
        end else begin
            if (count_clock >=  49999999) begin
                count_clock <= 0;      
                clk_clock <= ~clk_clock;  
            end else begin
                count_clock <= count_clock + 1;  
            end
                
            if (count_car >=  49999999) begin
                count_car <= 0;       
                clk_car <= ~clk_car;  
            end else begin
                count_car <= count_car + 1;  
            end
            
            if (count >= 49999) begin
                count <= 0;       
                clk <= ~clk;  
            end else begin
                count <= count + 1;  
            end
        end
    end 
endmodule

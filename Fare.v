`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/11 16:22:45
// Design Name: 
// Module Name: Fare
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


module Fare(
    input [15:0] distance,
    input [15:0] minute,
    output reg [15:0] fare
    );
    always @(*) begin
        if (distance < 3) begin
            fare = 5 + minute;
        end else begin
            fare = minute + 2 * distance - 1;
        end
    end
endmodule

`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 15:11:16
// Design Name: 
// Module Name: DigitalTube
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


module BCDToSevenSegment( //ʮ������תseg
    input [3:0] bcd,
    output reg [7:0] seg  // 8������ܵ������ÿһλ����һ���Σ�0Ϊ��1Ϊ��
);
    always @(bcd) begin
        case (bcd)
            4'h0: seg = 8'h3f;          // 0    
            4'h1: seg = 8'h06;          // 1    
            4'h2: seg = 8'h5b;          // 2    
            4'h3: seg = 8'h4f;          // 3    
            4'h4: seg = 8'h66;          // 4    
            4'h5: seg = 8'h6d;          // 5    
            4'h6: seg = 8'h7d;          // 6    
            4'h7: seg = 8'h07;          // 7    
            4'h8: seg = 8'h7f;          // 8    
            4'h9: seg = 8'h6f;          // 9    
            default: seg = 8'b00000000; // ����ֵ����ʾ
        endcase
    end
endmodule

module DigitalTube(
    input clk,
    input reset,
    input work,
    input [15:0] fare,                                      
    input [15:0] dis,                                     
    output reg [7:0] seg = 8'h3f,   //��ѡ�ź�                
    output reg [3:0] dig = 4'b1110  // λѡ�ź�
);
    reg [15:0] fare_d;
    reg [15:0] dis_d;
    reg [15:0] display_data;
    reg [1:0] digit_index = 2'b00;  // ������������ѡ��ǰ��ʾ�������
    reg [7:0] seg_res = 8'h6d;
    reg [3:0] dig_res = 4'b1110; 
    wire [7:0] seg0, seg1, seg2, seg3;
    wire [3:0] digit0, digit1, digit2, digit3;
    // ��16λ���ݷֽ�Ϊ�ĸ�BCDλ
    assign digit0 = display_data[3:0];
    assign digit1 = display_data[7:4];
    assign digit2 = display_data[11:8];
    assign digit3 = display_data[15:12];
    // BCD��8�ν�����ʵ��
    BCDToSevenSegment seg_decoder0(digit0, seg0);
    BCDToSevenSegment seg_decoder1(digit1, seg1);
    BCDToSevenSegment seg_decoder2(digit2, seg2);
    BCDToSevenSegment seg_decoder3(digit3, seg3);
    always @(*) begin
        dis_d[15:12] <= dis/1000;
        dis_d[11:8] <= (dis/100)%10;
        dis_d[7:4]<=(dis%100)/10;
        dis_d[3:0]<=dis%10;
        fare_d[15:12] <= fare/1000;
        fare_d[11:8] <= (fare/100)%10;
        fare_d[7:4]<=(fare%100)/10;
        fare_d[3:0]<=fare%10;   
    end
    // ����ѡ�����ʾ�����߼�
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            display_data <= 16'd0005;                       // ��λʱ�����ʾ
        end else begin
            if (work == 1'b1) begin
                display_data <= dis_d;                        // ��workΪ1����ʾdis
            end else begin
                display_data <= fare_d;                       // ��workΪ0����ʾfare
            end  
        end
        
    end
    always@ (posedge clk) begin
        if(!reset) begin
            case (digit_index)
                2'b00: begin
                    seg_res <= seg0;
                    dig_res <= 4'b1110;                             // ѡ�е�һ�������
                end
                2'b01: begin
                    seg_res <= seg1;
                    dig_res <= 4'b1101;                             // ѡ�еڶ��������
                end
                2'b10: begin
                    seg_res <= seg2;
                    dig_res <= 4'b1011;                             // ѡ�е����������
                end
                2'b11: begin
                    seg_res <= seg3;
                    dig_res <= 4'b0111;                             // ѡ�е��ĸ������
                end
                default: begin
                    seg_res <= 8'b00000000;
                    dig_res <= 4'b1110;
                end
            endcase
        end else begin
            case (digit_index)
                2'b00: begin
                    seg_res <= 8'h6d;
                    dig_res <= 4'b1110;                             // ѡ�е�һ�������
                end
                2'b01: begin
                    seg_res <= 8'h3f;
                    dig_res <= 4'b1101;                             // ѡ�еڶ��������
                end
                2'b10: begin
                    seg_res <= 8'h3f;
                    dig_res <= 4'b1011;                             // ѡ�е����������
                end
                2'b11: begin
                    seg_res <= 8'h3f;
                    dig_res <= 4'b0111;                             // ѡ�е��ĸ������
                end
               default: begin
                    seg_res <= 8'h3f;
                    dig_res <= 4'b1110;
                end
            endcase
        end
        digit_index <= digit_index + 1'd1;
        seg = seg_res;
        dig = dig_res; 
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module BDS_CA(
    input clk,
    input rst_n,
    input En,
    input [4:0]sv_num,
    output done,
    output BDS_CA
    );
    // 输入数据寄存
    reg En_r;
    reg [4:0] sv_num_r;
    // assign done = En_r;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            En_r <= 1'b0;
            sv_num_r <= 4'd0;
        end
        else begin
            if (En) begin
                En_r <= En;
                sv_num_r <= sv_num;
            end
            else begin
                En_r <= En_r;
                sv_num_r <= sv_num_r;
            end
        end
    end    
    // BDS G1发生器
    reg [11:1] randomREG_G1;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            randomREG_G1 <= 11'b010_1010_1010;
        end
        else begin
            if (En_r) begin
                randomREG_G1[ 1] <= randomREG_G1[11]^randomREG_G1[ 10]^randomREG_G1[9]^randomREG_G1[8]^randomREG_G1[7]^randomREG_G1[1];
                randomREG_G1[ 2] <= randomREG_G1[ 1];
                randomREG_G1[ 3] <= randomREG_G1[ 2];
                randomREG_G1[ 4] <= randomREG_G1[ 3];
                randomREG_G1[ 5] <= randomREG_G1[ 4];
                randomREG_G1[ 6] <= randomREG_G1[ 5];
                randomREG_G1[ 7] <= randomREG_G1[ 6];
                randomREG_G1[ 8] <= randomREG_G1[ 7];
                randomREG_G1[ 9] <= randomREG_G1[ 8];
                randomREG_G1[10] <= randomREG_G1[ 9];
                randomREG_G1[11] <= randomREG_G1[10];
            end
            else begin
                randomREG_G1[ 1] <= randomREG_G1[ 1] ;
                randomREG_G1[ 2] <= randomREG_G1[ 2] ;
                randomREG_G1[ 3] <= randomREG_G1[ 3] ;
                randomREG_G1[ 4] <= randomREG_G1[ 4] ;
                randomREG_G1[ 5] <= randomREG_G1[ 5] ;
                randomREG_G1[ 6] <= randomREG_G1[ 6] ;
                randomREG_G1[ 7] <= randomREG_G1[ 7] ;
                randomREG_G1[ 8] <= randomREG_G1[ 8] ;
                randomREG_G1[ 9] <= randomREG_G1[ 9] ;
                randomREG_G1[10] <= randomREG_G1[10];   
                randomREG_G1[11] <= randomREG_G1[11];     
            end
        end
    end
    wire G1 = randomREG_G1[11];
    // BDS G2移位寄存器
    reg [11:1] randomREG_G2;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            randomREG_G2 <= 11'b010_1010_1010;
        end
        else begin
            if (En_r) begin
                randomREG_G2[ 1] <= randomREG_G2[11]^randomREG_G2[ 9]^randomREG_G2[ 8]^randomREG_G2[ 5]^randomREG_G2[ 4]^randomREG_G2[ 3]^randomREG_G2[ 2]^randomREG_G2[ 1];
                randomREG_G2[ 2] <= randomREG_G2[ 1];
                randomREG_G2[ 3] <= randomREG_G2[ 2];
                randomREG_G2[ 4] <= randomREG_G2[ 3];
                randomREG_G2[ 5] <= randomREG_G2[ 4];
                randomREG_G2[ 6] <= randomREG_G2[ 5];
                randomREG_G2[ 7] <= randomREG_G2[ 6];
                randomREG_G2[ 8] <= randomREG_G2[ 7];
                randomREG_G2[ 9] <= randomREG_G2[ 8];
                randomREG_G2[10] <= randomREG_G2[ 9];
                randomREG_G2[11] <= randomREG_G2[10];
            end
            else begin
                randomREG_G2[ 1] <= randomREG_G2[ 1];
                randomREG_G2[ 3] <= randomREG_G2[ 3];
                randomREG_G2[ 4] <= randomREG_G2[ 4];
                randomREG_G2[ 5] <= randomREG_G2[ 5];
                randomREG_G2[ 6] <= randomREG_G2[ 6];
                randomREG_G2[ 7] <= randomREG_G2[ 7];
                randomREG_G2[ 8] <= randomREG_G2[ 8];
                randomREG_G2[ 9] <= randomREG_G2[ 9];
                randomREG_G2[10] <= randomREG_G2[10];
                randomREG_G2[11] <= randomREG_G2[11];              
            end
        end
    end    
    reg G2;
    // 根据卫星号选择模二加
    always @(*) begin
        case (sv_num_r)
            5'd0 :  G2 = randomREG_G2[1]^randomREG_G2[9];
            5'd1 :  G2 = randomREG_G2[1]^randomREG_G2[10];
            5'd2 :  G2 = randomREG_G2[1]^randomREG_G2[11];
            5'd3 :  G2 = randomREG_G2[2]^randomREG_G2[7];
            5'd4 :  G2 = randomREG_G2[3]^randomREG_G2[4];
            5'd5 :  G2 = randomREG_G2[3]^randomREG_G2[5];
            5'd6 :  G2 = randomREG_G2[3]^randomREG_G2[6];
            5'd7 :  G2 = randomREG_G2[3]^randomREG_G2[8];
            5'd8 :  G2 = randomREG_G2[3]^randomREG_G2[9];
            5'd9 :  G2 = randomREG_G2[3]^randomREG_G2[10];
            5'd10:  G2 = randomREG_G2[3]^randomREG_G2[11];
            5'd11:  G2 = randomREG_G2[4]^randomREG_G2[5];
            5'd12:  G2 = randomREG_G2[4]^randomREG_G2[6];
            5'd13:  G2 = randomREG_G2[4]^randomREG_G2[8];
            5'd14:  G2 = randomREG_G2[4]^randomREG_G2[9];
            5'd15:  G2 = randomREG_G2[4]^randomREG_G2[10];
            5'd16:  G2 = randomREG_G2[4]^randomREG_G2[11];
            5'd17:  G2 = randomREG_G2[5]^randomREG_G2[6];
            5'd18:  G2 = randomREG_G2[5]^randomREG_G2[8];
            5'd19:  G2 = randomREG_G2[5]^randomREG_G2[9];
            5'd20:  G2 = randomREG_G2[5]^randomREG_G2[10];
            5'd21:  G2 = randomREG_G2[5]^randomREG_G2[11];
            5'd22:  G2 = randomREG_G2[6]^randomREG_G2[8];
            5'd23:  G2 = randomREG_G2[6]^randomREG_G2[9];
            5'd24:  G2 = randomREG_G2[6]^randomREG_G2[10];
            5'd25:  G2 = randomREG_G2[6]^randomREG_G2[11];
            5'd26:  G2 = randomREG_G2[8]^randomREG_G2[9];
            5'd27:  G2 = randomREG_G2[8]^randomREG_G2[10];
            5'd28:  G2 = randomREG_G2[8]^randomREG_G2[11];
            5'd29:  G2 = randomREG_G2[9]^randomREG_G2[10];
            5'd30:  G2 = randomREG_G2[9]^randomREG_G2[11];
            5'd31:  G2 = randomREG_G2[10]^randomREG_G2[11];
            default: G2 = 1'b0;
        endcase
    end
    // 对输出进行模二加
    assign BDS_CA = G1 ^ G2;
    // 输出计数器，用来截位第2047位
    reg [10:0] Out_reg;
    // Out_reg 用来0~2046循环
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            Out_reg <= 11'd0;
        end
        else begin
            if (En_r) begin
                if ( Out_reg <= 11'd2045 ) Out_reg <= Out_reg + 1'b1;
                else Out_reg <= 11'd0;
            end
            else begin
                Out_reg <= 11'd0;
            end
        end
    end
    // 输出使能信号，最后一位（第2046位）拉低用来截位最后一位
    assign done = En_r && ( Out_reg <= 2045 );
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 12:59:41 PM
// Design Name: 
// Module Name: fp_posit4_acc
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


module fp_posit4_acc (
    input           clk,
    input           rst,
    input           start,
    input           sign_in,
    input [4:0]     exp_set,
    input [31:0]    fixed_point_acc,
    input [4:0]     exp_in,
    input [13:0]    fixed_point_in,
    input           zero,
    input           NaR,
    output [4:0]    exp_out,
    output [31:0]   fixed_point_out,
    output reg      done,
    output reg      NaR_out
);


wire [4:0] diff;
assign diff = exp_in - exp_set;

reg _sign_in;
reg _zero;
reg [31:0] fixed_point_reg;
reg [4:0] exp_reg;
reg [31:0] fixed_point_in_shifted;
reg shifted;

always @(posedge clk or negedge rst)
    if (!rst) begin
        _zero <= 0;
        NaR_out <= 0;
    end
    else begin
        _zero <= zero;
        NaR_out <= NaR;
    end

always @(posedge clk or negedge rst)
    if (!rst) begin
        fixed_point_reg <= 0;
        done <= 0;
        _sign_in <= 0;
    end
    else if (shifted&&!done) begin
        _sign_in <= sign_in;
        fixed_point_reg <= _zero? fixed_point_acc : (_sign_in? fixed_point_acc - fixed_point_in_shifted: fixed_point_acc + fixed_point_in_shifted);
        shifted <= 0;
        done <= 1;
    end
    else _sign_in <= sign_in;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        fixed_point_in_shifted <= 0;
        exp_reg <= 0;
        shifted <= 0;
    end
    else if (start && !shifted) begin
        done <= 0;
        if (~|diff) begin //If diff == 0
            fixed_point_in_shifted <= fixed_point_in;
        end
        else if (!diff[4]) begin // If exp_set < exp_in, diff[4] would be 0
            fixed_point_in_shifted <= fixed_point_in<<diff;
        end
        else begin // If exp_set > exp_in, diff[4] would be 1
            fixed_point_in_shifted <= fixed_point_in>>-diff; //shift by diff
        end
        shifted <= 1;
        exp_reg <= exp_set;
    end
    else begin
        fixed_point_in_shifted <= fixed_point_in;
        exp_reg <= exp_set;
    end
end

assign fixed_point_out = fixed_point_reg;
assign exp_out = exp_reg;

endmodule

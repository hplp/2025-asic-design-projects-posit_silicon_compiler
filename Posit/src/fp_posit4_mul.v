`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 12:57:36 PM
// Design Name: 
// Module Name: fp_posit4_mul
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

module fp_posit4_mul #(
    parameter ACT_WIDTH = 16,
    parameter EXP_WIDTH = 5,
    parameter MAN_WIDTH = 10
)(
    input                   clk,
    input                   rst,
    input [ACT_WIDTH-1:0]   act,
    input                   w,
    input                   valid, // help identify the length of valid stream
    input                   set, // set = 1 when idle to set precision
    input [3:0]             precision, // Up to 8-bit Posit, es = 0
    output reg              sign_out,
    output reg [4:0]        exp_out,
    output     [13:0]       mantissa_out,
    output reg              done,
    output                  zero_out,
    output                  NaR_out
);

reg                       zero;
reg                       NaR;
reg [ACT_WIDTH-1:0]       _act;
wire                      act_sign;
wire [4:0]                act_exponent;
wire [9:0]                act_mantissa;
wire [10:0]               fixed_mantissa;
reg  [13:0] mantissa_reg, mantissa_temp;
reg   [13:0] shifted_fp;
assign {act_sign, act_exponent, act_mantissa} = act;
assign fixed_mantissa = {1'b1, act_mantissa};

reg [3:0]             _precision;

always @(posedge clk or negedge rst)
    if (!rst) _precision <= 0;
    else if (set) _precision <= precision;

reg [3:0]             count;
reg                   regime_done;
reg                   _regime;
reg                   regime_next;
reg                   regime_sign;
reg [1:0] state;  // 2-bit state register

// Define states
localparam SIGN     = 2'b00;
localparam REGIME   = 2'b01;
localparam MANTISSA = 2'b10;

// Sequential: Update state and signals
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        // state       <= SIGN;
        count       <= 0;
        regime_done <= 0;
        done        <= 0;
        // _act        <= 0;
    end 
    else begin
        if (valid) begin
            // _act <= act;
            if (count<_precision-1) count <= count + 1;
            else begin
                count <= 0;
                done <= 1;
            end
        end
        else begin
            // _act <= _act;
            count <= 0;
        end
    end
end

// Combinational: Define next state logic
always @(*) begin
    case (count)
        4'b0000:  state = SIGN;
        4'b0001:  state = REGIME;
        default:
            if (regime_done) state = MANTISSA;
            else state = REGIME;
    endcase
end

always @(posedge clk or negedge rst)
    if (!rst) begin
        mantissa_reg <= 0;
        mantissa_temp <= 0;
    end
    else if (state == REGIME) mantissa_reg <= fixed_mantissa;
    else if (state == MANTISSA && count<_precision-1) mantissa_reg <= mantissa_out;
    else begin
        mantissa_reg<=0;
        mantissa_temp<=mantissa_reg;
    end

// Output logic
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        done        <= 0;
        regime_done <= 0;
        sign_out    <= 0;
        exp_out     <= 0;
        shifted_fp  <= 0;
        _regime     <= 0;
        zero        <= 0;
        NaR         <= 0;
    end 
    else if (valid) begin
        if (state == SIGN) begin
            sign_out <= act[ACT_WIDTH-1] ^ w;
            done <= 0;
            regime_done <= 0;
            zero <= ~w;
            NaR <= w;
        end
        if (state == REGIME) begin
            _regime <= w;
            zero <= zero & !w;
            NaR <= NaR & !w;
            if (count == 1) regime_sign <= w; // positive if 1, negative if 0
            else if (_regime^w) begin
                regime_done <= 1;
            end
            if (count == _precision-1) begin
                exp_out <= regime_sign? act_exponent+count: act_exponent; 
                done <= 1;
            end
        end
        if (state == MANTISSA) begin
            zero <= 0;
            NaR <= 0;
            if (regime_done) begin 
                regime_done <= 0;
                exp_out <= w? (regime_sign? act_exponent +count - 4 : act_exponent + 1 - count)
                             :(regime_sign? act_exponent +count - 3 : act_exponent + 2 - count); 
                shifted_fp <= w? fixed_mantissa<<1 : 0;
            end
            else begin
                exp_out <= w? exp_out-1: exp_out;
                shifted_fp <= w? fixed_mantissa<<1 : 0;
            end
            if (count == _precision-1) begin
                done        <= 1;
            end 
        end
        else begin
            // done        <= 0;
        end
    end
end

fixed_point_adder fixed_adder(done?mantissa_temp:mantissa_reg, shifted_fp, mantissa_out);
assign zero_out = done&zero;
assign NaR_out  = done&NaR;

endmodule

module fixed_point_adder(
    input      [13:0]  A,
    input      [13:0]  B,
    output     [13:0]  C
);
// This is the intermediate represetation in order to have the least # of rounding at the end of computation.
// The 14-bit fixed point representation consists of 4 bits . 10 bits mantissa
// which is able to hold everything accurately without 
assign C = A + B;
endmodule

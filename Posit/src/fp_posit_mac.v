`timescale 1ns / 1ps

module fp_posit_mac #(
    parameter ACT_WIDTH = 16,
    parameter ACC_WIDTH = 32          // keep 32 unless you also edit fp_posit4_acc
)(
    input                       clk,
    input                       rst,
    input                       valid,
    input  [3:0]                precision,
    input                       set,
    input  [ACT_WIDTH-1:0]      act,
    input  [3:0]                w,            // <-- width fixed
    input  [4:0]                exp_min,
    input  [ACC_WIDTH-1:0]      fixed_point_acc,
    output [4:0]                exp_out,
    output [ACC_WIDTH-1:0]      fixed_point_out,
    output                      done,
    output                      NaR_out
);



        // -----------------------------------------------------------------------------
    // Internal inter-module wiring
    // -----------------------------------------------------------------------------
    wire         start_acc;        // 'done' pulse from multiplier ? 'start' of accumulator
    wire         sign_out;         // multiplier product sign  (1 = negative)
    wire [4:0]   exp_out_mul;      // unbiased exponent from multiplier
    wire [13:0]  mantissa_out;     // 1.13 fixed-point product mantissa
    wire         zero;             // multiplier flags +0
    wire         NaR;              // multiplier flags NaR

    /*------------------------------------------------------------------
     * Multiplier
     *----------------------------------------------------------------*/
    mine #(
        .ACT_WIDTH (ACT_WIDTH)
    ) mul_unit (
        .clk           (clk),
        .rst           (rst),
        .act           (act),
        .w             (w),
        .valid         (valid),
        .set           (set),
        .precision     (precision),
        .sign_out      (sign_out),
        .exp_out       (exp_out_mul),
        .mantissa_out  (mantissa_out),
        .done          (start_acc),         // pulse -> accumulator.start
        .zero_out      (zero),
        .NaR_out       (NaR)
    );

    /*------------------------------------------------------------------
     * Accumulator
     *----------------------------------------------------------------*/
    fp_posit4_acc acc_unit (
        .clk              (clk),
        .rst              (rst),
        .start            (start_acc),
        .sign_in          (sign_out),
        .exp_set          (exp_min),
        .fixed_point_acc  (fixed_point_acc),
        .exp_in           (exp_out_mul),
        .fixed_point_in   (mantissa_out),
        .zero             (zero),
        .NaR              (NaR),
        .exp_out          (exp_out),
        .fixed_point_out  (fixed_point_out),
        .done             (done),
        .NaR_out          (NaR_out)
    );

endmodule



module mine #(
    parameter ACT_WIDTH = 16,
    parameter EXP_WIDTH = 5,
    parameter MAN_WIDTH = 10
)(
    input                   clk,
    input                   rst,
    input  [ACT_WIDTH-1:0]  act,
    input  [3:0]            w,          // posit(4,0), es=0
    input                   valid,
    input                   set,
    input  [3:0]            precision,
    output reg              sign_out,
    output reg [4:0]        exp_out,
    output      [13:0]      mantissa_out,
    output reg              done,
    output                  zero_out,
    output                  NaR_out
);

// -----------------------------------------------------------------------------
//  Internal signals (unchanged)
// -----------------------------------------------------------------------------
reg                       zero, NaR;
wire                      act_sign;
wire [4:0]                act_exponent;
wire [9:0]                act_mantissa;
wire [10:0]               fixed_mantissa;
reg  [13:0]               mantissa_reg, mantissa_temp, shifted_fp;
reg  [3:0]                _precision;
reg  [3:0]                count;
reg                       regime_done, _regime, regime_sign;
reg  [1:0]                state;

assign {act_sign, act_exponent, act_mantissa} = act;
assign fixed_mantissa = {1'b1, act_mantissa};

// Pick one bit per cycle ------------------------------------------------------
wire w_bit = w[_precision - 1 - count];   // MSB-first

// -----------------------------------------------------------------------------
//  Precision latch
// -----------------------------------------------------------------------------
always @(posedge clk or negedge rst)
    if (!rst) _precision <= 0;
    else if (set) _precision <= precision;

// -----------------------------------------------------------------------------
//  Counter and done pulse
// -----------------------------------------------------------------------------
localparam SIGN=2'b00, REGIME=2'b01, MANTISSA=2'b10;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        count <= 0; regime_done <= 0; done <= 0;
    end else if (valid) begin
        if (count < _precision-1) begin
            count <= count + 1;
            done  <= 0;
        end else begin
            count <= 0;
            done  <= 1;
        end
    end else begin
        count <= 0;
        done  <= 0;
    end
end

// -----------------------------------------------------------------------------
//  FSM state derivation (pure combinational)
// -----------------------------------------------------------------------------
always @(*) begin
    case (count)
        4'd0:  state = SIGN;
        4'd1:  state = REGIME;
        default: state = regime_done ? MANTISSA : REGIME;
    endcase
end

// -----------------------------------------------------------------------------
//  Mantissa pipeline stage
// -----------------------------------------------------------------------------
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        mantissa_reg <= 0; mantissa_temp <= 0;
    end else if (state == REGIME) begin
        mantissa_reg <= fixed_mantissa;
    end else if (state == MANTISSA && count < _precision-1) begin
        mantissa_reg <= mantissa_out;
    end else begin
        mantissa_reg <= 0;
        mantissa_temp <= mantissa_reg;
    end
end

// -----------------------------------------------------------------------------
//  Core output / control logic 
// -----------------------------------------------------------------------------
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        sign_out <= 0; exp_out <= 0; shifted_fp <= 0;
        zero <= 0; NaR <= 0; regime_done <= 0; _regime <= 0; 
        regime_sign <= 1;
    end else if (valid) begin
        case (state)
        SIGN: begin
            sign_out <= act[ACT_WIDTH-1] ^ w_bit;
            zero     <= ~w_bit;
            NaR      <=  w_bit;
            exp_out  <= act_exponent;
            regime_done <= 0;
        end
        REGIME: begin
            _regime   <= w_bit;
            zero      <= zero & ~w_bit;
            NaR       <= NaR  & ~w_bit;
            if (count == 1) regime_sign <= w_bit;
            else if (_regime ^ w_bit) regime_done <= 1;
            if (count == _precision-1)
                exp_out <= regime_sign ? (exp_out + count) : exp_out;
        end
        MANTISSA: begin
            zero <= 0; NaR <= 0;
            if (regime_done) begin
                regime_done <= 0;
                exp_out <= w_bit ? (regime_sign ? exp_out + count - 4 : exp_out + 1 - count)
                                   : (regime_sign ? exp_out + count - 3 : exp_out + 2 - count);
                shifted_fp <= w_bit ? fixed_mantissa << 1 : 0;
            end else begin
                exp_out    <= w_bit ? exp_out - 1 : exp_out;
                shifted_fp <= w_bit ? fixed_mantissa << 1 : 0;
            end
        end
        endcase
    end
end

// -----------------------------------------------------------------------------
//  Fixed-point adder
// -----------------------------------------------------------------------------
fixed_point_adder fixed_add (
    .A(done ? mantissa_temp : mantissa_reg),
    .B(shifted_fp),
    .C(mantissa_out)
);

assign zero_out = done & zero;
assign NaR_out  = done & NaR;

endmodule

// -----------------------------------------------------------------------------
module fixed_point_adder (
    input  [13:0] A,
    input  [13:0] B,
    output [13:0] C
);
    assign C = A + B;
endmodule


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


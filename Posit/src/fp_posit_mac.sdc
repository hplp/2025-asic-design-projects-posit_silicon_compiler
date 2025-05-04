# fp_posit_mac.sdc
# Timing constraints for the fp_posit_mac module

#-------------------------------------------------------------------
# 1. Create primary clock
#-------------------------------------------------------------------
# Define a 100 MHz clock on the 'clk' port, with 50% duty cycle
create_clock -name clk \
             -period 10.0 \
             -waveform {0.0 5.0} \
             [get_ports clk]

#-------------------------------------------------------------------
# 2. Input port delays
#-------------------------------------------------------------------
# Specify external input arrival times relative to clk.
# Adjust these numbers to match your board or SoC I/O timing.
set_input_delay  -clock clk  2.0 [get_ports valid]
set_input_delay  -clock clk  2.0 [get_ports set]
set_input_delay  -clock clk  2.0 [get_ports precision]
set_input_delay  -clock clk  2.0 [get_ports act[*]]
set_input_delay  -clock clk  2.0 [get_ports w[*]]
set_input_delay  -clock clk  2.0 [get_ports exp_min[*]]
set_input_delay  -clock clk  2.0 [get_ports fixed_point_acc[*]]

#-------------------------------------------------------------------
# 3. Output port delays
#-------------------------------------------------------------------
# Specify required output launch times relative to clk.
set_output_delay -clock clk  2.0 [get_ports exp_out[*]]
set_output_delay -clock clk  2.0 [get_ports fixed_point_out[*]]
set_output_delay -clock clk  2.0 [get_ports done]
set_output_delay -clock clk  2.0 [get_ports NaR_out]

#-------------------------------------------------------------------
# 4. Asynchronous and false paths
#-------------------------------------------------------------------
# Treat reset as asynchronous: no timing analysis from rst
set_false_path -from [get_ports rst]

#-------------------------------------------------------------------
# 5. Clock uncertainty (jitter)
#-------------------------------------------------------------------
# Account for clock source and distribution jitter
set_clock_uncertainty 0.2 [get_clocks clk]

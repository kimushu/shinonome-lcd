## Generated SDC file "de0nano.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"

## DATE    "Sun Oct 13 13:02:38 2013"

##
## DEVICE  "EP4CE22F17C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {clk_core} -source [get_pins {u_pll|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 8 -divide_by 3 -master_clock {CLOCK_50} [get_pins {u_pll|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {clk_sdr} -source [get_pins {u_pll|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 8 -divide_by 3 -phase -60.000 -master_clock {CLOCK_50} [get_pins {u_pll|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {clk_peri} -source [get_pins {u_pll|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 4 -divide_by 5 -master_clock {CLOCK_50} [get_pins {u_pll|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_peri}] -rise_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_peri}] -fall_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_peri}] -rise_to [get_clocks {clk_core}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_peri}] -fall_to [get_clocks {clk_core}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_peri}] -rise_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_peri}] -fall_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_peri}] -rise_to [get_clocks {clk_core}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_peri}] -fall_to [get_clocks {clk_core}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_core}] -rise_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_core}] -fall_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_core}] -rise_to [get_clocks {clk_core}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_core}] -fall_to [get_clocks {clk_core}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_core}] -rise_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_core}] -fall_to [get_clocks {clk_peri}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_core}] -rise_to [get_clocks {clk_core}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_core}] -fall_to [get_clocks {clk_core}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read}] -to [get_registers {*|alt_jtag_atlantic:*|read1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|tck_t_dav}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [get_registers *]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write}] -to [get_registers {*|alt_jtag_atlantic:*|write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************


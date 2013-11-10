# TCL File Generated by Component Editor 13.0sp1
# Fri Nov 01 00:25:02 JST 2013
# DO NOT MODIFY


# 
# spim_tcm_bridge_miso8 "SPI Master to TCM Bridge (with 8-bit extra MISOs)" v1.0
# kimu_shu 2013.11.01.00:25:02
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module spim_tcm_bridge_miso8
# 
set_module_property DESCRIPTION ""
set_module_property NAME spim_tcm_bridge_miso8
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Qsys Interconnect/Tri-State Components"
set_module_property AUTHOR kimu_shu
set_module_property DISPLAY_NAME "SPI Master to TCM Bridge (with 8-bit extra MISOs)"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL spim_tcm_bridge_miso8
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file spim_tcm_bridge_miso8.vhd VHDL PATH spim_tcm_bridge_miso8.vhd TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter SLAVES INTEGER 1
set_parameter_property SLAVES DEFAULT_VALUE 1
set_parameter_property SLAVES DISPLAY_NAME SLAVES
set_parameter_property SLAVES TYPE INTEGER
set_parameter_property SLAVES UNITS None
set_parameter_property SLAVES ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SLAVES HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clk
# 
add_interface clk clock end
set_interface_property clk clockRate 0
set_interface_property clk ENABLED true
set_interface_property clk EXPORT_OF ""
set_interface_property clk PORT_NAME_MAP ""
set_interface_property clk SVD_ADDRESS_GROUP ""

add_interface_port clk csi_clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clk
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset rsi_reset_n reset_n Input 1


# 
# connection point control_port
# 
add_interface control_port avalon end
set_interface_property control_port addressUnits WORDS
set_interface_property control_port associatedClock clk
set_interface_property control_port associatedReset reset
set_interface_property control_port bitsPerSymbol 8
set_interface_property control_port burstOnBurstBoundariesOnly false
set_interface_property control_port burstcountUnits WORDS
set_interface_property control_port explicitAddressSpan 0
set_interface_property control_port holdTime 0
set_interface_property control_port linewrapBursts false
set_interface_property control_port maximumPendingReadTransactions 0
set_interface_property control_port readLatency 0
set_interface_property control_port readWaitStates 0
set_interface_property control_port readWaitTime 0
set_interface_property control_port setupTime 0
set_interface_property control_port timingUnits Cycles
set_interface_property control_port writeWaitTime 0
set_interface_property control_port ENABLED true
set_interface_property control_port EXPORT_OF ""
set_interface_property control_port PORT_NAME_MAP ""
set_interface_property control_port SVD_ADDRESS_GROUP ""

add_interface_port control_port avs_write write Input 1
add_interface_port control_port avs_writedata writedata Input 8
add_interface_port control_port avs_read read Input 1
add_interface_port control_port avs_readdata readdata Output 8
set_interface_assignment control_port embeddedsw.configuration.isFlash 0
set_interface_assignment control_port embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment control_port embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment control_port embeddedsw.configuration.isPrintableDevice 0


# 
# connection point external
# 
add_interface external conduit end
set_interface_property external associatedClock ""
set_interface_property external associatedReset ""
set_interface_property external ENABLED true
set_interface_property external EXPORT_OF ""
set_interface_property external PORT_NAME_MAP ""
set_interface_property external SVD_ADDRESS_GROUP ""

add_interface_port external coe_MISO export Output 1
add_interface_port external coe_MOSI export Input 1
add_interface_port external coe_SCLK export Input 1
add_interface_port external coe_SS_n export Input slaves


# 
# connection point tcm
# 
add_interface tcm tristate_conduit start
set_interface_property tcm associatedClock clk
set_interface_property tcm ENABLED true
set_interface_property tcm EXPORT_OF ""
set_interface_property tcm PORT_NAME_MAP ""
set_interface_property tcm SVD_ADDRESS_GROUP ""

add_interface_port tcm tcm_miso_in miso_in Input 8
add_interface_port tcm tcm_miso_out miso_out Output 8
add_interface_port tcm tcm_miso_outen miso_outen Output 1
add_interface_port tcm tcm_mosi_out mosi_out Output 1
add_interface_port tcm tcm_ss_n_out ss_n_out Output slaves
add_interface_port tcm tcm_grant grant Input 1
add_interface_port tcm tcm_request request Output 1
add_interface_port tcm tcm_sclk_out sclk_out Output 1

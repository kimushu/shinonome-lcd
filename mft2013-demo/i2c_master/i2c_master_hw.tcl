# TCL File Generated by Component Editor 13.0sp1
# Sat Oct 12 19:01:49 JST 2013
# DO NOT MODIFY


# 
# i2c_master "OpenCores I2C Master" v1.0
# Richard Herveille 2013.10.12.19:01:49
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module i2c_master
# 
set_module_property DESCRIPTION ""
set_module_property NAME i2c_master
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Interface Protocols/Serial"
set_module_property AUTHOR "Richard Herveille"
set_module_property DISPLAY_NAME "OpenCores I2C Master"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL i2c_master_top
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file i2c_master_bit_ctrl.vhd VHDL PATH i2c_master_bit_ctrl.vhd
add_fileset_file i2c_master_byte_ctrl.vhd VHDL PATH i2c_master_byte_ctrl.vhd
add_fileset_file i2c_master_top.vhd VHDL PATH i2c_master_top.vhd TOP_LEVEL_FILE


# 
# documentation links
# 
add_documentation_link origin http://opencores.org/project,i2c,overview


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock wb_clk_i clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset wb_rst_i reset Input 1


# 
# connection point areset
# 
add_interface areset reset end
set_interface_property areset associatedClock ""
set_interface_property areset synchronousEdges NONE
set_interface_property areset ENABLED true
set_interface_property areset EXPORT_OF ""
set_interface_property areset PORT_NAME_MAP ""
set_interface_property areset SVD_ADDRESS_GROUP ""

add_interface_port areset arst_i reset_n Input 1


# 
# connection point wbs
# 
add_interface wbs conduit end
set_interface_property wbs associatedClock clock
set_interface_property wbs associatedReset reset
set_interface_property wbs ENABLED true
set_interface_property wbs EXPORT_OF ""
set_interface_property wbs PORT_NAME_MAP ""
set_interface_property wbs SVD_ADDRESS_GROUP ""

add_interface_port wbs wb_dat_i dat_w Input 8
add_interface_port wbs wb_dat_o dat_r Output 8
add_interface_port wbs wb_we_i we Input 1
add_interface_port wbs wb_stb_i stb Input 1
add_interface_port wbs wb_cyc_i cyc Input 1
add_interface_port wbs wb_ack_o ack Output 1
add_interface_port wbs wb_adr_i adr Input 3


# 
# connection point i2cbus
# 
add_interface i2cbus conduit end
set_interface_property i2cbus associatedClock clock
set_interface_property i2cbus associatedReset reset
set_interface_property i2cbus ENABLED true
set_interface_property i2cbus EXPORT_OF ""
set_interface_property i2cbus PORT_NAME_MAP ""
set_interface_property i2cbus SVD_ADDRESS_GROUP ""

add_interface_port i2cbus scl_pad_i scl_in Input 1
add_interface_port i2cbus scl_pad_o scl_out Output 1
add_interface_port i2cbus sda_pad_i sda_in Input 1
add_interface_port i2cbus sda_padoen_o sda_outen Output 1
add_interface_port i2cbus sda_pad_o sda_out Output 1
add_interface_port i2cbus scl_padoen_o scl_outen Output 1


# 
# connection point int
# 
add_interface int interrupt end
set_interface_property int associatedAddressablePoint ""
set_interface_property int associatedClock clock
set_interface_property int associatedReset reset
set_interface_property int ENABLED true
set_interface_property int EXPORT_OF ""
set_interface_property int PORT_NAME_MAP ""
set_interface_property int SVD_ADDRESS_GROUP ""

add_interface_port int wb_inta_o irq Output 1


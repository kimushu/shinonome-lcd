#
# spim_tcm_bridge_miso8_sw.tcl
#

# Create a new driver
create_driver spim_tcm_bridge_driver

# Associate it with some hardware known as "spim_tcm_bridge_miso8"
set_sw_property hw_class_name spim_tcm_bridge_miso8

# The version of this driver
set_sw_property version 1.0
set_sw_property min_compatible_hw_version 1.0

# Do not initialize the driver in alt_sys_init()
set_sw_property auto_initialize true

# location in generated BSP that above sources will be copied into
set_sw_property bsp_subdirectory drivers

# Interrupt properties:
# (No interrupt in current version)

# Source file listings:
add_sw_property c_source HAL/src/spim_tcm_bridge.c
add_sw_property include_source HAL/inc/spim_tcm_bridge_miso8.h
add_sw_property include_source inc/spim_tcm_bridge_regs.h

# This driver supports HAL & UCOSII BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII

# End of file

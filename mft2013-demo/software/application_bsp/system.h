/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_main' in SOPC Builder design 'de0nano_nios2'
 * SOPC Builder design path: ../../de0nano_nios2.sopcinfo
 *
 * Generated: Sun Nov 10 00:39:19 JST 2013
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0xfff0820
#define ALT_CPU_CPU_FREQ 133333333u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1d
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x20
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 133333333
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x1c
#define ALT_CPU_NAME "nios2_main"
#define ALT_CPU_RESET_ADDR 0xfff0000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0xfff0820
#define NIOS2_CPU_FREQ 133333333u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1d
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x20
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x1c
#define NIOS2_RESET_ADDR 0xfff0000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_EPCS_FLASH_CONTROLLER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SPI
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_GENERIC_TRISTATE_CONTROLLER
#define __ALTERA_NIOS2_QSYS
#define __AVS_WBM_BRIDGE
#define __MANDELBROT_FLOAT
#define __MMCDMA
#define __SPIM_TCM_BRIDGE_MISO8


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x10000008
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x10000008
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x10000008
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "de0nano_nios2"


/*
 * epcs configuration
 *
 */

#define ALT_MODULE_CLASS_epcs altera_avalon_epcs_flash_controller
#define EPCS_BASE 0xfff0000
#define EPCS_IRQ 0
#define EPCS_IRQ_INTERRUPT_CONTROLLER_ID 0
#define EPCS_NAME "/dev/epcs"
#define EPCS_REGISTER_OFFSET 1024
#define EPCS_SPAN 2048
#define EPCS_TYPE "altera_avalon_epcs_flash_controller"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER_TICK
#define ALT_TIMESTAMP_CLK none


/*
 * i2c_master_bridge configuration
 *
 */

#define ALT_MODULE_CLASS_i2c_master_bridge avs_wbm_bridge
#define I2C_MASTER_BRIDGE_BASE 0x10000070
#define I2C_MASTER_BRIDGE_IRQ -1
#define I2C_MASTER_BRIDGE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define I2C_MASTER_BRIDGE_NAME "/dev/i2c_master_bridge"
#define I2C_MASTER_BRIDGE_SPAN 8
#define I2C_MASTER_BRIDGE_TYPE "avs_wbm_bridge"


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x10000008
#define JTAG_UART_IRQ 1
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * lcd configuration
 *
 */

#define ALT_MODULE_CLASS_lcd altera_generic_tristate_controller
#define LCD_BASE 0x10000080
#define LCD_IRQ -1
#define LCD_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LCD_NAME "/dev/lcd"
#define LCD_SPAN 2
#define LCD_TYPE "altera_generic_tristate_controller"


/*
 * mb_float configuration
 *
 */

#define ALT_MODULE_CLASS_mb_float mandelbrot_float
#define MB_FLOAT_BASE 0xf000000
#define MB_FLOAT_IRQ -1
#define MB_FLOAT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MB_FLOAT_NAME "/dev/mb_float"
#define MB_FLOAT_SPAN 32
#define MB_FLOAT_TYPE "mandelbrot_float"


/*
 * mmcdma configuration
 *
 */

#define ALT_MODULE_CLASS_mmcdma mmcdma
#define MMCDMA_BASE 0x10000400
#define MMCDMA_IRQ 3
#define MMCDMA_IRQ_INTERRUPT_CONTROLLER_ID 0
#define MMCDMA_NAME "/dev/mmcdma"
#define MMCDMA_SPAN 1024
#define MMCDMA_TYPE "mmcdma"


/*
 * pio_dipsw configuration
 *
 */

#define ALT_MODULE_CLASS_pio_dipsw altera_avalon_pio
#define PIO_DIPSW_BASE 0x10000060
#define PIO_DIPSW_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_DIPSW_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_DIPSW_CAPTURE 0
#define PIO_DIPSW_DATA_WIDTH 4
#define PIO_DIPSW_DO_TEST_BENCH_WIRING 1
#define PIO_DIPSW_DRIVEN_SIM_VALUE 15
#define PIO_DIPSW_EDGE_TYPE "NONE"
#define PIO_DIPSW_FREQ 40000000
#define PIO_DIPSW_HAS_IN 1
#define PIO_DIPSW_HAS_OUT 0
#define PIO_DIPSW_HAS_TRI 0
#define PIO_DIPSW_IRQ -1
#define PIO_DIPSW_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_DIPSW_IRQ_TYPE "NONE"
#define PIO_DIPSW_NAME "/dev/pio_dipsw"
#define PIO_DIPSW_RESET_VALUE 0
#define PIO_DIPSW_SPAN 16
#define PIO_DIPSW_TYPE "altera_avalon_pio"


/*
 * pio_gpio0hi configuration
 *
 */

#define ALT_MODULE_CLASS_pio_gpio0hi altera_avalon_pio
#define PIO_GPIO0HI_BASE 0x10000110
#define PIO_GPIO0HI_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_GPIO0HI_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_GPIO0HI_CAPTURE 0
#define PIO_GPIO0HI_DATA_WIDTH 2
#define PIO_GPIO0HI_DO_TEST_BENCH_WIRING 0
#define PIO_GPIO0HI_DRIVEN_SIM_VALUE 0
#define PIO_GPIO0HI_EDGE_TYPE "NONE"
#define PIO_GPIO0HI_FREQ 40000000
#define PIO_GPIO0HI_HAS_IN 0
#define PIO_GPIO0HI_HAS_OUT 0
#define PIO_GPIO0HI_HAS_TRI 1
#define PIO_GPIO0HI_IRQ -1
#define PIO_GPIO0HI_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_GPIO0HI_IRQ_TYPE "NONE"
#define PIO_GPIO0HI_NAME "/dev/pio_gpio0hi"
#define PIO_GPIO0HI_RESET_VALUE 0
#define PIO_GPIO0HI_SPAN 16
#define PIO_GPIO0HI_TYPE "altera_avalon_pio"


/*
 * pio_gpio0in configuration
 *
 */

#define ALT_MODULE_CLASS_pio_gpio0in altera_avalon_pio
#define PIO_GPIO0IN_BASE 0x10000120
#define PIO_GPIO0IN_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_GPIO0IN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_GPIO0IN_CAPTURE 0
#define PIO_GPIO0IN_DATA_WIDTH 2
#define PIO_GPIO0IN_DO_TEST_BENCH_WIRING 0
#define PIO_GPIO0IN_DRIVEN_SIM_VALUE 0
#define PIO_GPIO0IN_EDGE_TYPE "NONE"
#define PIO_GPIO0IN_FREQ 40000000
#define PIO_GPIO0IN_HAS_IN 1
#define PIO_GPIO0IN_HAS_OUT 0
#define PIO_GPIO0IN_HAS_TRI 0
#define PIO_GPIO0IN_IRQ -1
#define PIO_GPIO0IN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_GPIO0IN_IRQ_TYPE "NONE"
#define PIO_GPIO0IN_NAME "/dev/pio_gpio0in"
#define PIO_GPIO0IN_RESET_VALUE 0
#define PIO_GPIO0IN_SPAN 16
#define PIO_GPIO0IN_TYPE "altera_avalon_pio"


/*
 * pio_gpio0lo configuration
 *
 */

#define ALT_MODULE_CLASS_pio_gpio0lo altera_avalon_pio
#define PIO_GPIO0LO_BASE 0x10000100
#define PIO_GPIO0LO_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_GPIO0LO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_GPIO0LO_CAPTURE 0
#define PIO_GPIO0LO_DATA_WIDTH 32
#define PIO_GPIO0LO_DO_TEST_BENCH_WIRING 0
#define PIO_GPIO0LO_DRIVEN_SIM_VALUE 0
#define PIO_GPIO0LO_EDGE_TYPE "NONE"
#define PIO_GPIO0LO_FREQ 40000000
#define PIO_GPIO0LO_HAS_IN 0
#define PIO_GPIO0LO_HAS_OUT 0
#define PIO_GPIO0LO_HAS_TRI 1
#define PIO_GPIO0LO_IRQ -1
#define PIO_GPIO0LO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_GPIO0LO_IRQ_TYPE "NONE"
#define PIO_GPIO0LO_NAME "/dev/pio_gpio0lo"
#define PIO_GPIO0LO_RESET_VALUE 0
#define PIO_GPIO0LO_SPAN 16
#define PIO_GPIO0LO_TYPE "altera_avalon_pio"


/*
 * pio_gpio1hi configuration
 *
 */

#define ALT_MODULE_CLASS_pio_gpio1hi altera_avalon_pio
#define PIO_GPIO1HI_BASE 0x10000140
#define PIO_GPIO1HI_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_GPIO1HI_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_GPIO1HI_CAPTURE 0
#define PIO_GPIO1HI_DATA_WIDTH 2
#define PIO_GPIO1HI_DO_TEST_BENCH_WIRING 0
#define PIO_GPIO1HI_DRIVEN_SIM_VALUE 0
#define PIO_GPIO1HI_EDGE_TYPE "NONE"
#define PIO_GPIO1HI_FREQ 40000000
#define PIO_GPIO1HI_HAS_IN 0
#define PIO_GPIO1HI_HAS_OUT 0
#define PIO_GPIO1HI_HAS_TRI 1
#define PIO_GPIO1HI_IRQ -1
#define PIO_GPIO1HI_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_GPIO1HI_IRQ_TYPE "NONE"
#define PIO_GPIO1HI_NAME "/dev/pio_gpio1hi"
#define PIO_GPIO1HI_RESET_VALUE 0
#define PIO_GPIO1HI_SPAN 16
#define PIO_GPIO1HI_TYPE "altera_avalon_pio"


/*
 * pio_gpio1in configuration
 *
 */

#define ALT_MODULE_CLASS_pio_gpio1in altera_avalon_pio
#define PIO_GPIO1IN_BASE 0x10000150
#define PIO_GPIO1IN_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_GPIO1IN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_GPIO1IN_CAPTURE 0
#define PIO_GPIO1IN_DATA_WIDTH 2
#define PIO_GPIO1IN_DO_TEST_BENCH_WIRING 0
#define PIO_GPIO1IN_DRIVEN_SIM_VALUE 0
#define PIO_GPIO1IN_EDGE_TYPE "NONE"
#define PIO_GPIO1IN_FREQ 40000000
#define PIO_GPIO1IN_HAS_IN 1
#define PIO_GPIO1IN_HAS_OUT 0
#define PIO_GPIO1IN_HAS_TRI 0
#define PIO_GPIO1IN_IRQ -1
#define PIO_GPIO1IN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_GPIO1IN_IRQ_TYPE "NONE"
#define PIO_GPIO1IN_NAME "/dev/pio_gpio1in"
#define PIO_GPIO1IN_RESET_VALUE 0
#define PIO_GPIO1IN_SPAN 16
#define PIO_GPIO1IN_TYPE "altera_avalon_pio"


/*
 * pio_gpio2in configuration
 *
 */

#define ALT_MODULE_CLASS_pio_gpio2in altera_avalon_pio
#define PIO_GPIO2IN_BASE 0x10000170
#define PIO_GPIO2IN_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_GPIO2IN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_GPIO2IN_CAPTURE 0
#define PIO_GPIO2IN_DATA_WIDTH 3
#define PIO_GPIO2IN_DO_TEST_BENCH_WIRING 0
#define PIO_GPIO2IN_DRIVEN_SIM_VALUE 0
#define PIO_GPIO2IN_EDGE_TYPE "NONE"
#define PIO_GPIO2IN_FREQ 40000000
#define PIO_GPIO2IN_HAS_IN 1
#define PIO_GPIO2IN_HAS_OUT 0
#define PIO_GPIO2IN_HAS_TRI 0
#define PIO_GPIO2IN_IRQ -1
#define PIO_GPIO2IN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_GPIO2IN_IRQ_TYPE "NONE"
#define PIO_GPIO2IN_NAME "/dev/pio_gpio2in"
#define PIO_GPIO2IN_RESET_VALUE 0
#define PIO_GPIO2IN_SPAN 16
#define PIO_GPIO2IN_TYPE "altera_avalon_pio"


/*
 * pio_led configuration
 *
 */

#define ALT_MODULE_CLASS_pio_led altera_avalon_pio
#define PIO_LED_BASE 0x10000040
#define PIO_LED_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LED_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LED_CAPTURE 0
#define PIO_LED_DATA_WIDTH 8
#define PIO_LED_DO_TEST_BENCH_WIRING 0
#define PIO_LED_DRIVEN_SIM_VALUE 0
#define PIO_LED_EDGE_TYPE "NONE"
#define PIO_LED_FREQ 40000000
#define PIO_LED_HAS_IN 0
#define PIO_LED_HAS_OUT 1
#define PIO_LED_HAS_TRI 0
#define PIO_LED_IRQ -1
#define PIO_LED_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_LED_IRQ_TYPE "NONE"
#define PIO_LED_NAME "/dev/pio_led"
#define PIO_LED_RESET_VALUE 0
#define PIO_LED_SPAN 16
#define PIO_LED_TYPE "altera_avalon_pio"


/*
 * pio_pushsw configuration
 *
 */

#define ALT_MODULE_CLASS_pio_pushsw altera_avalon_pio
#define PIO_PUSHSW_BASE 0x10000050
#define PIO_PUSHSW_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_PUSHSW_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_PUSHSW_CAPTURE 0
#define PIO_PUSHSW_DATA_WIDTH 2
#define PIO_PUSHSW_DO_TEST_BENCH_WIRING 1
#define PIO_PUSHSW_DRIVEN_SIM_VALUE 3
#define PIO_PUSHSW_EDGE_TYPE "NONE"
#define PIO_PUSHSW_FREQ 40000000
#define PIO_PUSHSW_HAS_IN 1
#define PIO_PUSHSW_HAS_OUT 0
#define PIO_PUSHSW_HAS_TRI 0
#define PIO_PUSHSW_IRQ -1
#define PIO_PUSHSW_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_PUSHSW_IRQ_TYPE "NONE"
#define PIO_PUSHSW_NAME "/dev/pio_pushsw"
#define PIO_PUSHSW_RESET_VALUE 0
#define PIO_PUSHSW_SPAN 16
#define PIO_PUSHSW_TYPE "altera_avalon_pio"


/*
 * sdram configuration
 *
 */

#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x0
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 8
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/sdram"
#define SDRAM_POWERUP_DELAY 200.0
#define SDRAM_REFRESH_PERIOD 7.8125
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x18
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 9
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 33554432
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.4
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 18.0
#define SDRAM_T_RFC 60.0
#define SDRAM_T_RP 18.0
#define SDRAM_T_WR 14.0


/*
 * spim_adc configuration
 *
 */

#define ALT_MODULE_CLASS_spim_adc altera_avalon_spi
#define SPIM_ADC_BASE 0x100000c0
#define SPIM_ADC_CLOCKMULT 1
#define SPIM_ADC_CLOCKPHASE 0
#define SPIM_ADC_CLOCKPOLARITY 0
#define SPIM_ADC_CLOCKUNITS "Hz"
#define SPIM_ADC_DATABITS 8
#define SPIM_ADC_DATAWIDTH 16
#define SPIM_ADC_DELAYMULT "1.0E-9"
#define SPIM_ADC_DELAYUNITS "ns"
#define SPIM_ADC_EXTRADELAY 0
#define SPIM_ADC_INSERT_SYNC 0
#define SPIM_ADC_IRQ 6
#define SPIM_ADC_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SPIM_ADC_ISMASTER 1
#define SPIM_ADC_LSBFIRST 0
#define SPIM_ADC_NAME "/dev/spim_adc"
#define SPIM_ADC_NUMSLAVES 1
#define SPIM_ADC_PREFIX "spi_"
#define SPIM_ADC_SPAN 32
#define SPIM_ADC_SYNC_REG_DEPTH 2
#define SPIM_ADC_TARGETCLOCK 2000000u
#define SPIM_ADC_TARGETSSDELAY "0.0"
#define SPIM_ADC_TYPE "altera_avalon_spi"


/*
 * spim_gpio2 configuration
 *
 */

#define ALT_MODULE_CLASS_spim_gpio2 altera_avalon_spi
#define SPIM_GPIO2_BASE 0x100000a0
#define SPIM_GPIO2_CLOCKMULT 1
#define SPIM_GPIO2_CLOCKPHASE 0
#define SPIM_GPIO2_CLOCKPOLARITY 0
#define SPIM_GPIO2_CLOCKUNITS "Hz"
#define SPIM_GPIO2_DATABITS 8
#define SPIM_GPIO2_DATAWIDTH 16
#define SPIM_GPIO2_DELAYMULT "1.0E-9"
#define SPIM_GPIO2_DELAYUNITS "ns"
#define SPIM_GPIO2_EXTRADELAY 0
#define SPIM_GPIO2_INSERT_SYNC 0
#define SPIM_GPIO2_IRQ 5
#define SPIM_GPIO2_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SPIM_GPIO2_ISMASTER 1
#define SPIM_GPIO2_LSBFIRST 0
#define SPIM_GPIO2_NAME "/dev/spim_gpio2"
#define SPIM_GPIO2_NUMSLAVES 1
#define SPIM_GPIO2_PREFIX "spi_"
#define SPIM_GPIO2_SPAN 32
#define SPIM_GPIO2_SYNC_REG_DEPTH 2
#define SPIM_GPIO2_TARGETCLOCK 1000000u
#define SPIM_GPIO2_TARGETSSDELAY "0.0"
#define SPIM_GPIO2_TYPE "altera_avalon_spi"


/*
 * spim_tcm_bridge configuration
 *
 */

#define ALT_MODULE_CLASS_spim_tcm_bridge spim_tcm_bridge_miso8
#define SPIM_TCM_BRIDGE_BASE 0x10000090
#define SPIM_TCM_BRIDGE_IRQ -1
#define SPIM_TCM_BRIDGE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SPIM_TCM_BRIDGE_NAME "/dev/spim_tcm_bridge"
#define SPIM_TCM_BRIDGE_SPAN 1
#define SPIM_TCM_BRIDGE_TYPE "spim_tcm_bridge_miso8"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x10000000
#define SYSID_ID 0
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1384011125
#define SYSID_TYPE "altera_avalon_sysid_qsys"


/*
 * timer_tick configuration
 *
 */

#define ALT_MODULE_CLASS_timer_tick altera_avalon_timer
#define TIMER_TICK_ALWAYS_RUN 1
#define TIMER_TICK_BASE 0x10000020
#define TIMER_TICK_COUNTER_SIZE 32
#define TIMER_TICK_FIXED_PERIOD 1
#define TIMER_TICK_FREQ 40000000
#define TIMER_TICK_IRQ 2
#define TIMER_TICK_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_TICK_LOAD_VALUE 39999
#define TIMER_TICK_MULT 0.0010
#define TIMER_TICK_NAME "/dev/timer_tick"
#define TIMER_TICK_PERIOD 1
#define TIMER_TICK_PERIOD_UNITS "ms"
#define TIMER_TICK_RESET_OUTPUT 0
#define TIMER_TICK_SNAPSHOT 0
#define TIMER_TICK_SPAN 32
#define TIMER_TICK_TICKS_PER_SEC 1000.0
#define TIMER_TICK_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_TICK_TYPE "altera_avalon_timer"

#endif /* __SYSTEM_H_ */

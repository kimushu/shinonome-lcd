/**
 * @file gpio_lcd.c
 * @brief MCP23S08 control functions
 * @author kimu_shu
 * @note This file is distributed under The MIT License. See LICENSE for details.
 */

#include <io.h>
#include <system.h>
#include <altera_avalon_spi.h>
#include <spim_tcm_bridge_miso8.h>
#include "gpio_lcd.h"

/**
 * @fn gpio_lcd_reg_read
 * @brief Read MCP23S08's register
 * @param reg   [in] Register address
 * @return Read value
 */
alt_u8 gpio_lcd_reg_read(alt_u8 reg)
{
	alt_u8 wdata[2];
	alt_u8 rdata[1];

	spim_tcm_bridge_acquire(LCD_GPIO_SPIM_TCM_BRIDGE_BASE, 1);

	// Issue command
	wdata[0] = 0x41;
	wdata[1] = reg;
	alt_avalon_spi_command(LCD_GPIO_SPI_BASE, 0, 2, wdata, 1, rdata, 0);

	spim_tcm_bridge_release(LCD_GPIO_SPIM_TCM_BRIDGE_BASE);

	return rdata[0];
}

/**
 * @fn gpio_lcd_reg_write
 * @brief Write MCP23S08's register
 * @param reg   [in] Register address
 * @param value [in] Value to be written
 */
void gpio_lcd_reg_write(alt_u8 reg, alt_u8 value)
{
	alt_u8 wdata[3];

	spim_tcm_bridge_acquire(LCD_GPIO_SPIM_TCM_BRIDGE_BASE, 1);

	// Issue command
	wdata[0] = 0x40;
	wdata[1] = reg;
	wdata[2] = value;
	alt_avalon_spi_command(LCD_GPIO_SPI_BASE, 0, 3, wdata, 0, 0, 0);

	spim_tcm_bridge_release(LCD_GPIO_SPIM_TCM_BRIDGE_BASE);
}

/**
 * @fn gpio_lcd_reg_modify
 * @brief Read-modify-write MCP23S08's register
 * @param reg   [in] Register address
 * @param clear [in] Clear mask (1=Clear,0=Preserve)
 * @param set   [in] Set mask (1=Set,0=Preserve)
 */
void gpio_lcd_reg_modify(alt_u8 reg, alt_u8 clear, alt_u8 set)
{
	alt_u8 data[3];

	spim_tcm_bridge_acquire(LCD_GPIO_SPIM_TCM_BRIDGE_BASE, 1);

	// Issue command (read)
	data[0] = 0x41;
	data[1] = reg;
	alt_avalon_spi_command(LCD_GPIO_SPI_BASE, 0, 2, data, 1, data + 2, 0);
	data[0] = 0x40;
	data[2] &= ~clear;
	data[2] |= set;
	alt_avalon_spi_command(LCD_GPIO_SPI_BASE, 0, 3, data, 0, 0, 0);

	spim_tcm_bridge_release(LCD_GPIO_SPIM_TCM_BRIDGE_BASE);
}


/**
 * @file gpio_lcd.h
 * @brief Header of MCP23S08 control functions
 * @author kimu_shu
 * @note This file is distributed under The MIT License. See LICENSE for details.
 */

#ifndef GPIO_LCD_H_
#define GPIO_LCD_H_

#include <io.h>

#define LCDBRD_SHINONOME_REV_1_1

#ifdef LCDBRD_SHINONOME_REV_1_1
#define LCD_GPIO_SPI_BASE				SPIM_GPIO2_BASE
#define LCD_GPIO_SPIM_TCM_BRIDGE_BASE	SPIM_TCM_BRIDGE_BASE
#define LCD_GPIO_GPIO0		0
#define LCD_GPIO_GPIO1		1
#define LCD_GPIO_RESET_N	2
#define LCD_GPIO_BACKLIGHT	3
#define LCD_GPIO_XP			4
#define LCD_GPIO_XN			5
#define LCD_GPIO_YP			6
#define LCD_GPIO_YN			7
#else
#error "Unknown LCD board!"
#endif

#define REG_IODIR		0x00
#define REG_GPIO		0x09
#define REG_OLAT		0x0a

extern alt_u8 gpio_lcd_reg_read(alt_u8 reg);
extern void gpio_lcd_reg_write(alt_u8 reg, alt_u8 value);
extern void gpio_lcd_reg_modify(alt_u8 reg, alt_u8 clear, alt_u8 set);

#define gpio_lcd_output(pin)	gpio_lcd_reg_modify(REG_IODIR, (1<<(pin)), 0)
#define gpio_lcd_input(pin)		gpio_lcd_reg_modify(REG_IODIR, 0, (1<<(pin)))
#define gpio_lcd_low(pin)		gpio_lcd_reg_modify(REG_OLAT, (1<<(pin)), 0)
#define gpio_lcd_high(pin)		gpio_lcd_reg_modify(REG_OLAT, 0, (1<<(pin)))
#define gpio_lcd_readall()		(gpio_lcd_reg_read(REG_GPIO))
#define gpio_lcd_read(pin)		(gpio_lcd_readall() & (1<<(pin)))

#endif /* GPIO_LCD_H_ */

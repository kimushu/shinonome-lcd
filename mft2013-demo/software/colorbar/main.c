/**
 * @file main.c
 * @brief Color-bar and simple GPIO/ADIN sample
 * @author kimu_shu
 * @note This file is distributed under The MIT License. See LICENSE for details.
 */

#include <system.h>
#include <io.h>
#include <string.h>
#include <altera_avalon_pio_regs.h>
#include <altera_avalon_spi.h>
#include "lcd.h"
#include "delay.h"
#include "gpio_lcd.h"

#define DEMO_MODE()	(IORD_ALTERA_AVALON_PIO_DATA(PIO_DIPSW_BASE) & 0xf)
enum
{
	DEMO_COLORBAR,
	DEMO_BOARDNAME,
	DEMO_SHOWINPUTS,
	DEMO_MAXNUMBER,
};

const char tohex[] = "0123456789ABCDEF";

static void demo_colorbar(void);
static void demo_boardname(void);
static void demo_showinputs(void);

int main(void)
{
	lcd_backlight(0);
	lcd_init();
	lcd_rect(0, 0, LCD_WIDTH, LCD_HEIGHT, COLOR_BLACK);
	lcd_backlight(1);

	while(1)
	{
		switch(DEMO_MODE())
		{
		case DEMO_COLORBAR:
			demo_colorbar();
			break;
		case DEMO_BOARDNAME:
			demo_boardname();
			break;
		case DEMO_SHOWINPUTS:
			demo_showinputs();
			break;
		default:
			lcd_rect(0, 0, LCD_WIDTH, LCD_HEIGHT, COLOR_BLACK);
			lcd_puts("NOT IMPLEMENTED. CHANGE DIP-SW!", 10, 10, COLOR_WHITE, COLOR_RED);
			while(DEMO_MODE() >= DEMO_MAXNUMBER);
			break;
		}
	}

	while(1);
}

static void demo_colorbar(void)
{
	// Full-field color bar
	lcd_rect(0, LCD_HEIGHT*0/7, LCD_WIDTH, LCD_HEIGHT*1/7, COLOR_WHITE);
	lcd_rect(0, LCD_HEIGHT*1/7, LCD_WIDTH, LCD_HEIGHT*2/7, COLOR_YELLOW);
	lcd_rect(0, LCD_HEIGHT*2/7, LCD_WIDTH, LCD_HEIGHT*3/7, COLOR_CYAN);
	lcd_rect(0, LCD_HEIGHT*3/7, LCD_WIDTH, LCD_HEIGHT*4/7, COLOR_GREEN);
	lcd_rect(0, LCD_HEIGHT*4/7, LCD_WIDTH, LCD_HEIGHT*5/7, COLOR_MAGENTA);
	lcd_rect(0, LCD_HEIGHT*5/7, LCD_WIDTH, LCD_HEIGHT*6/7, COLOR_RED);
	lcd_rect(0, LCD_HEIGHT*6/7, LCD_WIDTH, LCD_HEIGHT*7/7, COLOR_BLUE);
	while(DEMO_MODE() == DEMO_COLORBAR);
}

static void demo_boardname(void)
{
	lcd_rect(0, 0, LCD_WIDTH, LCD_HEIGHT, COLOR_BLACK);
	lcd_puts(
			"Shinonome LCD board (Rev.1.1)\r\n"
			"by @kimu_shu", 10, 10,
			COLOR_BLUE, COLOR_BLACK);
	while(DEMO_MODE() == DEMO_BOARDNAME);
}

static void demo_showinputs(void)
{
	int channel;
	alt_u8 temp[4] = {0};
	char text[64];
	lcd_rect(0, 0, LCD_WIDTH, LCD_HEIGHT, COLOR_WHITE);
	do
	{
		strcpy(text,
				"GPIO0 = 0\r\n"	// 8
				"GPIO1 = 0\r\n"	// 19
				"GPI2  = 0\r\n");	// 30
		temp[0] = gpio_lcd_readall();
		text[ 8] += (temp[0] >> 0) & 1;
		text[19] += (temp[0] >> 1) & 1;
		text[30] += (IORD_ALTERA_AVALON_PIO_DATA(PIO_GPIO2IN_BASE) >> 2) & 1;
		lcd_puts(text, 10, 10, COLOR_BLACK, COLOR_WHITE);

		strcpy(text, "AIN0  = 0x--- (with *P driver)");
		temp[0] = temp[1] = 0;

		for(channel = 0; channel < 8; ++channel)
		{
			if(channel < 4)
				text[13] = 0;
			else if(channel < 6)
			{
				// Drive YP and YN
				gpio_lcd_reg_modify(REG_OLAT, (1<<LCD_GPIO_YN), (1<<LCD_GPIO_YP));
				gpio_lcd_reg_modify(REG_IODIR, (1<<LCD_GPIO_YN)|(1<<LCD_GPIO_YP), 0);
				text[13] = ' ';
				text[20] = 'Y';
			}
			else
			{
				// Drive XP and XN
				gpio_lcd_reg_modify(REG_OLAT, (1<<LCD_GPIO_XN), (1<<LCD_GPIO_XP));
				gpio_lcd_reg_modify(REG_IODIR, (1<<LCD_GPIO_XN)|(1<<LCD_GPIO_XP), 0);
				text[13] = ' ';
				text[20] = 'X';
			}
			temp[0] = (channel << 3);
			alt_avalon_spi_command(SPIM_ADC_BASE, 0, 2, temp, 2, temp + 2, 0);

			if(channel >= 4)
			{
				// Turn off X/Y driver
				gpio_lcd_reg_modify(REG_IODIR, 0, (1<<LCD_GPIO_XN)|(1<<LCD_GPIO_XP)|
						(1<<LCD_GPIO_YN)|(1<<LCD_GPIO_YP));
			}

			text[3] = '0' + channel;
			text[10] = tohex[(temp[2] >> 0) & 0xf];
			text[11] = tohex[(temp[3] >> 4) & 0xf];
			text[12] = tohex[(temp[3] >> 0) & 0xf];
			lcd_puts(text, 10, 60 + 10 * channel, COLOR_BLACK, COLOR_WHITE);
		}
	}
	while(DEMO_MODE() == DEMO_SHOWINPUTS);
}

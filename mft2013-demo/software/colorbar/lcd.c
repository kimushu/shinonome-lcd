/*
 * NOTICE: LCD initialization codes are based on ili932x.c by Nemuisan.
 * See LICENSE file.
 */
/**
 * @file lcd.c
 * @brief TS8026Y control functions
 * @author kimu_shu
 * @note This file is distributed under MIT License. See LICENSE for details.
 */

#include <io.h>
#include <system.h>
#include "font.h"
#include "lcd.h"
#include "gpio_lcd.h"
#include "delay.h"

alt_u16 lcd_read(alt_u8 address)
{
	alt_u8 high;
	lcd_write_address(address);
	high = IORD_8DIRECT(LCD_BASE, 1);
	return (high << 8) | IORD_8DIRECT(LCD_BASE, 1);
}

void lcd_init(void)
{
#ifdef LCD_TS8026Y
	gpio_lcd_output(LCD_GPIO_RESET_N);
	gpio_lcd_low(LCD_GPIO_RESET_N);
	mdelay(10);
	gpio_lcd_high(LCD_GPIO_RESET_N);
	mdelay(10);

	lcd_write(0xff, 0x0001);
	lcd_write(0xf3, 0x0008);
	lcd_write(0xf3, 0x0008);

	lcd_write(0x01, 0x0100);
	lcd_write(0x02, 0x0700);
	lcd_write(0x03, LCD_ENTRYMODE);
	lcd_write(0x08, 0x0302);
	lcd_write(0x09, 0x0000);
	lcd_write(0x0a, 0x0000);

	lcd_write(0x10, 0x0790);
	lcd_write(0x11, 0x0005);
	lcd_write(0x12, 0x0000);
	lcd_write(0x13, 0x0000);

	mdelay(100);
	lcd_write(0x10, 0x12b0);
	mdelay(50);
	lcd_write(0x11, 0x0007);
	mdelay(50);

	lcd_write(0x12, 0x008c);
	lcd_write(0x13, 0x1700);
	lcd_write(0x29, 0x0022);
	mdelay(50);

	lcd_write(0x30, 0x0000);
	lcd_write(0x31, 0x0505);
	lcd_write(0x32, 0x0205);
	lcd_write(0x35, 0x0206);
	lcd_write(0x36, 0x0408);
	lcd_write(0x37, 0x0000);
	lcd_write(0x38, 0x0504);
	lcd_write(0x39, 0x0206);
	lcd_write(0x3c, 0x0206);
	lcd_write(0x3d, 0x0408);

	lcd_write(0x60, 0xa700);
	lcd_write(0x61, 0x0001);
	lcd_write(0x90, 0x0033);
	lcd_write(0x07, 0x0133);
	mdelay(50);

	lcd_write(0x50, 0);
	lcd_write(0x51, 239);
	lcd_write(0x52, 0);
	lcd_write(0x53, 319);

#endif
}

void lcd_backlight(int on)
{
#ifdef LCD_TS8026Y
	if(on)
		gpio_lcd_high(LCD_GPIO_BACKLIGHT);
	else
		gpio_lcd_low(LCD_GPIO_BACKLIGHT);
	gpio_lcd_output(LCD_GPIO_BACKLIGHT);
#endif
}

void lcd_putchar(char ch, int x, int y, alt_u16 fc, alt_u16 bc)
{
	FONT_WORDTYPE line;
	int ix, iy;

	if(ch < ' ' || ch > '~') ch = '?';

	for(iy = 0; iy < FONT_HEIGHT; ++iy, ++y)
	{
		line = font[ch - ' '][iy];
		lcd_write(0x20, LCD_SX(x, y));
		lcd_write(0x21, LCD_SY(x, y));
		lcd_write(0x20, LCD_SX(x, y));
		lcd_write(0x21, LCD_SY(x, y));
		lcd_write_address(0x22);
		for(ix = 0; ix < FONT_WIDTH; ++ix, line <<= 1)
		{
			if(line & (1<<(sizeof(FONT_WORDTYPE)*8-1)))
				lcd_write_data(fc);
			else
				lcd_write_data(bc);
		}
	}
}

void lcd_puts(const char *str, int x, int y, alt_u16 fc, alt_u16 bc)
{
	char ch;
	int x2;

	for(x2 = x; (ch = *str) != 0; ++str, x2 += FONT_WIDTH)
	{
		switch(ch)
		{
		case '\r':
			x2 = x - FONT_WIDTH;
			break;
		case '\n':
			y += FONT_HEIGHT;
			x2 -= FONT_WIDTH;
			break;
		default:
			lcd_putchar(ch, x2, y, fc, bc);
			break;
		}
	}
}

void lcd_rect(int x1, int y1, int x2, int y2, alt_u16 color)
{
	if(x1 >= x2 || y1 >= y2) return;
#if (LCD_ROTATE == 0 || LCD_ROTATE == 2)
	lcd_write(0x50, x1);
	lcd_write(0x51, x2-1);
	lcd_write(0x52, y1);
	lcd_write(0x53, y2-1);
#else
	lcd_write(0x50, y1);
	lcd_write(0x51, y2-1);
	lcd_write(0x52, x1);
	lcd_write(0x53, x2-1);
#endif
	lcd_write(0x20, LCD_SX(x1, y1));
	lcd_write(0x21, LCD_SY(x1, y1));
	lcd_write_address(0x22);
	for(; y1 < y2; ++y1)
	{
		int x;
		for(x = x1; x < x2; ++x) lcd_write_data(color);
	}
	lcd_write(0x50, 0);
	lcd_write(0x51, 239);
	lcd_write(0x52, 0);
	lcd_write(0x53, 319);
}

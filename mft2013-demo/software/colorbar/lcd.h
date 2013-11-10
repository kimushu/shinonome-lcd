/**
 * @file lcd.h
 * @brief Header of TS8026Y control functions
 * @author kimu_shu
 * @note This file is distributed under The MIT License. See LICENSE for details.
 */

#ifndef LCD_H_
#define LCD_H_

#include <io.h>
#include <system.h>

#define LCD_TS8026Y			// Shinonome-LCD Board Rev.1.1

#define COLOR_BLACK			0x0000
#define COLOR_GRAY			0x8410
#define COLOR_WHITE			0xffff

#define COLOR_BLUE			0x001f
#define COLOR_GREEN			0x07e0
#define COLOR_RED			0xf800
#define COLOR_YELLOW		0xffe0
#define COLOR_MAGENTA		0xf81f
#define COLOR_CYAN			0x07ff

#define LCD_ROTATE			0	/* Rotation of viewport (see below) */
/*
 * | No# | Description                       | ID | AM |
 * +-----+-----------------------------------+----+----+
 * |  0  | Portrait  (FPC is the downside)   | 11 |  0 |
 * |  1  | Landscape (FPC is the right side) | 10 |  1 |
 * |  2  | Portrait  (FPC is the upside)     | 00 |  0 |
 * |  3  | Landscape (FPC is the left side)  | 01 |  1 |
 */

#if (LCD_ROTATE == 0)
#  define LCD_ENTRYMODE	0x1130	// AM=0b,ID=11b
#  define LCD_WIDTH		240
#  define LCD_HEIGHT	320
#  define LCD_SX(x,y)	(x)
#  define LCD_SY(x,y)	(y)
#elif (LCD_ROTATE == 1)
#  define LCD_ENTRYMODE	0x1128	// AM=1b,ID=10b
#  define LCD_WIDTH		320
#  define LCD_HEIGHT	240
#  define LCD_SX(x,y)	(LCD_HEIGHT-(y)-1)
#  define LCD_SY(x,y)	(x)
#elif (LCD_ROTATE == 2)
#  define LCD_ENTRYMODE	0x1100	// AM=0b,ID=00b
#  define LCD_WIDTH		240
#  define LCD_HEIGHT	320
#  define LCD_SX(x,y)	(LCD_WIDTH-(x)-1)
#  define LCD_SY(x,y)	(LCD_HEIGHT-(y)-1)
#elif (LCD_ROTATE == 3)
#  define LCD_ENTRYMODE	0x1118	// AM=1b,ID=01b
#  define LCD_WIDTH		320
#  define LCD_HEIGHT	240
#  define LCD_SX(x,y)	(y)
#  define LCD_SY(x,y)	(LCD_WIDTH-(x)-1)
#else
#error "LCD_ROTATE must be defined (0 to 3)"
#endif

#define lcd_write_address(i)	do { \
		IOWR_8DIRECT(LCD_BASE, 0, ((i)>>8)); \
		IOWR_8DIRECT(LCD_BASE, 0, ((i)&0xff)); \
	} while(0)
#define lcd_write_data(v)		do { \
		IOWR_8DIRECT(LCD_BASE, 1, ((v)>>8)); \
		IOWR_8DIRECT(LCD_BASE, 1, ((v)&0xff)); \
	} while(0)
#define lcd_write(i, v)	do { \
		lcd_write_address(i); lcd_write_data(v); \
	} while(0)

extern alt_u16 lcd_read(alt_u8 address);
extern void lcd_init(void);
extern void lcd_backlight(int on);
extern void lcd_putchar(char ch, int x, int y, alt_u16 fc, alt_u16 bc);
extern void lcd_puts(const char *str, int x, int y, alt_u16 fc, alt_u16 bc);
extern void lcd_rect(int x1, int y1, int x2, int y2, alt_u16 color);

#endif /* LCD_H_ */

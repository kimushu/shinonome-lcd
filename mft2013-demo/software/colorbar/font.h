/**
 * @file font.h
 * @brief Font table
 * @author kimu_shu
 * @note This file is distributed under The MIT License. See LICENSE for details.
 */

#ifndef FONT_H_
#define FONT_H_

#define FONT_F10R

#ifdef FONT_F10R
#define FONT_WORDTYPE	alt_u8
#define FONT_WIDTH		6
#define FONT_HEIGHT		10
#endif	/* FONT_F10R */

extern const FONT_WORDTYPE font[][FONT_HEIGHT];

#endif /* FONT_H_ */

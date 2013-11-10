/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2013 S.Kimura
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <io.h>
#include "spim_tcm_bridge_regs.h"

/**
 * @fn spim_tcm_bridge_acquire
 * @brief Acquire ownership of TC bus for SPI communication
 * @note This is a simple implement version, which uses busy-loop when
 *       failed to acquire ownership.
 * @param base  [in] base address of this peripheral
 * @param keep  [in] if non-zero, keep ownership after deassartion of SS# signal
 */
void spim_tcm_bridge_acquire(alt_u32 base, alt_u32 keep)
{
	IOWR_8DIRECT(base, SPIM_TCM_BRIDGE_CTL_REG,
		((keep != 0) ? SPIM_TCM_BRIDGE_CTL_KEEP_MSK : 0) |
		SPIM_TCM_BRIDGE_CTL_ACQ_MSK);

	while((IORD_8DIRECT(base, SPIM_TCM_BRIDGE_STS_REG) &
		SPIM_TCM_BRIDGE_STS_OWN_MSK) == 0);
}

/**
 * @fn spim_tcm_bridge_release
 * @brief Release ownership of TC bus
 * @note Do not call this function when you don't have an ownership
 * @param base  [in] base address of this peripheral
 */
void spim_tcm_bridge_release(alt_u32 base)
{
	IOWR_8DIRECT(base, SPIM_TCM_BRIDGE_CTL_REG, 0);
}


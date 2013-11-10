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

#ifndef __SPIM_TCM_BRIDGE_MISO8_H__
#define __SPIM_TCM_BRIDGE_MISO8_H__

#include "alt_types.h"

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

/*
 * Macros used by alt_sys_init
 */
#define SPIM_TCM_BRIDGE_MISO8_INSTANCE(name, device) extern int alt_no_storage
#define SPIM_TCM_BRIDGE_MISO8_INIT(name, device) while (0)

void spim_tcm_bridge_acquire(alt_u32 base, alt_u32 keep);
void spim_tcm_bridge_release(alt_u32 base);

#ifdef __cplusplus
}
#endif	/* __cplusplus */

#endif	/* !__SPIM_TCM_BRIDGE_MISO8_H__ */

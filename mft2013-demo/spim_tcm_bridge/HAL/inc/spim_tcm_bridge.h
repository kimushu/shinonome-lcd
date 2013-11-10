/**
 * @file spim_tcm_bridge.h
 * @brief Header for driver of SPI-Master to TCM bridge
 * @author kimu_shu
 * @note This file is distributed under MIT license. See LICENSE for details.
 */

#ifndef __SPIM_TCM_BRIDGE_H__
#define __SPIM_TCM_BRIDGE_H__

#include "alt_types.h"

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

/*
 * Macros used by alt_sys_init
 */
#define SPIM_TCM_BRIDGE_INSTANCE(name, device)	extern int alt_no_storage
#define SPIM_TCM_BRIDGE_INIT(name, device)	while (0)

void spim_tcm_bridge_acquire(alt_u32 base, alt_u32 keep);
void spim_tcm_bridge_release(alt_u32 base);

#ifdef __cplusplus
}
#endif	/* __cplusplus */

#endif	/* !__SPIM_TCM_BRIDGE_H__ */

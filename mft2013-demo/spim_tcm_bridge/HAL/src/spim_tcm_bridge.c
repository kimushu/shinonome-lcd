/**
 * @file spim_tcm_bridge.c
 * @brief Driver of SPI-Master to TCM bridge
 * @author kimu_shu
 * @note This file is distributed under MIT license. See LICENSE for details.
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


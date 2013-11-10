/**
 * @file spim_tcm_bridge_regs.h
 * @brief Register definition of SPI-Master to TCM bridge
 * @author kimu_shu
 * @note This file is distributed under MIT license. See LICENSE for details.
 */

#ifndef __SPIM_TCM_BRIDGE_REGS_H__
#define __SPIM_TCM_BRIDGE_REGS_H__

#define SPIM_TCM_BRIDGE_CTL_REG			0
#define SPIM_TCM_BRIDGE_CTL_REL_MSK		(0x01)
#define SPIM_TCM_BRIDGE_CTL_ACQ_MSK		(0x02)
#define SPIM_TCM_BRIDGE_CTL_KEEP_MSK	(0x04)

#define SPIM_TCM_BRIDGE_STS_REG			0
#define SPIM_TCM_BRIDGE_STS_OWN_MSK		(0x02)
#define SPIM_TCM_BRIDGE_STS_KEEP_MSK	(0x04)

#endif	/* !__SPIM_TCM_BRIDGE_REGS_H__ */

/**
 * @file delay.c
 * @brief Delay functions
 * @author kimu_shu
 * @note This file is distributed under MIT License. See LICENSE for details.
 * @attention Tick time must be 1ms (== CPS equals 1000)
 */

#include <io.h>
#include <sys/alt_alarm.h>
#include "delay.h"

void mdelay(alt_u32 msecs)
{
	alt_u32 start = alt_nticks();
	alt_u32 end = start + msecs;
	alt_u32 now;

	if(start <= end)
	{
		while(1)
		{
			now = alt_nticks();
			if(now < start || end <= now) break;
		}
	}
	else	// end < start
	{
		while(1)
		{
			now = alt_nticks();
			if(end <= now && now < start) break;
		}
	}
}

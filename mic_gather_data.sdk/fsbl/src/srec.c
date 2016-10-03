/******************************************************************************
*
* Copyright (C) 2004 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
#include "portab.h"
#include "srec.h"
#include "errors.h"

uint8  grab_hex_byte (uint8 *buf);
uint16 grab_hex_word (uint8 *buf);
uint32 grab_hex_dword (uint8 *buf);
uint32 grab_hex_word24 (uint8 *buf);

int srec_line = 0;

uint8 nybble_to_val (char x)
{
    if (x >= '0' && x <= '9')
        return (uint8)(x-'0');
    
    return (uint8)((x-'A') + 10);
}

uint8 grab_hex_byte (uint8 *buf)
{
    return  (uint8)((nybble_to_val ((char)buf[0]) << 4) +
                       nybble_to_val ((char)buf[1]));
}

uint16 grab_hex_word (uint8 *buf)
{
    return (uint16)(((uint16)grab_hex_byte (buf) << 8)
                      + grab_hex_byte ((uint8*)((int)buf+2))
                     );
}

uint32 grab_hex_word24 (uint8 *buf)
{
    return (uint32)(((uint32)grab_hex_byte (buf) << 16)
                      + grab_hex_word ((uint8*)((int)buf+2))
                     );
}

uint32 grab_hex_dword (uint8 *buf)
{
    return (uint32)(((uint32)grab_hex_word (buf) << 16)
                      + grab_hex_word ((uint8*)((int)buf+4))
                     );
}

uint8 decode_srec_data (uint8 *bufs, uint8 *bufd, uint8 count, uint8 skip)
{
    uint8 cksum = 0, cbyte;
    int i;

    /* Parse remaining character pairs */
    for (i=0; i < count; i++) {
        cbyte = grab_hex_byte (bufs);
        if ((i >= skip - 1) && (i != count-1))   /* Copy over only data bytes */
            *bufd++ = cbyte;
        bufs  += 2;
        cksum += cbyte;
    }

    return cksum;
}

uint8 eatup_srec_line (uint8 *bufs, uint8 count)
{
    int i;
    uint8 cksum = 0;

    for (i=0; i < count; i++) {
        cksum += grab_hex_byte(bufs);
        bufs += 2;
    }

    return cksum;
}

uint8 decode_srec_line (uint8 *sr_buf, srec_info_t *info)
{
    uint8 count;
    uint8 *bufs;
    uint8 cksum = 0, skip;
    int type;

    bufs = sr_buf;

    srec_line++; /* for debug purposes on errors */

    if ( *bufs != 'S') {
        return SREC_PARSE_ERROR;
    }
    
    type = *++bufs - '0';
    count = grab_hex_byte (++bufs);
    bufs += 2;
    cksum = count;

    switch (type)
    {
        case 0: 
            info->type = SREC_TYPE_0;
            info->dlen = count;
            cksum += eatup_srec_line (bufs, count);
            break;
        case 1: 
            info->type = SREC_TYPE_1;
            skip = 3;
            info->addr = (uint8*)(uint32)grab_hex_word (bufs);
            info->dlen = count - skip;
            cksum += decode_srec_data (bufs, info->sr_data, count, skip);
            break;
        case 2: 
            info->type = SREC_TYPE_2;
            skip = 4;
            info->addr = (uint8*)(uint32)grab_hex_word24 (bufs);
            info->dlen = count - skip;
            cksum += decode_srec_data (bufs, info->sr_data, count, skip);
            break;
        case 3: 
            info->type = SREC_TYPE_3;
            skip = 5;
            info->addr = (uint8*)(uint32)grab_hex_dword (bufs);
            info->dlen = count - skip;
            cksum += decode_srec_data (bufs, info->sr_data, count, skip);
            break;
        case 5:
            info->type = SREC_TYPE_5;
            info->addr = (uint8*)(uint32)grab_hex_word (bufs);
            cksum += eatup_srec_line (bufs, count);
            break;
        case 7:
            info->type = SREC_TYPE_7;
            info->addr = (uint8*)(uint32)grab_hex_dword (bufs);
            cksum += eatup_srec_line (bufs, count);
            break;
        case 8:
            info->type = SREC_TYPE_8;
            info->addr = (uint8*)(uint32)grab_hex_word24 (bufs);
            cksum += eatup_srec_line (bufs, count);
            break;
        case 9:
            info->type = SREC_TYPE_9;
            info->addr = (uint8*)(uint32)grab_hex_word (bufs);
            cksum += eatup_srec_line (bufs, count);
            break;
        default:
            return SREC_PARSE_ERROR;
    }

    if (++cksum) {
        return SREC_CKSUM_ERROR;
    }
   
    return 0;
}



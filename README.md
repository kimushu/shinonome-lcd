Shinonome-LCD
=============
This is sample FPGA designs for Shinonome LCD board.


## About Shinonome LCD board
Shinonome LCD board is an extension board with 2.8'' color LCD and touch panel
for Terasic DE0-Nano.

See manual.pdf for details.


## Quick validation of assemblied board
1. Connect DE0-Nano **without** Shinonome LCD board to your PC.
2. Program two JIC files using Quartus II Programmer.
   - mft2013-demo/output\_files/de0nano.jic
   - mft2013-demo/software/colorbar/colorbar\_epcs{16 or 64}.jic
      - According to EPCS flash device on your DE0-Nano, select either of the two.
3. Disconnect DE0-Nano from PC.
4. Connect Shinonome LCD board to DE0-Nano.
5. Connect DE0-Nano to your PC or USB power adapter. Have fun!


## How to build
Under construction...


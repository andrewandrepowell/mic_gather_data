# mic_gather_data
Nexys 4 DDR Vivado 2016.2 project for transferring samples to a host device with the lwIP TCP/IP stack.

Video Demonstration:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=Xru5yZZ8Gqg
" target="_blank"><img src="http://img.youtube.com/vi/Xru5yZZ8Gqg/0.jpg" 
alt="" width="240" height="180" border="10" /></a>

This repository contains the Vivado 2016.2 RTL and SDK project that implements the video demonstration shown above. This project requires either a Digilent PmodMIC or another microphone whose interface to the Nexys 4 DDR is SPI. The GetSample custom core can be configured to accept different SPI word lengths. MATLAB was used to execute the gather_data_script.m script. However, due to the script's simplicity, another host application can be written to perform the same function but in a different language.

Author: Andrew Powell 

Contact: andrewandrepowell2@gmail.com 

Blog: www.powellprojectshowcase.com

HACKADAY.IO: https://hackaday.io/andrewandrepowell

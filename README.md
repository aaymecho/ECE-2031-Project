# ECE 2031 Project
This document will describe our TONE_GEN peripheral that will essentially have a base functionality to produce a note with less than 1% error, in terms of accuracy. Methods such as quarter wave symmetry and volume control will be described as the additional functionality for the peripheral. There have been some changes such as allocating a specific ROM size and determining the phase register size that will be later revealed. As we are humans, we’ve initially produced a peripheral that did not meet the end-user’s requirement due to a lack of understanding the fundamental end goal. Lastly, throughout the document there will be some modifications that have been made in order to make the peripheral efficient and simple for the end user.

### Requirements & Resources
1. [Quartus Prime](https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/quartus-prime.html)
2. [DE10 Board](https://www.intel.com/content/www/us/en/developer/articles/guide/de10-nano-development-board-user-manual.html)
3. [Frequencies of Musical Notes](https://pages.mtu.edu/~suits/notefreqs.html)
<div>

<p align="center">
<img src = https://i.imgur.com/m86Fypd.png >
</p>

## Device Functionality

<p align="center">
  <img src="https://i.imgur.com/9JwSoap.png">
</p>
<b>FIgure 1.</b> This image shows the simplicity of using ASM to manipulate SCOMP to create a desired note. All one has to do is load the tuning word value into SCOMP’s accumulator, output it to the peripheral, and call a delay utilizing the timer to encapsulate the correct duration of the note.

<div>

<p align="center">
  <img src="https://i.imgur.com/xhw3mCb.png">
</p>

<b>Figure 2.</b> This image shows how the bits for the input to the peripheral manipulate the output of the peripheral. 
<div>
One of the most important problems our team faced was how to create an API that would be easy and straightforward to learn and use. In this end, we utilized the IO-Data bus to frame the vital information that our base and additional functionality required to be effective. Our formula for creating notes can be summed up: add/subtract 16 (in decimal) to either increase/decrease a note by an octave, add/subtract 128 (in decimal) to decrease/increase the volume output by the speakers, and add/subtract one to either raise the note to it’s next higher step or lower it a step.  

## Design Decisions and Implementation
The first major decision the team had to make was determining the size of the phase register. The phase register contains the address that will be used to index into the ROM for the sine wave, so having a larger or small phase register controls the speeds that we can move through the wave at. After doing some calculations, we determined a 15 bit phase register was optimal for this design. Once that was decided, we were able to get the tuning words for the base 12 notes and use bit shifting to change the octave, as each octave is roughly double the hertz of the previous one. The ROM utilizes quarter wave symmetry. In order to accomplish this, we use the left most two bits (14 and 13) of the phase register to determine what quarter of the wave it would be in, as if it was a full size ROM. With these, we can negate the out of the ROM if it is in the third or fourth quarter of the wave or move through the quarter wave backwards if it is in the second or fourth quarter of the wave. The last component of our design is volume control. There are four states the volume can be in that are controlled by the input from the IO_DATA bus. There are four states, where values 00 - 10 get progressively quieter and the value 11 mutes the sound completely

## Conclusion
In conclusion, we initially had fault in our original design due to the oversight focus on the demo itself and not the peripheral. If we had the chance to change one thing in our process, understanding the overall requirement and focus would have been the top priority of the project and due to that we had to start from scratch to produce what we have now, as the team leader I should have made aware to these concentrations and essentially led the team to a less of a downwards path and maybe having more time to optimize the VHDL code could of been nice. Overall, the peripheral came to a success as it produced astonishing results as it met the base requirement of producing a note with less than 1% error and having not one, but two additional functionality, quarter wave symmetry and volume control.

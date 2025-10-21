# Dev log

## 2025-10 `testbench/` Design

Round two developing nesceptor begins.
New thoughts:

  - Document more of the development process / decisions.
  - Order everything with PCB assembly.
    I am sick of debugging soldering issues.
    I also want to be able to order more easily - and not have to spend assembly time on my side.

Today I verified that my little TXU0104PWR breakout board worked.
Also, my original connector Molex 5051104091 is on the JLCPCB Parts library!

First item to design / order is a 5051104091 -> Digital discovery adapter that allows for exploration of the signals, and allows hooking up the pico 2 for initial development.
A sort of test bench hence the directory: `testbench/`.

- 5051104091, connector to get all 40 signals from the CPU
- To 5v -> 3.3v level translater prototype
    - TLV1117LV33DCYR for 5v to 3.3v (first test for this part)
    - TXU0104 translators (second implementation of this part)
- To pins with labels (all pins!?)


Review of the connector from my current breakout installed in several NESes

```
5051104091
                    |    |
                    |    |
              40            --  +5V
              39            ->  OUT0
              38            ->  OUT1
------------  37            ->  OUT2 
              36            ->  /OE1  
              35            ->  /OE2  
              34            ->  R/W   
              33            <-  /NMI  
              32            <-  /IRQ
              31            ->  M2
              30            <-  TST (usually GND)
              29            <-  CLK
              28            <>  D0
              27            <>  D1
              26            <>  D2 
              25            <>  D3 
              24            <>  D4 
              23            <>  D5 
              22            <>  D6
              21            <>  D7
 cable        20            --  GND
              19            ->  A15
              18            ->  A14 
              17            ->  A13  
              16            ->  A12   
              15            ->  A11    
              14            ->  A10     
              13            ->  A9      
              12            ->  A8       
              11            ->  A7        
              10            ->  A6         
               9            ->  A5          
               8            ->  A4           
               7            ->  A3            
               6            ->  A2             
               5            ->  A1              
------------   4            ->  A0               
               3            <-  RST
               2            ->  AD2
               1            ->  AD1
                    |    |
                    |    |
```

The rev 1 testbench has a little section for converting the NES 5v to 3.3v, and then some translators to get the signals into the digital discovery.
I ordered it, now to wait for it to show up.

The plan for when it does is to hook it up to the nes and the [Digital Discovery](https://digilent.com/shop/digital-discovery-portable-usb-logic-analyzer-and-digital-pattern-generator/).
This will allow me to document some of the timing information I will need when developing the inconsole firmware.
I have some earlier things kicking around - but they are not in keeping with the new repo structure and philosophy with documenting everything better.

## 2025-10 `inconsole/` -- rev 0

The next pcb I have designed and ordered is a 0th revision for the inconsole.
This is to see if I can fit all the parts, if I can design and order a working RP2350 board, and many other things.

Basically just following the RP2350 hardware design document, and shooting by the hip.
Going to try the RP2354A so I don't have to worry about fitting the flash on there.
I made an initial board which has all the level translation / power stuff contained within the necessary footprint of the NES CPU, and then some extra stuff on the outside for debugging and testing.
I ordered five of these with assembly and will try to learn as many lessons as possible from this.

First few things before it has even shown up.

- Sticking to 0402 components is helpful for assembly and keeping assembly costs down.
  I did 0201 for a bit, but then it was going to require more advanced assembly and higher costs.
- Ensure hole sizes are in tolerance.
- Include the pin 0 on silkscreen to avoid back and forth email.

Waiting for it to show up, and then will test!

## 2025-10 `usbport/` -- rev 0

Before even the other two revision 0s have shown up I'm investigating the `usbport/`.
Essentially I'm just going to steal the design from the [Unified Daughterboard](https://github.com/Unified-Daughterboard/UDB-S) project - which is another open source project primarily for mechanical keyboards.
Unfortunately their original design does not fit exactly where I want this to fit, so I will have to move things around a little bit probably screwing things up in the process.

One other main consideration about the usbport is that it needs a little enclosure to keep everything neat and tidy and protected.
I was originally thinking of coming out the left of the console - but we have power out the back, and composite out the right, so would be better to not add another cable out another side.
Then I ordered a unified daughterboard just to test, and the Pico EZMate connector is so small that it fits out the expansion port directly, and does not need to come out the vents.
Going to try for out the back on the 0th revision.

The back slot is about 99mm long, 12.5mm deep, ~16 mm wide (15.9 at 'top', 16.5 at 'bottom').
Let's imagine then 1.5mm thick walls on both sides, gives me a 12 mm wide pcb, 1.6mm thick.
I do not think I need to go the full length, but it would make it a bit easier for pushing the usb cable in to have some backing.
Regardless the PCB itself does not need to go to the back.

In keeping with stealing from the unified daughterboard project, we'll be using this [usb c connector - C165948](https://jlcpcb.com/partdetail/Korean_HropartsElec-TYPE_C_31_M12/C165948).

For the enclosure thinking of starting with a single hole in the middle M3 with [threaded inserts](https://www.mcmaster.com/products/threaded-inserts/threaded-inserts-3~/tapered-heat-set-inserts-for-plastic-7/).


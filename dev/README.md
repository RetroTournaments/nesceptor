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

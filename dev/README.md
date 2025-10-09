# Dev log

## 2025-10 'Testbench'

Round two developing nesceptor begins. New thoughts:

  - Document more of the development process / decisions.
  - Order essentially everything with PCB assembly.
    I am sick of debugging soldering issues.
    I also want to be able to order more easily - and not have to spend assembly time on my side.

Today I verified that my little TXU0104PWR breakout board worked.
Also, my original connector Molex 5051104091 is on the JLCPCB Parts library!

First item to design / order is a 5051104091 -> Digital discovery adapter that allows for exploration of the signals, and allows hooking up the pico 2 for initial development.
A sort of test bench.
`testbench/`

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

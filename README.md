# NESceptor

The NESceptor is a small hardware mod that adds a USB output to a 1985 Nintendo Entertainment System.
This mod is designed to provide support for speedrunning and speedrunning competitions.
The primary use case is to:

 - Allow for live RAM watch
 - Transmit console power status
 - Transmit precise timing information

## Design Decisions

### Why this overall design?

The console is to be treated with respect.
Although nearly [62 million units](https://en.wikipedia.org/wiki/Nintendo_Entertainment_System) were sold, they are no longer manufactured and should not be unnecessarily damaged.
The case (shell) of the Nintendo Entertainment system is _not_ to be cut or irreversibly modified.
The electronics are _not_ to be irreversibly modified.

To satisfy this requirement - while also balancing the desires to be able to quickly install a NESceptor - a two-part design was chosen.
The first board sits inside the console and attaches directly to the back of the CPU via a series of castellations.
This first board provides level translation and hosts the microcontroller which does all necessary i/o and processing.

The second part sits in the small outside slot on the back of the console and is attached via double sided tape and a small cable which goes back to the in console pcb.
This second board has ESD protection and the USB port for power in and data trasmission out.

A rough block diagram is below:

```
                     +--inconsole/--------------------+   +--usbport/---------+
     +------------+  |  +--------+    +------------+  |   |                   |
     |            |  |  |        |    |            |  |   | USB connection    |
     | NES CPU    |  |  | 5V to  |    | Rp2350     |  |   |                   |
     |            |  |  | 3.3V   |    | Micro-     |  |   | ESD protection    |
     | 8 data     |  |  |        |    | controller |  |   |                   |
     | 14 addr    | --> | Level  | -> |            | ---> |                   |
     | 3 aux      |  |  | Trans- |    | Watching / | <--- |                   |
     | --         |  |  | lators |    | Filtering  |  |   |                   |
     | 25 signals |  |  |        |    |            |  |   |                   |
     |            |  |  |        |    |            |  |   |                   |
     +------------+  |  +--------+    +------------+  |   |                   |
                     +--------------------------------+   +-------------------+ 
```

### Why Castellations?

The `inconsole` pcb is connected to the NES CPU with 40 castellations.
Consider:

- Removing the CPU and/or PPU can be difficult for novices (ahem) and requires patience, dedicated tools, and practice.
  Then once removed a socket is installed, and the CPU/PPU have to be installed into yet another socket, and the whole thing is fiddly and may lead to damage.
- The CPU itself is not subjected to heat or potential damage (when removing it), and is left basically alone with this design.
- A flex pcb was tried at one point, but it proved very difficult to install and remove.
  Flex pcbs are also more expensive to manufacture.

The main drawback to the castellations is that they may make the nesceptor difficult to remove, although this has not been tested yet.

### Which signals are needed from the console?

The following signals are absolutely required:

- Data lines 0 to 7 (8 total), these are self explanatory!
- Address lines 0 to 10 and 13-15 (14 total). Address lines 11 and 12 are not necessary because they are [unmapped](https://www.nesdev.org/wiki/CPU_memory_map).
- `NES_RST` when low the console is off, and that is important to know.
- `M2` is the clock
- `R/W` for read / write (low is write) 

This gives a total of 25 signals.

Historically `NMI` was also watched - but it was not used in the first version.
Maybe the controller pins are important, or `IRQ`, but they were never hooked up in the original.

### Notes on level translation

The NES is a 5V system, which is relatively high by modern standards, as most modern microcontrollers only have 3.3V tolerant inputs.
For example the [RP2350 datasheet](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf) indicates a maximum 3.63V supply voltage (`IOVDD`) and `IOVDD + 0.3` as maximum input voltage.
The NES signals must be translated to not damage the microcontrollers.

The level translators must not be used to change or interact with the console whatsoever.
They are preferably unidirectional.
This is imperative to maintain the legitimacy of the speedrunning and should be easily verified by third parties.

### Why the RP2350?

An earlier version of the NESceptor used an FPGA - specifically the Lattice iCE40 HX on the Alchitry CU development board, however:

- FPGAs are expensive.
- FPGAs are difficult to program (requiring some HDL).

The RP2350 is cheaper and should be capable of reading the NESs roughly 2 MHz signals:

- [This logic analyzer project](https://github.com/gusmanb/logicanalyzer/tree/master) uses a raspberry pi pico and boasts 100Msps
- And [this one](https://github.com/dotcypress/ula) also gets similar speeds.

### Why USB

USB is simple and well supported, people probably already have a ton of cables.
This will allow for communication and power delivery.
Ethernet is not necessary in this application because the nesbox mini pc will handle that, and would introduce some additional complications when it comes to networking.
Wifi for communication is expected to be unreliable - although this is unknown.

## Dev Instructions

### PCB Development

Install [KiCad](https://www.kicad.org/) for schematics / pcb design / etc.
I just use `snap install kicad`.
This got me `kicad 9.0.1` last time.
I'm using KiCad because it's free, and this is an open source project.

### Enclosure Development

Install [OpenSCAD](https://openscad.org/) for the 3d printed usbport enclosure.
I just use `snap install openscad`.
This got me `openscad 2021.01` last time.
I'm using OpenSCAD because its free, programmatic, and this is an open source project.

### Firmware Development

Under construction.

### Ordering instructions

Under construction.

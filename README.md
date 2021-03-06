
# GameBoy Advance cartridge

This project is about making homebrew cartridges for the GameBoy Advance, using an FPGA (here a [TinyFPGA](https://tinyfpga.com/) BX).
Given the update frequency (and the fact that both falling-edges and rising-edges are meaningful), this is more convenient than bit-banging using some micro-controller.
A few experiments are available, some making use of an additional micro-controller (here an [Arduino Nano 33 BLE](https://store.arduino.cc/products/arduino-nano-33-ble)) for communication.


## Cartridge protocol

The cartridge has the following pins:

 * 1: `VCC`, at 3.3V.
 * 2: `PHI`, the physical clock, which can be configured (disabled, 4.19MHz, 8.38MHz, 16.78MHz). Disabled by default. See [waitstate control](https://www.akkit.org/info/gbatek.htm#gbasystemcontrol).
 * 3: `~WR`, write control.
 * 4: `~RD`, read control.
 * 5: `~CS`, select ROM.
 * 6-21: `AD`, address and data.
 * 22-29: `A`, address or data.
 * 30: `CS2`, select SRAM.
 * 31: `IRQ`, interrupt request. Can be left unconnected or grounded.
 * 32: `GND`, ground.

General comments about memory accesses:

 * Data format is always little endian, i.e. least significant byte is first.
 * Depending on the requested (virtual) address and operation, the GameBoy will either assume ROM or RAM when accessing the cartridge.
 * ROM data access is 16-bits, hence data is aligned on 2-bytes steps. This means the implicit least-significant bit of the address is always 0 (i.e. `A0..23` is the address divided by 2).
 * ARM instructions (32-bits) are slow to fetch. It is better to use THUMB instructions, or copy the code in WRAM.
 * GamePak accesses can be either sequential or non-sequential. The first access to a random location in ROM must be non-sequential.
 * The GameBoy will wait a few cycles when accessing memory. Up to 3 configurations can be used (useful if the cartridge has multiple ROM units with different physical properties). By default, it will assume 4 cycles for random access, and then 2 cycles for sequential access. See [waitstate control](https://www.akkit.org/info/gbatek.htm#gbasystemcontrol).
 * When doing ROM access, the `AD` bus is used in both direction. The cartridge should actively write only when both `~CS` and `~RD` are low.
 * When doing RAM access, the `AD` bus is used for the 16-bits address, and the 8-bits data is returned through `A16..23`. `~CS2` is used instead of `~CS`.

A read access from the ROM is done as follows:

 * On `~CS` falling-edge, the cartridge latches A0-A23 as address.
 * On `~RD` falling-edge, the cartridge fetches the data at latched address and outputs D0-D15. The output must be ready by next rising-edge of `~RD` (depends on waitstates).
 * On `~RD` rising-edge, the cartridge increments latched address by one (i.e. allow sequential read by just strobing `~RD`).
 * On `~CS` rising-edge, the transaction is done.

While it usually makes no sense to write to a ROM, the GameBoy will submit write commands in a similar fashion, toggling `~WR` instead.
In this project, we use that to let the software write back to the cartridge, for instance to report key input.

Therefore, a simple read-only GamePak ROM does not use `PHI`, `~WR`, `~CS2` and `IRQ`.

Cartridges that require more than 64K of storage will need to use bank switching to map more memory.
This topic has not been investigated in this project.

Relevant links:

 * References
   * https://github.com/gbadev-org/awesome-gbadev
   * https://www.gbadev.org/
   * https://www.akkit.org/info/gbatek.htm
   * https://problemkaputt.de/gbatek.htm
   * http://www.hardwarebook.info/Game_Pak
 * Blogs and websites
   * https://gekkio.fi/
     * https://gekkio.fi/files/gb-docs/gbctr.pdf
     * https://github.com/gekkio/gb-hardware
   * https://www.darkfader.net/gba/
     * http://files.darkfader.net/gba/files/cartridge.txt
   * https://reinerziegler.de.mirrors.gg8.se/GBA/gba.htm
   * http://kylehalladay.com/blog/tutorial/gba/2017/04/18/GBA-By-Example-4.html
   * https://fabiensanglard.net/another_world_polygons_GBA/
   * https://github.com/PeterLemon/GBA
 * Custom cartridges
   * https://github.com/uXeBoy/GBA
   * https://github.com/uXeBoy/GBArduboy
   * http://www.dl9sec.de/prj_gbacart.html
 * Cartridge reader
   * https://www.insidegadgets.com/2011/03/19/gbcartread-arduino-based-gameboy-cart-reader-%E2%80%93-part-1-read-the-rom/
   * https://douevenknow.us/post/68126856498/arduino-based-gba-rom-dumper-part-1
   * https://dragaosemchama.com/en/2015/12/gameboy-pak-reader-cartridge-header/
   * https://mgba.io/2015/10/20/dumping-the-undumped/
 * Multiboot-based
   * https://github.com/Shyri/gba-bt-hid
 * Old GameBoy, but still very interesting
   * https://dhole.github.io/post/gameboy_cartridge_emu_1/
   * https://retrocomputing.stackexchange.com/questions/11732/how-does-the-gameboys-memory-bank-switching-work
   * https://github.com/dwaq/Homebrew-Gameboy-Cartridge
   * https://www.insidegadgets.com/2018/04/18/building-a-2mb-mbc5-gameboy-cart-part-1-cpld-as-the-mbc-and-adding-flash-as-our-rom/
   * http://bitwise.bperki.com/2018/08/08/custom-game-boy-cartridge-project-update-1/
   * https://wiki.tauwasser.eu/view/MBC1
   * https://catskull.net/gameboy-boot-screen-logo.html


## Compiling a GameBoy Advance game

The GameBoy Advance features an ARM-based processor.
We will use [devkitPro](https://devkitpro.org/wiki/Main_Page) to compile binaries.

The most straightforward approach is to use the [Docker image](https://github.com/devkitPro/docker).
We share the local folder with the container, to avoid unnecessary copies.

```
# Run in interactive mode
docker run -ti -v ${PWD}:/rom devkitpro/devkitarm
# On Windows: docker run -ti -v %cd%:/rom devkitpro/devkitarm

# Add compiler binaries to path
export PATH="/opt/devkitpro/devkitARM/bin/:$PATH"

# Go to shared folder and build files
cd /rom/
make
```

Links related to GBA software development:

 * https://www.coranac.com/tonc/text/toc.htm
 * https://devkitpro.org/wiki/Getting_Started
 * https://github.com/devkitPro/docker
 * https://github.com/devkitPro/gba-examples
 * http://kylehalladay.com/blog/tutorial/gba/2017/03/28/GBA-By-Example-1.html
 * https://www.coranac.com/tonc/text/setup.htm#sec-dkp
 * https://www.akkit.org/info/gbatek.htm#gbakeypadinput
 * https://www.coranac.com/tonc/text/keys.htm
 * https://github.com/felixjones/gba-plusplus

Emulators and GameBoy implementations:

 * https://mgba.io/
 * https://github.com/RobertPeip/FPGBA
 * https://github.com/AntonioND/giibiiadvance
 * https://mitxela.com/projects/swotgb/about


## Development PCB

In order to have a flexible playground, a custom-made PCB has been designed using [KiCad](https://www.kicad.org/) and ordered on [JLCPCB](https://jlcpcb.com/).
[This](https://www.aliexpress.com/item/1005003412771520.html) cheap cartridge header can be soldered to connect an actual cartridge, if needed.
A simple casing has been designed using [FreeCAD](https://www.freecadweb.org/) and 3D-printed (resin) to properly fit the GameBoy Advance.
Depending on whether a GameBoy Advance and/or a cartridge is used, the FPGA can have various roles.

 * The 32 pins of the cartridge are forwarded from the GameBoy to the cartridge.
 * Two sets of connectors are available to intercept (or drive) the pins: a 2x16 header for generic usage, and a 2x14 header designed to hold the TinyFPGA BX.
 * A dedicated header is available to configure power supply.
 * `A` is not exposed to the TinyFPGA BX, as there are not enough pins. Note that some GPIO pins are exposed as pads by the FPGA, but this is not convenient for this project.
 * Instead, some pins are exposed as "extra", and can be used either for external communication (e.g. SPI) or connected to `A` to extend the address space.
 * Use ENIG finish (i.e. *not* HASL), for more strength.
 * In order to fit in the opening, a thickness of 0.8mm should be used (as the casing already takes roughly 1mm).

See the [schema](pcb.sch.pdf) for more details.

![PCB (front)](image/pcb_front.jpg)

![PCB (back)](image/pcb_back.jpg)


## Getting started with TinyFPGA BX

As described in the [User Guide](https://tinyfpga.com/bx/guide.html), install [APIO](https://github.com/FPGAWARS/apio):

```
conda create -n fpga python=3.7
activate fpga
pip install apio==0.4.0b5 tinyprog
apio install system scons icestorm iverilog
```

Connect the board and run:

```
apio install drivers
apio drivers --serial-enable
```

Reconnect the board, and check that the device is recognized.
Windows might take a few seconds to actually detect and properly setup the serial device.

```
apio system --lsserial
```

Make sure the board is up-to-date:

```
tinyprog --update-bootloader
```

For better integration, use [Atom](https://atom.io/) and install the `apio-ide` package.
Note that you should run Atom inside the Conda environment, so that paths are properly set up:

```
atom --new-instance
```

Using the [default template](https://github.com/tinyfpga/TinyFPGA-BX/tree/master/apio_template), you can quickly start developing the TinyFPGA.

Note that you can upload the code by calling `tinyprog` directly:

```
tinyprog --program hardware.bin
```

The `apio-ide` package provide shortcuts for the most common operations, i.e. build and program.
Use `F8` to show the compilation log after a successful build.

Links:

 * https://tinyfpga.com/
 * http://www.clifford.at/icestorm/
 * https://www.youtube.com/watch?v=ZNunxg7o8l0
 * https://hackaday.io/project/159191-fpga-bootcamp-1
 * https://github.com/YosysHQ/nextpnr


## Experiments

A few simple experiments have been made until now.


### Cartridge dump

An Arduino Nano 33 BLE is connected to a TinyFPGA BX over SPI.

![Hardware setup](image/dump.jpg)

| Name | Arduino Nano 33 BLE | Wire | Board | TinyFPGA BX |
| ---- | ---- | ---- | ---- | ---- |
| GND | GND | black | GND | GND | GND |
| MISO | D2 (2) | green | EXT0 | 1 (A2) |
| MOSI | D3 (3) | blue | EXT1 | 2 (A1) |
| SCK | D4 (4) | white | EXT2 | 3 (B1) |
| SS | D5 (5) | yellow | EXT3 | 4 (C2) |

The cartridge is powered by the TinyFPGA BX, i.e. `VCC_CART` is connected to `VOUT`.

This is a naive implementation of the above-mentioned protocol:

 * The FPGA toggles `~CS` and `~RD`, writes the address and reads the output through `AD`. Note that, as `A` is ignored, only the first 131072 can be read.
 * The Arduino acts as a bridge, communicating with the FPGA using SPI and with the computer using USB.
 * A Python script sends the commands and dumps the content to a binary file.

Note that this approach does not handle any memory bank.
Therefore, it cannot be used as-is to dump a whole cartridge.

See [`./experiments/dump/`](./dump/) for more details.


### Read-only cartridge

The TinyFPGA BX acts as a read-only ROM cartridge.
A simple "game" is provided, where a white dot is moved using the arrows.

![Hardware setup](image/read.jpg)

See [`./experiments/read/`](./read/) for more details.


### Read-write

The TinyFPGA BX acts as a writable ROM cartridge.
A simple "game" is provided, where buttons are written at each frame to the cartridge memory.

See [`./experiments/write/`](./write/) for more details.


### USB gamepad

The TinyFPGA BX acts as a writable ROM cartridge.
A simple "game" is provided, where buttons are written at each frame to the cartridge memory.
This information is then forwarded to an Arduino Nano 33 BLE, which is recognized as a HID gamepad.

![Hardware setup](image/gamepad.jpg)

TODO: use HID over USB/BLE

TODO: use interrupts on GBA (and sleep when no button is pressed)

TODO: make FPGA the SPI master, or use interrupts to let the Arduino communicate only when needed

See [`./experiments/gamepad/`](./gamepad/) for more details.


### Direct Memory Access

...

http://problemkaputt.de/gbatek-gba-dma-transfers.htm
https://gbdev.gg8.se/wiki/articles/Video_Display
https://austinjadams.com/blog/autograding-gba-dma/
https://badd10de.dev/notes/gba-programming.html

See [`./experiments/dma/`](./dma/) for more details.


### VGA

The GBA has a TFT color LCD that is 240 x 160 pixels in size and has a refresh rate of exactly 280896 cpu cycles per frame, or around 59.73 hz.
Most GBA programs will need to structure themselves around this refresh rate.
The LCD can display 15-bit RGB colors (0bxbbbbbgggggrrrrr).

TODO:
 * Use backbuffer (with palette) mode 4, to acquire next frame during previous one is drawn
 * VGA is an analog signal, with 5 (+GND) relevant pins: R, G, B, H-Sync, V-Sync
 * We can naively connect these to digital inputs, effectively displaying only 8 colors
 * We can also use an analog-to-digital serial converter, if FPGA is fast enough
 * https://electronics.stackexchange.com/questions/134674/how-vga-monitor-detects-video-resolution
 * Need 3:2 resolution, so maybe use 320x200 and trim 20 pixels horizontally? https://www.videotechnology.com/0904/formats.html

The closest standard mode is 720x480 @60Hz RGB 4:4:4

 * https://en.wikipedia.org/wiki/Video_Graphics_Array
 * https://en.wikipedia.org/wiki/HDMI
 * https://www.youtube.com/watch?v=l7rce6IQDWs&ab_channel=BenEater
 * http://tinyvga.com/vga-timing
 * https://ez.analog.com/cfs-file/__key/telligent-evolution-components-attachments/00-317-00-00-00-05-21-37/HDMISpecification13a.pdf
 * https://forum.digikey.com/t/vga-controller-vhdl/12794


# Custom GameBoy Advance game

This is a toy example used to test the custom cartridge.
The GameBoy Advance features an ARM-based processor.
We will use [devkitPro](https://devkitpro.org/wiki/Main_Page) to compile binaries.

Links related to GBA software development:

 * https://www.coranac.com/tonc/text/setup.htm
 * https://devkitpro.org/wiki/Getting_Started
 * https://github.com/devkitPro/docker
 * https://github.com/devkitPro/gba-examples
 * http://kylehalladay.com/blog/tutorial/gba/2017/03/28/GBA-By-Example-1.html
 * https://www.coranac.com/tonc/text/setup.htm#sec-dkp
 * https://www.akkit.org/info/gbatek.htm#gbakeypadinput

Emulators and GameBoy implementations:

 * [mGBA](https://mgba.io/)
 * No$GBA
 * [FPGBA](https://github.com/RobertPeip/FPGBA)


## Getting started with devkitPro

The most straightforward approach is to use the [Docker image](https://github.com/devkitPro/docker).
We share the local folder with the container, to avoid unnecessary copies.

```
# Run in interactive mode
docker run -ti -v ${PWD}:/rom devkitpro/devkitarm
#docker run -ti -v %cd%:/rom devkitpro/devkitarm

# Add compiler binaries to path
export PATH="/opt/devkitpro/devkitARM/bin/:$PATH"

# Go to shared folder and build files
cd /rom/
make
```

The makefile is kept to a bare minimum, for simplicity, but please refer to [these rules](https://github.com/devkitPro/devkitarm-rules/blob/master/gba_rules) for more advanced usage.
Core definitions file is taken from [this location](https://github.com/devkitPro/devkitarm-crtls/blob/master/gba_crt0.s).

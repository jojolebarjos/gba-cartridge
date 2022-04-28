
#include <stdint.h>

#define REG_WSCNT            *((volatile uint32_t *)0x04000204)
#define WS_ROM0_N2           0x0008
#define WS_ROM0_S1           0x0010

#define REG_DISPLAYCONTROL   *((volatile uint32_t *)0x04000000)
#define VIDEOMODE_3          0x0003
#define BGMODE_2             0x0400

#define REG_VCOUNT           *((volatile uint16_t *)0x04000006)
#define MEM_VRAM             ((volatile uint16_t *)0x06000000)
#define SCREEN_WIDTH         240
#define SCREEN_HEIGHT        160

typedef struct {
    void const volatile * src;
    void volatile * dst;
    uint32_t count;
} DMA_REC;

#define REG_DMA              ((volatile DMA_REC *)0x040000b0)
#define DMA_ENABLE           (1 << 31)


// Image data is generated from PNG
#include "image.inc"


// Busy wait for next frame
void vsync(void) {

    // Wait until VDraw
    while (REG_VCOUNT >= 160);

    // Wait until VBlank
    while (REG_VCOUNT < 160);
}


// Entry point
int main(void) {

    // Activate video mode 3, to allow direct access to 16-bits pixel buffer
    REG_DISPLAYCONTROL = VIDEOMODE_3 | BGMODE_2;

    // Set wait states 0 to minimum
    REG_WSCNT = WS_ROM0_N2 | WS_ROM0_S1;

    // Copy image
    REG_DMA[3].count = 0;
    REG_DMA[3].src = image;
    REG_DMA[3].dst = MEM_VRAM;
    REG_DMA[3].count = SCREEN_HEIGHT * SCREEN_WIDTH | DMA_ENABLE;

    // Loop forever
    for (;;) {}

    return 0;
}

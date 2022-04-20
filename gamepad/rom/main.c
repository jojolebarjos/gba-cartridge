
#include <stdint.h>

#define REG_DISPLAYCONTROL   *((volatile uint32_t *)0x04000000)
#define VIDEOMODE_3          0x0003
#define BGMODE_2             0x0400

#define REG_VCOUNT           *((volatile uint16_t *)0x04000006)
#define MEM_VRAM             ((volatile uint16_t *)0x06000000)
#define SCREEN_WIDTH         240
#define SCREEN_HEIGHT        160

#define REG_KEYINPUT         *((volatile uint16_t *)0x04000130)

#define KEY_A                (1 << 0)
#define KEY_B                (1 << 1)
#define KEY_SELECT           (1 << 2)
#define KEY_START            (1 << 3)
#define KEY_RIGHT            (1 << 4)
#define KEY_LEFT             (1 << 5)
#define KEY_UP               (1 << 6)
#define KEY_DOWN             (1 << 7)
#define KEY_R                (1 << 8)
#define KEY_L                (1 << 9)

#define CART_KEYINPUT        *((volatile uint16_t *)0x08000800)


// Busy wait for next frame
void vsync(void) {

    // Wait until VDraw
    while (REG_VCOUNT >= 160);

    // Wait until VBlank
    while (REG_VCOUNT < 160);
}


// Entry point
int main(void) {
    int i;

    // Activate video mode 3, to allow direct access to 16-bits pixel buffer
    REG_DISPLAYCONTROL = VIDEOMODE_3 | BGMODE_2;

    // Paint screen black
    for (i = 0; i < SCREEN_WIDTH * SCREEN_HEIGHT; ++i)
        MEM_VRAM[i] = 0x0000;

    // Loop forever
    for (;;) {

        // Wait until next frame
        vsync();

        // Write buttons to cartridge
        CART_KEYINPUT = REG_KEYINPUT;
    }

    return 0;
}

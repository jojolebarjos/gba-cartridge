
from PIL import Image
import numpy as np

image = Image.open("image.png")

image = np.asarray(image)
assert image.shape == (160, 240, 3)

image = (image.astype(np.uint32) * 0b11111) // 255

image = (image[:, :, 2] << 10) | (image[:, :, 1] << 5) | image[:, :, 0]
image = image.astype(np.uint16)

with open("image.inc", "w") as file:
    file.write("static uint16_t const image[160 * 240] = {\n")
    for y in range(160):
        for x in range(0, 240, 20):
            line = ", ".join(f"0x{image[y][x + i]:04x}" for i in range(20))
            file.write(f"    {line},\n")
    file.write("};\n")

import sys

import serial

from tqdm import tqdm


name = sys.argv[1]

with serial.Serial(name, 9600, timeout=1) as port:

    def transfer(value):
        if isinstance(value, int):
            assert 0 <= value < 65536
            value = bytes([value >> 8, value & 0xff])
        port.write(value)
        port.flush()
        return port.read(2)

    SET = 0b001
    LATCH = 0b010
    STOP = 0b011
    READ = 0b100
    STEP = 0b101

    transfer(SET)
    transfer(0x0000)
    transfer(LATCH)
    transfer(READ)

    data = []
    for i in tqdm(range(200)):
        transfer(STEP)
        result = transfer(READ)
        # TODO swapping here, but is it the proper place for that?
        data.append(result[1])
        data.append(result[0])

    transfer(STOP)

    data = bytes(data)

    with open("dump.bin", "wb") as file:
        file.write(data)

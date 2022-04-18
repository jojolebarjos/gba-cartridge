import sys

import serial


name = sys.argv[1]

with serial.Serial(name, 9600, timeout=1) as port:

    CMD_SEEK = 0x01
    CMD_READ = 0x02

    def transfer(value):
        port.write(bytes([value]))
        port.flush()
        return port.read()

    def seek(address):
        if address < 0 or address >= (2 << 24):
            raise ValueError(address)
        if address >= (2 << 16):
            raise NotImplementedError("current FPGA BX PCB does not support A16..23")
        transfer(CMD_SEEK)
        transfer(address & 0xff)
        transfer((address >> 8) & 0xff)
        transfer(CMD_READ)

    def read():
        return transfer(CMD_READ)

    seek(0x0000)
    data = []
    for i in range(128):
        value = read()
        data.append(value)

    print(data)



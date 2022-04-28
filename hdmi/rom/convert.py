
with open("rom.gba", "rb") as file:
    rom = file.read()

with open("rom.hex", "w") as file:
    for i in range(0, len(rom), 2):
        file.write(f"{rom[i+1]:02x}{rom[i]:02x}\n")

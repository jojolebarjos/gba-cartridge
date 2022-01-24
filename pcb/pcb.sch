EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Conn_01x32_Male J1
U 1 1 61EBE32F
P 1000 2500
F 0 "J1" H 1108 4181 50  0000 C CNN
F 1 "Conn_01x32_Male" H 1108 4090 50  0000 C CNN
F 2 "pcb:GBA" H 1000 2500 50  0001 C CNN
F 3 "~" H 1000 2500 50  0001 C CNN
	1    1000 2500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x32_Female J2
U 1 1 61EC16F7
P 2500 2500
F 0 "J2" H 2528 2476 50  0000 L CNN
F 1 "Conn_01x32_Female" H 2528 2385 50  0000 L CNN
F 2 "pcb:CART" H 2500 2500 50  0001 C CNN
F 3 "~" H 2500 2500 50  0001 C CNN
	1    2500 2500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 61ECCB49
P 1500 4200
F 0 "#PWR01" H 1500 3950 50  0001 C CNN
F 1 "GND" H 1505 4027 50  0000 C CNN
F 2 "" H 1500 4200 50  0001 C CNN
F 3 "" H 1500 4200 50  0001 C CNN
	1    1500 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 1000 1500 1000
Wire Wire Line
	1200 4100 1500 4100
Wire Wire Line
	1500 4100 1500 4200
Text Label 1500 4000 2    50   ~ 0
~REQ
Text Label 1500 1100 2    50   ~ 0
PHI
Text Label 1500 1200 2    50   ~ 0
~WR
Text Label 1500 1300 2    50   ~ 0
~RD
Text Label 1500 1400 2    50   ~ 0
~CS
Text Label 1500 1500 2    50   ~ 0
AD0
Text Label 1500 1600 2    50   ~ 0
AD1
Text Label 1500 1700 2    50   ~ 0
AD2
Text Label 1500 1800 2    50   ~ 0
AD3
Text Label 1500 1900 2    50   ~ 0
AD4
Text Label 1500 2000 2    50   ~ 0
AD5
Text Label 1500 2100 2    50   ~ 0
AD6
Text Label 1500 2200 2    50   ~ 0
AD7
Text Label 1500 2300 2    50   ~ 0
AD8
Text Label 1500 2400 2    50   ~ 0
AD9
Text Label 1500 2500 2    50   ~ 0
AD10
Text Label 1500 2600 2    50   ~ 0
AD11
Text Label 1500 2700 2    50   ~ 0
AD12
Text Label 1500 2800 2    50   ~ 0
AD13
Text Label 1500 2900 2    50   ~ 0
AD14
Text Label 1500 3000 2    50   ~ 0
AD15
Text Label 1500 3100 2    50   ~ 0
A16
Text Label 1500 3200 2    50   ~ 0
A17
Text Label 1500 3300 2    50   ~ 0
A18
Text Label 1500 3400 2    50   ~ 0
A19
Text Label 1500 3500 2    50   ~ 0
A20
Text Label 1500 3600 2    50   ~ 0
A21
Text Label 1500 3700 2    50   ~ 0
A22
Text Label 1500 3800 2    50   ~ 0
A23
Text Label 1500 3900 2    50   ~ 0
~CS2
Wire Wire Line
	1200 1100 2300 1100
Wire Wire Line
	1200 1200 2300 1200
Wire Wire Line
	1200 1300 2300 1300
Wire Wire Line
	1200 1400 2300 1400
Wire Wire Line
	1200 1500 2300 1500
Wire Wire Line
	1200 1600 2300 1600
Wire Wire Line
	1200 1700 2300 1700
Wire Wire Line
	1200 1800 2300 1800
Wire Wire Line
	1200 1900 2300 1900
Wire Wire Line
	1200 2000 2300 2000
Wire Wire Line
	1200 2100 2300 2100
Wire Wire Line
	1200 2200 2300 2200
Wire Wire Line
	1200 2300 2300 2300
Wire Wire Line
	1200 2400 2300 2400
Wire Wire Line
	1200 2500 2300 2500
Wire Wire Line
	1200 2600 2300 2600
Wire Wire Line
	1200 2700 2300 2700
Wire Wire Line
	1200 2800 2300 2800
Wire Wire Line
	1200 2900 2300 2900
Wire Wire Line
	1200 3000 2300 3000
Wire Wire Line
	1200 3100 2300 3100
Wire Wire Line
	1200 3200 2300 3200
Wire Wire Line
	1200 3300 2300 3300
Wire Wire Line
	1200 3400 2300 3400
Wire Wire Line
	1200 3500 2300 3500
Wire Wire Line
	1200 3600 2300 3600
Wire Wire Line
	1200 3700 2300 3700
Wire Wire Line
	1200 3800 2300 3800
Wire Wire Line
	1200 3900 2300 3900
Wire Wire Line
	1200 4000 2300 4000
Wire Wire Line
	2300 4100 1500 4100
Connection ~ 1500 4100
Text Label 3750 2200 0    50   ~ 0
~REQ
$Comp
L Device:R R1
U 1 1 61F31098
P 4250 2200
F 0 "R1" V 4043 2200 50  0000 C CNN
F 1 "10k" V 4134 2200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4180 2200 50  0001 C CNN
F 3 "~" H 4250 2200 50  0001 C CNN
	1    4250 2200
	0    1    1    0   
$EndComp
Text Label 1500 1000 2    50   ~ 0
VCC_GBA
Text Label 1900 1000 0    50   ~ 0
VCC_CART
Wire Wire Line
	1900 1000 2300 1000
Wire Wire Line
	3750 2200 4100 2200
Wire Wire Line
	4400 2200 4750 2200
Text Label 3800 1100 0    50   ~ 0
VCC_GBA
Text Label 3800 1200 0    50   ~ 0
VCC_CART
Text Label 3800 1300 0    50   ~ 0
VIN
Text Label 3800 1400 0    50   ~ 0
VOUT
Text Label 3800 1000 0    50   ~ 0
VCC_GBA
$Comp
L power:GND #PWR02
U 1 1 61F365C4
P 3800 1600
F 0 "#PWR02" H 3800 1350 50  0001 C CNN
F 1 "GND" H 3805 1427 50  0000 C CNN
F 2 "" H 3800 1600 50  0001 C CNN
F 3 "" H 3800 1600 50  0001 C CNN
	1    3800 1600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Female J3
U 1 1 61F372D0
P 4500 1200
F 0 "J3" H 4528 1176 50  0000 L CNN
F 1 "Conn_01x06_Female" H 4528 1085 50  0000 L CNN
F 2 "pcb:PinHeader_Power" H 4500 1200 50  0001 C CNN
F 3 "~" H 4500 1200 50  0001 C CNN
	1    4500 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 1000 4300 1000
Wire Wire Line
	4300 1100 3800 1100
Wire Wire Line
	3800 1200 4300 1200
Wire Wire Line
	4300 1300 3800 1300
Wire Wire Line
	3800 1400 4300 1400
Wire Wire Line
	4300 1500 3800 1500
$Comp
L power:GND #PWR03
U 1 1 61F3E43B
P 4750 2300
F 0 "#PWR03" H 4750 2050 50  0001 C CNN
F 1 "GND" H 4755 2127 50  0000 C CNN
F 2 "" H 4750 2300 50  0001 C CNN
F 3 "" H 4750 2300 50  0001 C CNN
	1    4750 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 2300 4750 2200
Wire Wire Line
	3800 1500 3800 1600
$Comp
L power:GND #PWR05
U 1 1 61F54EC1
P 5750 1100
F 0 "#PWR05" H 5750 850 50  0001 C CNN
F 1 "GND" H 5755 927 50  0000 C CNN
F 2 "" H 5750 1100 50  0001 C CNN
F 3 "" H 5750 1100 50  0001 C CNN
	1    5750 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 1000 5750 1000
Wire Wire Line
	5750 1000 5750 1100
Text Label 7800 1300 2    50   ~ 0
~WR
Text Label 7800 1400 2    50   ~ 0
~RD
Text Label 7800 1500 2    50   ~ 0
~CS
Text Label 7800 1600 2    50   ~ 0
AD1
Text Label 7800 1700 2    50   ~ 0
AD3
Text Label 7800 1800 2    50   ~ 0
AD5
Text Label 7800 1900 2    50   ~ 0
AD7
Text Label 7800 2000 2    50   ~ 0
AD9
Text Label 7800 1000 2    50   ~ 0
VIN
Text Label 7800 1200 2    50   ~ 0
VOUT
Text Label 7800 2100 2    50   ~ 0
AD11
Text Label 7800 2200 2    50   ~ 0
AD13
Text Label 7800 2300 2    50   ~ 0
AD15
$Comp
L power:GND #PWR07
U 1 1 61F6239A
P 8200 1200
F 0 "#PWR07" H 8200 950 50  0001 C CNN
F 1 "GND" H 8205 1027 50  0000 C CNN
F 2 "" H 8200 1200 50  0001 C CNN
F 3 "" H 8200 1200 50  0001 C CNN
	1    8200 1200
	1    0    0    -1  
$EndComp
Text Label 6250 1900 0    50   ~ 0
AD6
Text Label 6250 2000 0    50   ~ 0
AD8
Text Label 6250 2100 0    50   ~ 0
AD10
Text Label 6250 2200 0    50   ~ 0
AD12
Text Label 6250 2300 0    50   ~ 0
AD14
Text Label 6250 1800 0    50   ~ 0
AD4
Text Label 6250 1700 0    50   ~ 0
AD2
Text Label 6250 1600 0    50   ~ 0
AD0
Text Label 6250 1500 0    50   ~ 0
EXT4
Text Label 6250 1400 0    50   ~ 0
EXT3
Text Label 6250 1300 0    50   ~ 0
EXT2
Text Label 6250 1200 0    50   ~ 0
EXT1
Text Label 6250 1100 0    50   ~ 0
EXT0
Wire Wire Line
	6800 1100 6250 1100
Wire Wire Line
	6250 1200 6800 1200
Wire Wire Line
	6800 1300 6250 1300
Wire Wire Line
	6250 1400 6800 1400
Wire Wire Line
	6800 1500 6250 1500
Wire Wire Line
	6250 1600 6800 1600
Wire Wire Line
	6800 1700 6250 1700
Wire Wire Line
	6250 1800 6800 1800
Wire Wire Line
	6800 1900 6250 1900
Wire Wire Line
	6250 2000 6800 2000
Wire Wire Line
	6800 2100 6250 2100
Wire Wire Line
	6250 2200 6800 2200
Wire Wire Line
	6800 2300 6250 2300
$Comp
L Device:C C1
U 1 1 61FB09AA
P 4250 2850
F 0 "C1" V 3998 2850 50  0000 C CNN
F 1 "4u7" V 4089 2850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4288 2700 50  0001 C CNN
F 3 "~" H 4250 2850 50  0001 C CNN
	1    4250 2850
	0    1    1    0   
$EndComp
Text Label 3750 2850 0    50   ~ 0
VCC_GBA
$Comp
L power:GND #PWR04
U 1 1 61FB153A
P 4750 2950
F 0 "#PWR04" H 4750 2700 50  0001 C CNN
F 1 "GND" H 4755 2777 50  0000 C CNN
F 2 "" H 4750 2950 50  0001 C CNN
F 3 "" H 4750 2950 50  0001 C CNN
	1    4750 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 2850 4100 2850
Wire Wire Line
	4750 2850 4750 2950
Wire Wire Line
	4400 2850 4750 2850
Wire Wire Line
	7800 2300 7300 2300
Wire Wire Line
	7300 2200 7800 2200
Wire Wire Line
	7300 2100 7800 2100
Wire Wire Line
	7800 2000 7300 2000
Wire Wire Line
	7300 1900 7800 1900
Wire Wire Line
	7800 1800 7300 1800
Wire Wire Line
	7300 1700 7800 1700
Wire Wire Line
	7800 1600 7300 1600
Wire Wire Line
	7300 1500 7800 1500
Wire Wire Line
	7800 1400 7300 1400
Wire Wire Line
	7300 1300 7800 1300
Wire Wire Line
	7800 1200 7300 1200
Wire Wire Line
	7300 1000 7800 1000
Wire Wire Line
	7300 1100 8200 1100
Wire Wire Line
	8200 1100 8200 1200
Text Label 6250 3050 0    50   ~ 0
VCC_GBA
Text Label 6250 3150 0    50   ~ 0
~WR
Text Label 6250 3250 0    50   ~ 0
~CS
Text Label 6250 3350 0    50   ~ 0
AD1
Text Label 6250 3450 0    50   ~ 0
AD3
Text Label 6250 3550 0    50   ~ 0
AD5
Text Label 6250 3650 0    50   ~ 0
AD7
Text Label 6250 3750 0    50   ~ 0
AD9
Text Label 6250 3850 0    50   ~ 0
AD11
Text Label 6250 3950 0    50   ~ 0
AD13
Text Label 6250 4050 0    50   ~ 0
AD15
Text Label 6250 4150 0    50   ~ 0
A17
Text Label 6250 4250 0    50   ~ 0
A19
Text Label 6250 4350 0    50   ~ 0
A21
Text Label 6250 4450 0    50   ~ 0
A23
Text Label 6250 4550 0    50   ~ 0
~REQ
Text Label 7800 3050 2    50   ~ 0
PHI
Text Label 7800 3150 2    50   ~ 0
~RD
Text Label 7800 3250 2    50   ~ 0
AD0
Text Label 7800 3350 2    50   ~ 0
AD2
Text Label 7800 3450 2    50   ~ 0
AD4
Text Label 7800 3550 2    50   ~ 0
AD6
Text Label 7800 3650 2    50   ~ 0
AD8
Text Label 7800 3750 2    50   ~ 0
AD10
Text Label 7800 3850 2    50   ~ 0
AD12
Text Label 7800 3950 2    50   ~ 0
AD14
Text Label 7800 4050 2    50   ~ 0
A16
Text Label 7800 4150 2    50   ~ 0
A18
Text Label 7800 4250 2    50   ~ 0
A20
Text Label 7800 4350 2    50   ~ 0
A22
Text Label 7800 4450 2    50   ~ 0
~CS2
Wire Wire Line
	6250 3050 6800 3050
Wire Wire Line
	6800 3150 6250 3150
Wire Wire Line
	6250 3250 6800 3250
Wire Wire Line
	6800 3350 6250 3350
Wire Wire Line
	6250 3450 6800 3450
Wire Wire Line
	6800 3550 6250 3550
Wire Wire Line
	6250 3650 6800 3650
Wire Wire Line
	6800 3750 6250 3750
Wire Wire Line
	6250 3850 6800 3850
Wire Wire Line
	6800 3950 6250 3950
Wire Wire Line
	6250 4050 6800 4050
Wire Wire Line
	6800 4150 6250 4150
Wire Wire Line
	6250 4250 6800 4250
Wire Wire Line
	6800 4350 6250 4350
Wire Wire Line
	6250 4450 6800 4450
Wire Wire Line
	6800 4550 6250 4550
Wire Wire Line
	7800 4450 7300 4450
Wire Wire Line
	7300 4350 7800 4350
Wire Wire Line
	7800 4250 7300 4250
Wire Wire Line
	7300 4150 7800 4150
Wire Wire Line
	7800 4050 7300 4050
Wire Wire Line
	7300 3950 7800 3950
Wire Wire Line
	7800 3850 7300 3850
Wire Wire Line
	7300 3750 7800 3750
Wire Wire Line
	7800 3650 7300 3650
Wire Wire Line
	7300 3550 7800 3550
Wire Wire Line
	7800 3450 7300 3450
Wire Wire Line
	7300 3350 7800 3350
Wire Wire Line
	7800 3250 7300 3250
Wire Wire Line
	7300 3150 7800 3150
Wire Wire Line
	7800 3050 7300 3050
$Comp
L power:GND #PWR06
U 1 1 620863D7
P 8150 4650
F 0 "#PWR06" H 8150 4400 50  0001 C CNN
F 1 "GND" H 8155 4477 50  0000 C CNN
F 2 "" H 8150 4650 50  0001 C CNN
F 3 "" H 8150 4650 50  0001 C CNN
	1    8150 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 4550 8150 4650
Wire Wire Line
	7300 4550 8150 4550
$Comp
L pcb:Conn_02x14_Female J5
U 1 1 6209CF47
P 7050 1650
F 0 "J5" H 7050 2515 50  0000 C CNN
F 1 "Conn_02x14_Female" H 7050 2424 50  0000 C CNN
F 2 "pcb:PinHeader_TinyFPGA_BX" H 7050 2450 50  0001 C CNN
F 3 "" H 7050 2450 50  0001 C CNN
	1    7050 1650
	1    0    0    -1  
$EndComp
$Comp
L pcb:Conn_02x16_Female J6
U 1 1 620A75A6
P 7050 3700
F 0 "J6" H 7050 4565 50  0000 C CNN
F 1 "Conn_02x16_Female" H 7050 4474 50  0000 C CNN
F 2 "pcb:PinHeader_Secondary" H 7050 4500 50  0001 C CNN
F 3 "" H 7050 4500 50  0001 C CNN
	1    7050 3700
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05_Female J4
U 1 1 620B391B
P 4500 3700
F 0 "J4" H 4528 3726 50  0000 L CNN
F 1 "Conn_01x05_Female" H 4528 3635 50  0000 L CNN
F 2 "pcb:PinHeader_Extra" H 4500 3700 50  0001 C CNN
F 3 "~" H 4500 3700 50  0001 C CNN
	1    4500 3700
	1    0    0    -1  
$EndComp
Text Label 3750 3900 0    50   ~ 0
EXT4
Text Label 3750 3800 0    50   ~ 0
EXT3
Text Label 3750 3700 0    50   ~ 0
EXT2
Text Label 3750 3600 0    50   ~ 0
EXT1
Text Label 3750 3500 0    50   ~ 0
EXT0
Wire Wire Line
	4300 3500 3750 3500
Wire Wire Line
	3750 3600 4300 3600
Wire Wire Line
	4300 3700 3750 3700
Wire Wire Line
	3750 3800 4300 3800
Wire Wire Line
	3750 3900 4300 3900
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 620D1B2F
P 3550 4300
F 0 "H1" H 3650 4349 50  0000 L CNN
F 1 "MountingHole_Pad" H 3650 4258 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 3550 4300 50  0001 C CNN
F 3 "~" H 3550 4300 50  0001 C CNN
	1    3550 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 620D2A5A
P 3550 4400
F 0 "#PWR0101" H 3550 4150 50  0001 C CNN
F 1 "GND" H 3555 4227 50  0000 C CNN
F 2 "" H 3550 4400 50  0001 C CNN
F 3 "" H 3550 4400 50  0001 C CNN
	1    3550 4400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 620D366E
P 4850 4300
F 0 "H2" H 4950 4349 50  0000 L CNN
F 1 "MountingHole_Pad" H 4950 4258 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 4850 4300 50  0001 C CNN
F 3 "~" H 4850 4300 50  0001 C CNN
	1    4850 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 620D3674
P 4850 4400
F 0 "#PWR0102" H 4850 4150 50  0001 C CNN
F 1 "GND" H 4855 4227 50  0000 C CNN
F 2 "" H 4850 4400 50  0001 C CNN
F 3 "" H 4850 4400 50  0001 C CNN
	1    4850 4400
	1    0    0    -1  
$EndComp
$EndSCHEMATC

## This file is a general .xdc for the to_displayasys3 rev to_display byoard
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
#to_displayank = 34, Pin name = ,					Sch name = clock100MHZ
		set_property PACKAGE_PIN W5 [get_ports clock]
		set_property IOSTANDARD LVCMOS33 [get_ports clock]
		create_clock -period 10.000 -name sys_clock_pin -waveform {0.000 5.000} -add [get_ports clock]

# Switches
set_property PACKAGE_PIN V17 [get_ports to_display[0]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[0]]

set_property PACKAGE_PIN V16 [get_ports to_display[1]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[1]]

set_property PACKAGE_PIN W16 [get_ports to_display[2]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[2]]

set_property PACKAGE_PIN W17 [get_ports to_display[3]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[3]]

set_property PACKAGE_PIN W15 [get_ports to_display[4]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[4]]

set_property PACKAGE_PIN V15 [get_ports to_display[5]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[5]]

set_property PACKAGE_PIN W14 [get_ports to_display[6]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[6]]

set_property PACKAGE_PIN W13 [get_ports to_display[7]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[7]]

set_property PACKAGE_PIN V2 [get_ports to_display[8]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[8]]

set_property PACKAGE_PIN T3 [get_ports to_display[9]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[9]]

set_property PACKAGE_PIN T2 [get_ports to_display[10]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[10]]

set_property PACKAGE_PIN R3 [get_ports to_display[11]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[11]]

set_property PACKAGE_PIN W2 [get_ports to_display[12]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[12]]

set_property PACKAGE_PIN U1 [get_ports to_display[13]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[13]]

set_property PACKAGE_PIN T1 [get_ports to_display[14]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[14]]

set_property PACKAGE_PIN R2 [get_ports to_display[15]]
set_property IOSTANDARD LVCMOS33 [get_ports to_display[15]]

set_property PACKAGE_PIN U18 [get_ports pushbutton]
set_property IOSTANDARD LVCMOS33 [get_ports pushbutton]


# LEDs
set_property PACKAGE_PIN W4 [get_ports anodd[3]]
set_property IOSTANDARD LVCMOS33 [get_ports anodd[3]]

set_property PACKAGE_PIN V4 [get_ports anodd[2]]
set_property IOSTANDARD LVCMOS33 [get_ports anodd[2]]

set_property PACKAGE_PIN U4 [get_ports anodd[1]]
set_property IOSTANDARD LVCMOS33 [get_ports anodd[1]]

set_property PACKAGE_PIN U2 [get_ports anodd[0]]
set_property IOSTANDARD LVCMOS33 [get_ports anodd[0]]

set_property PACKAGE_PIN W7 [get_ports cathod[0]]
set_property IOSTANDARD LVCMOS33 [get_ports cathod[0]]

set_property PACKAGE_PIN W6 [get_ports cathod[1]]
set_property IOSTANDARD LVCMOS33 [get_ports cathod[1]]

set_property PACKAGE_PIN U8 [get_ports cathod[2]]
set_property IOSTANDARD LVCMOS33 [get_ports cathod[2]]

set_property PACKAGE_PIN V8 [get_ports cathod[3]]
set_property IOSTANDARD LVCMOS33 [get_ports cathod[3]]

set_property PACKAGE_PIN U5 [get_ports cathod[4]]
set_property IOSTANDARD LVCMOS33 [get_ports cathod[4]]

set_property PACKAGE_PIN V5 [get_ports cathod[5]]
set_property IOSTANDARD LVCMOS33 [get_ports cathod[5]]

set_property PACKAGE_PIN U7 [get_ports cathod[6]]
set_property IOSTANDARD LVCMOS33 [get_ports cathod[6]]

# Others (to_displayITSTREAM, CONFIG)
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]



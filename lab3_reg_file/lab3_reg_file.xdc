## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
#Bank = 34, Pin name = ,					Sch name = CLK100MHZ
#		set_property PACKAGE_PIN W5 [get_ports CLK]
#		set_property IOSTANDARD LVCMOS33 [get_ports CLK]
#		create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK]

# Switches
set_property PACKAGE_PIN V17 [get_ports write_enable]
set_property IOSTANDARD LVCMOS33 [get_ports write_enable]

set_property PACKAGE_PIN V17 [get_ports mode]
set_property IOSTANDARD LVCMOS33 [get_ports mode]

set_property PACKAGE_PIN V17 [get_ports wr_addr[2]]
set_property IOSTANDARD LVCMOS33 [get_ports wr_addr[2]]

set_property PACKAGE_PIN V17 [get_ports wr_addr[1]]
set_property IOSTANDARD LVCMOS33 [get_ports wr_addr[1]]

set_property PACKAGE_PIN V17 [get_ports wr_addr[0]]
set_property IOSTANDARD LVCMOS33 [get_ports wr_addr[0]]

set_property PACKAGE_PIN V17 [get_ports wr_data[3]
set_property IOSTANDARD LVCMOS33 [get_ports wr_data[3]]

set_property PACKAGE_PIN V17 [get_ports wr_data[2]]
set_property IOSTANDARD LVCMOS33 [get_ports wr_data[2]]

set_property PACKAGE_PIN V17 [get_ports wr_data[1]]
set_property IOSTANDARD LVCMOS33 [get_ports wr_data[1]]

set_property PACKAGE_PIN V17 [get_ports wr_data[0]]
set_property IOSTANDARD LVCMOS33 [get_ports wr_data[0]]


set_property PACKAGE_PIN V17 [get_ports rd_addr1[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_addr1[2]]

set_property PACKAGE_PIN V17 [get_ports rd_addr1[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_addr1[1]]

set_property PACKAGE_PIN V17 [get_ports rd_addr1[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_addr1[0]]

set_property PACKAGE_PIN V17 [get_ports rd_addr2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_addr2[2]]

set_property PACKAGE_PIN V17 [get_ports rd_addr2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_addr2[1]]

set_property PACKAGE_PIN V17 [get_ports rd_addr2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_addr2[0]]



# LEDs
set_property PACKAGE_PIN U16 [get_ports rd_data1_xor_data2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1_xor_data2[3]]

set_property PACKAGE_PIN U16 [get_ports rd_data1_xor_data2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1_xor_data2[2]]

set_property PACKAGE_PIN U16 [get_ports rd_data1_xor_data2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1_xor_data2[1]]

set_property PACKAGE_PIN U16 [get_ports rd_data1_xor_data2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1_xor_data2[0]]

set_property PACKAGE_PIN U16 [get_ports rd_data1[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1[3]]

set_property PACKAGE_PIN U16 [get_ports rd_data1[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1[2]]

set_property PACKAGE_PIN U16 [get_ports rd_data1[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1[1]]

set_property PACKAGE_PIN U16 [get_ports rd_data1[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data1[0]]

set_property PACKAGE_PIN U16 [get_ports rd_data2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data2[3]]

set_property PACKAGE_PIN U16 [get_ports rd_data2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data2[2]]

set_property PACKAGE_PIN U16 [get_ports rd_data2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data2[1]]

set_property PACKAGE_PIN U16 [get_ports rd_data2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rd_data2[0]]


# Others (BITSTREAM, CONFIG)
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]





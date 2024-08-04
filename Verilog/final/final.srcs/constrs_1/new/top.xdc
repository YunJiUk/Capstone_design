# RESET
set_property IOSTANDARD LVCMOS25 [get_ports reset_poweron]
set_property PACKAGE_PIN T18 [get_ports reset_poweron]

# CLK_100M
set_property IOSTANDARD LVCMOS25 [get_ports clk_100mhz]
set_property PACKAGE_PIN Y9 [get_ports clk_100mhz]

# VGA
set_property IOSTANDARD LVCMOS33 [get_ports {red[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue[*]}]

set_property PACKAGE_PIN V20 	[get_ports {red[0]}]
set_property PACKAGE_PIN U20 	[get_ports {red[1]}]
set_property PACKAGE_PIN V19 	[get_ports {red[2]}]
set_property PACKAGE_PIN V18 	[get_ports {red[3]}]
set_property PACKAGE_PIN AB22   [get_ports {green[0]}]
set_property PACKAGE_PIN AA22   [get_ports {green[1]}]
set_property PACKAGE_PIN AB21   [get_ports {green[2]}]
set_property PACKAGE_PIN AA21   [get_ports {green[3]}]
set_property PACKAGE_PIN Y21 	[get_ports {blue[0]}]
set_property PACKAGE_PIN Y20 	[get_ports {blue[1]}]
set_property PACKAGE_PIN AB20   [get_ports {blue[2]}]
set_property PACKAGE_PIN AB19   [get_ports {blue[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {hsync}]
set_property PACKAGE_PIN AA19    [get_ports {hsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {vsync}]
set_property PACKAGE_PIN Y19	 [get_ports {vsync}]

#Pmod JD (V5)
set_property IOSTANDARD LVCMOS25 [get_ports uart_rxd]
set_property PACKAGE_PIN V5 	[get_ports uart_rxd]

#Pmod JD (W7)
set_property IOSTANDARD LVCMOS25 [get_ports uart_txd]
set_property PACKAGE_PIN W7    [get_ports uart_txd]

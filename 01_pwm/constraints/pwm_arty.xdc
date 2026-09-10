## Clock 125 MHz
set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { clk }]
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }]

## Button BTN0 - cambia el duty
set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports { button }]

## Button BTN3 - RESET
set_property -dict { PACKAGE_PIN L19 IOSTANDARD LVCMOS33 } [get_ports { reset }]

## PWM output - Pmod JA1
set_property -dict { PACKAGE_PIN Y18 IOSTANDARD LVCMOS33 } [get_ports { pwm_out }]
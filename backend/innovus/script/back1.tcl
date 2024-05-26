

# Generate “alu_conv_nophy.v: used for gate level netlist simulation (Xcelium)
saveNetlist -phys -includePowerGround Top_phy.v -excludeLeafCell
saveNetlist Top_nophy.v -excludeLeafCell
write_sdf Top_conv.sd

# DRC check, Connectivity check and Antenna check. It is supposed to be 0 violation and 0 warning.
verify_drc -report drc.rpt -limit 1000
verifyConnectivity -report connectivity.rpt -type all -error 1000 -warning 50
verifyProcessAntenna -reportfile antenna.rpt -error 1000
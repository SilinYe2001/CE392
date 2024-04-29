setenv LMC_TIMEUNIT -9
vlib work
vmap work work
# compile 
vlog -work work "../bram.sv"
vlog -work work "../ModInvert.sv"
vlog -work work "../key_generation_top.sv"
vlog -work work "../key_generation.sv"
vlog -work work "../tb/key_generation_tb.sv"
# run simulation
vsim -classdebug -voptargs=+acc +notimingchecks -L work work.key_generation_tb -wlf key_generation_tb.wlf
# wave
add wave -noupdate -group key_generation_tb
add wave -noupdate -group key_generation_tb -radix hexadecimal /key_generation_tb/*

add wave -noupdate -group key_generation_tb/u_key_generation_top
add wave -noupdate -group key_generation_tb/u_key_generation_top -radix hexadecimal /key_generation_tb/u_key_generation_top/*

add wave -noupdate -group key_generation_tb/u_key_generation_top/key_generation
add wave -noupdate -group key_generation_tb/u_key_generation_top/key_generation -radix hexadecimal /key_generation_tb/u_key_generation_top/key_generation/*
run -all
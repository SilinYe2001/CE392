# Set up environment variables
set design_name "Top"
set top_module "key_generation"
set library_path "/vol/ece303/genus_tutorial/NangateOpenCellLibrary_typical.lib"
set lef_path "/vol/ece303/genus_tutorial/NangateOpenCellLibrary.lef"
set output_path "~/CE392/backend/synth/"
set synthesis_constraints "../key_generation.sdc"
# Read design files
read_hdl -sv "../key_generation.sv" "../ModInvert.sv"


# Load libraries
set_db library $library_path
set_db lef_library $lef_path

# Elaborate design

elaborate 
current_design $top_module
# Read constraints
read_sdc $synthesis_constraints



# Set synthesis options
# set_option auto_insert_buffers true
# set_option auto_optimize_registers true

# Perform synthesis
syn_generic

syn_map

syn_opt

# Write synthesized netlist
write_hdl > $output_path/${design_name}_mapped.v

# Write reports
report_timing > $output_path/${design_name}_timing.rpt
report_area > $output_path/${design_name}_area.rpt
report_power > $output_path/${design_name}_power.rpt

# Exit
quit

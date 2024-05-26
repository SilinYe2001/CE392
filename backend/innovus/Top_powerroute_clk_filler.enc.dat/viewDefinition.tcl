if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name lib\
   -timing\
    [list ${::IMEX::libVar}/lib/typ/NangateOpenCellLibrary_typical.lib]
create_op_cond -name op -library_file ${::IMEX::libVar}/lib/typ/NangateOpenCellLibrary_typical.lib -P 10 -V 10 -T 10
create_rc_corner -name rc\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_delay_corner -name de\
   -library_set lib\
   -rc_corner rc
create_constraint_mode -name sdc\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/key_generation.sdc]
create_analysis_view -name an -constraint_mode sdc -delay_corner de
set_analysis_view -setup [list an] -hold [list an]

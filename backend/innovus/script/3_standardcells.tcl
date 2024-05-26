#place standard cells
editPowerVia -skip_via_on_pin Standardcell -bottom_layer metal1 -add_vias 1 -top_layer metal8


setEndCapMode -reset

setEndCapMode -boundary_tap false

setPlaceMode -reset

setPlaceMode -congEffort auto -timingDriven 1 -modulePlan 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 0 -placeIOPins 0 -moduleAwareSpare 0 -preserveRouting 0 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0

setPlaceMode -fp false

placeDesign

timeDesign -preCTS -numPaths 200

optDesign -preCTS -numPaths 200

setDrawView place

saveDesign Top_place
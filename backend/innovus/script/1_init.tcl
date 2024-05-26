setDesignMode -process 45
fit
setDrawView fplan
getIoFlowFlag


#prepare floorplan layout and assign its option
# floorPlan aspect ratio, utilization rate, margins for the 4 sides
floorPlan -r 1.0 0.6 3 3 3 3  
uiSetTool select
getIoFlowFlag

# the following two commands set your VDD and VSS pins.
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VSS -type pgpin -pin VSS -inst *
globalNetConnect VDD -type tiehi
globalNetConnect VSS -type tielo
#save
saveDesign Top.enc



#The clock system will be established. Detailed clock specification is in Clock.ctstch.
set_ccopt_property update_io_latency false
clockDesign -specFile Clock.ctstch -outDir clock_report

checkPlace Top.checkPlace
timeDesign -postCTS -numPaths 200
timeDesign -postCTS -hold -numPaths 200
optDesign -postCTS -numPaths 200
optDesign -postCTS -hold -numPaths 200
timeDesign -postCTS -hold -numPaths 200
timeDesign -postCTS -numPaths 200
saveDesign Top_clk.enc
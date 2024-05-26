# Timing analysis are established by the following commands
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 400 -prefix Top_postRoute -outDir timingReports
clearClockDomains
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 400 -prefix Top_postRoute -outDir timingReports
saveDesign Top_final_layout.enc
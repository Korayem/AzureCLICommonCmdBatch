@echo off

rem clearing values
set jobname=
set site=
set slot=

set /p jobname="Enter job name to find: "
set /p site="Site name(enter partial or exact name or leave empty to search ALL):"
set /p slot="Slot? (leave empty to search ALL):"

if [%jobname%] == [] (
echo You must enter a job name to find!
pause
exit
)

echo ............................................................
echo            Searching for job name: %jobname% 
if [%slot%] NEQ [] (
echo  			in Slot: %slot%
)
if [%site%] NEQ [] (
echo  			in Site: %site%
) ELSE (
echo 			in ALL sites
)
echo ............................................................

rem find rows that have "Running" to make sure it's a website
rem Skip rows with word "Processing:" to show website name 
azure site list | grep "%site%" | grep "%slot%" | grep "Running" | gawk  -f "Jobs - Bulk - Find.awk" | grep "Processing:\|MapKML"
pause

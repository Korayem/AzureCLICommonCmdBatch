@echo off
rem TODO: use command line parameters to pass keyvalues directly. This can be used to do list of changes on app settings using this file as unit of changing app setting for ALL/specific website. Use %1 for first param, %2 for second and so on. http://stackoverflow.com/questions/3973824/windows-bat-file-optional-argument-parsing

rem Q: will deleting a keyname reset "Slot Setting" checkbox? A: No, it doesn't reset it :)

rem clearing values
set keyname=
set keyvalue=
set site=
set slot=


rem debugging only
rem set keyname="IsStaging"
rem set keyvalue="true"
rem set site="wasalnykw"
rem set slot="warmup"


set /p keyNameOrValueToFind="Enter key name or value to find: "
set /p site="Site name(enter partial or exact name or leave empty to find ALL):"
set /p slot="Slot? (leave empty to find ALL):"

if [%keyNameOrValueToFind%] == [] (
echo You must enter a keyname to change!
pause
exit
)




echo ............................................................
echo            Finding name or value: %keyNameOrValueToFind% 
if [%slot%] NEQ [] (
echo  			in Slot: %slot%
)
if [%site%] NEQ [] (
echo  			in Site: %site%
) ELSE (
echo 			in ALL sites
)
echo ............................................................


rem TIP: to debug, add "echo" right before azure.cmd to see what's happening exactly


azure site list | grep "%site%" | grep "%slot%"  | grep "data:" | gawk -f "AppSetting - Bulk - Find.awk" | grep "%keyNameOrValueToFind%"
pause

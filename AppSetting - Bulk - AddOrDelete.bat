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


set /p keyname="Enter keyname to add: "
set /p keyvalue="Enter keyvalue for that keyname: "
set /p site="Site name(enter partial or exact name or leave empty to affect ALL):"
set /p slot="Slot? (leave empty to add to ALL):"

if [%keyname%] == [] (
echo You must enter a keyname to change!
pause
exit
)




echo ............................................................
echo            Delete key name: %keyname% 
if [%keyvalue%] NEQ [] (
echo            then add key value: %keyvalue%
)
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


azure site list | grep "%site%" | grep "%slot%"  | grep "data:" | gawk -f "AppSetting - Bulk - Delete.awk"
rem if keyvalue is empty, then just delete the key, else delete then add
if [%keyvalue%] NEQ [] (
azure site list | grep "%site%" | grep "%slot%"  | grep "Running" | gawk -f "AppSetting - Bulk - DeleteThenAdd.awk"
)
pause

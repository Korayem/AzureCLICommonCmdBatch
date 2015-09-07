@echo off
rem TODO: use command line parameters to pass keyvalues directly. This can be used to do list of changes on app settings using this file as unit of changing app setting for ALL/specific website. Use %1 for first param, %2 for second and so on. http://stackoverflow.com/questions/3973824/windows-bat-file-optional-argument-parsing

rem Q: will deleting a keyname reset "Slot Setting" checkbox? A: No, it doesn't reset it :)

rem clearing values
set site=
set slot=


rem debugging only
rem set site="wasalnykw"
rem set slot="warmup"


set /p site="Site name(enter partial or exact name or leave empty to find ALL):"
set /p slot="Slot? (leave empty to find ALL):"



echo ............................................................
echo            Listing all appsettings as CSV
if [%slot%] NEQ [] (
echo  			in Slot: %slot%
)
if [%site%] NEQ [] (
echo  			in Site: %site%
) ELSE (
echo 			in ALL sites
)
echo ............................................................

set directory= "appsettings-export"
rem add if not exist
IF exist %directory% ( 
rd %directory% /s /q
)
md %directory%
rem TIP: to debug, add "echo" right before azure.cmd to see what's happening exactly

REM TODO: handle with slot or without using if condition to add --slot
REM TODO: handl site slots
rem TODO: save as CSV?
azure site list | grep "Running" | grep "data:" | grep "%site%" | grep "%slot%"  | awk "{ if ($3==\"Running\"){ system(\"echo processing \" $2);system(\"azure site appsetting list \" $2 \" ^> %directory%\\appsettings-\" $2\".csv\"); }else{ system(\"echo processing \" $2 $3);system(\"azure site appsetting list \" $2 \" --slot \" $3 \" ^> %directory%\\appsettings-\" $2 \"-\" $3 \".csv\"); } }"
pause

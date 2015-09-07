@echo off
echo stopping everything
call azure site job list "wasalnyeg(production)" | grep "" | gawk '{system("azure.cmd site job stop "$2)}'
pause

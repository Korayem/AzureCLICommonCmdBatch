@echo off
rem: Kuwait vaorbl75pk
rem: EGypt zye7ct5vmn

set /p sqlservername="Server:"
set /p rulename="Your Name (no spaces):"
set /p userip="IP?(leave empty to delete only):"

echo Deleting Firewall Rule first %sqlservername% %rulename% (in case it exists)
call azure sql firewallrule delete %sqlservername% %rulename% -q

if [%userip%] NEQ [] (
echo Adding new Firewall Rule for %sqlservername% %rulename% %userip%
call azure sql firewallrule create %sqlservername% %rulename% --startIPAddress=%userip% --endIPAddress=%userip%
)

@echo off

set mydate=%date%
set mytime=%time%
set DAY=%mydate:~0,2%
set MONTH=%mydate:~3,2%
set YEAR=%mydate:~6,4%
echo Current time is %mydate%:%mytime%
echo Jour : %DAY%
echo Mois : %MONTH%
echo Année : %YEAR%


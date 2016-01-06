@echo off
if "%OS%" == "Windows_NT" setlocal

set JESS_HOME=.

java -classpath ".;%JESS_HOME%\lib\jess.jar;%JESS_HOME%\lib\jsr94.jar;%JESS_HOME%\lib\fuzzyJ110a.jar;%JESS_HOME%\lib\sfc.jar;%JESS_HOME%\lib\symbeans.jar;%CLASSPATH%" nrc.fuzzy.jess.FuzzyMain %1 %2 %3 %4 %5 %6 %7 %8 %9


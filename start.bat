cd scripts
@REM start /wait powershell.exe -executionpolicy remotesigned -File run.ps1 | ECHO > nul

powershell.exe ". .\Update-Entries.ps1"

pause
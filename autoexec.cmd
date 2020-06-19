@echo off
chcp 65001 >nul
call %~dp0\colours
set wd_colour=%txtblu%
net session >nul 2>&1
if %errorlevel% == 0 (
    set prompt_colour=%txtred%
    set command_colour=%bldpur%
) else (
    set prompt_colour=%txtgrn%
    set command_colour=%bldylw%
)
prompt %prompt_colour%%username%@%computername% %wd_colour%$p%prompt_colour%$g %txtrst%
set wd_colour=
set prompt_colour=
set command_colour=
set pg=

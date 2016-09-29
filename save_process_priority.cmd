:: Copyright Tsiryuta G. N. <spbtgn@gmail.com>
@echo off
title Copyright ^c 2016 Tsiryuta G. N. ^<spbtgn^@gmail.com^>
cls
@echo.
echo #########################################################################
echo #                                                                       #
echo #      С помощью этого пакетного файла вы можете назначить приоритет    #
echo # любому процессу, с которым он будет всегда автоматически запускаться, #
echo #             либо же удалить назначенный ранее приоритет.              #
echo #                                                                       # 
echo #########################################################################

:ask_what_to_do
@echo.
echo Выберите желаемую операцию:
echo A - Назначить приоритет процессу;
echo D - Удалить назначеный ранее приоритет процесса;
echo E - Выйти.
@echo.
choice /C EDA /N /M "A, D или E? "
if errorlevel 3	goto add_record
if errorlevel 2	goto delete_record
if errorlevel 1	goto end_script
echo Ответ не верный. Попробуйте еще раз.
goto ask_what_to_do

:add_record
cls
echo #########################################################################
echo #                                                                       #
echo #                     Назначение приоритета процессу                    #
echo #                                                                       #
echo #########################################################################
@echo.
@echo.
set process_name=
set /P process_name="Введите название процесса (Пример: example.exe): ":
@echo.
echo Выберите приоритет для процесса:
echo H - High (высокий);
echo A - AboveNormal (выше среднего);
echo N - Normal (средний);
echo B - BelowNormal (ниже среднего);
echo I - Idle (низкий).

:set_process_priority
@echo.
set process_priority=
choice /C IBNAH /N /M "H, A, N, B или I? "
:: High
if errorlevel 5 (
	set "process_priority=0x00000003"
	goto reg_add_command
)
:: AboveNormal
if errorlevel 4 (
	set "process_priority=0x00000006"
	goto reg_add_command
)
:: Normal
if errorlevel 3 (
	set "process_priority=0x00000002"
	goto reg_add_command
)
:: BelowNormal
if errorlevel 2 (
	set "process_priority=0x00000005"
	goto reg_add_command
)
:: Idle
if errorlevel 1 (
	set "process_priority=0x00000001"
	goto reg_add_command
)	
echo Ответ не верный. Попробуйте еще раз.
goto set_process_priority
:reg_add_command
@echo.
reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process_name%\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d %process_priority%
set process_name=
set process_priority=
goto ask_about_continue_working

:delete_record
cls
echo #########################################################################
echo #                                                                       #
echo #            Удаление назначенного ранее приоритета процесса            #
echo #                                                                       #
echo #########################################################################
@echo.
@echo.
echo Выполнить поиск разделов реестра для процессов с параметром CpuPriorityClass?
choice /C NY /N /T 10 /D Y /M "(Y - Да, N - Нет.) "
@echo.
if errorlevel 2 (
	reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /s /v CpuPriorityClass
	@echo.
	choice /C YN /N /M "Продолжить процедуру удаления (Y - Да, N - Нет.) "
	if errorlevel 2 goto ask_about_continue_working
)
@echo.
set process_name=
set /P process_name="Введите название процесса (Пример: example.exe): ":
@echo.
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process_name%"
set process_name=

:ask_about_continue_working
@echo.
choice /C NY /N /M "Продолжить работу? (Y - Да, N - Нет.) "
::Yes
if errorlevel 2	(
	cls
	goto ask_what_to_do
)
::No
if errorlevel 1 goto end_script

:end_script
exit
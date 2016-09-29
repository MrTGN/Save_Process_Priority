:: Copyright Tsiryuta G. N. <spbtgn@gmail.com>
@echo off
title Copyright ^c 2016 Tsiryuta G. N. ^<spbtgn^@gmail.com^>
cls
@echo.
echo #########################################################################
echo #                                                                       #
echo #      � ������� �⮣� ����⭮�� 䠩�� �� ����� �������� �ਮ���    #
echo # ��� ������, � ����� �� �㤥� �ᥣ�� ��⮬���᪨ ����᪠����, #
echo #             ���� �� 㤠���� �����祭�� ࠭�� �ਮ���.              #
echo #                                                                       # 
echo #########################################################################

:ask_what_to_do
@echo.
echo �롥�� �������� ������:
echo A - �������� �ਮ��� ������;
echo D - ������� �����祭� ࠭�� �ਮ��� �����;
echo E - ���.
@echo.
choice /C EDA /N /M "A, D ��� E? "
if errorlevel 3	goto add_record
if errorlevel 2	goto delete_record
if errorlevel 1	goto end_script
echo �⢥� �� ����. ���஡�� �� ࠧ.
goto ask_what_to_do

:add_record
cls
echo #########################################################################
echo #                                                                       #
echo #                     �����祭�� �ਮ��� ������                    #
echo #                                                                       #
echo #########################################################################
@echo.
@echo.
set process_name=
set /P process_name="������ �������� ����� (�ਬ��: example.exe): ":
@echo.
echo �롥�� �ਮ��� ��� �����:
echo H - High (��᮪��);
echo A - AboveNormal (��� �।����);
echo N - Normal (�।���);
echo B - BelowNormal (���� �।����);
echo I - Idle (������).

:set_process_priority
@echo.
set process_priority=
choice /C IBNAH /N /M "H, A, N, B ��� I? "
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
echo �⢥� �� ����. ���஡�� �� ࠧ.
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
echo #            �������� �����祭���� ࠭�� �ਮ��� �����            #
echo #                                                                       #
echo #########################################################################
@echo.
@echo.
echo �믮����� ���� ࠧ����� ॥��� ��� ����ᮢ � ��ࠬ��஬ CpuPriorityClass?
choice /C NY /N /T 10 /D Y /M "(Y - ��, N - ���.) "
@echo.
if errorlevel 2 (
	reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /s /v CpuPriorityClass
	@echo.
	choice /C YN /N /M "�த������ ��楤��� 㤠����� (Y - ��, N - ���.) "
	if errorlevel 2 goto ask_about_continue_working
)
@echo.
set process_name=
set /P process_name="������ �������� ����� (�ਬ��: example.exe): ":
@echo.
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process_name%"
set process_name=

:ask_about_continue_working
@echo.
choice /C NY /N /M "�த������ ࠡ���? (Y - ��, N - ���.) "
::Yes
if errorlevel 2	(
	cls
	goto ask_what_to_do
)
::No
if errorlevel 1 goto end_script

:end_script
exit
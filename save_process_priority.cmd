::Copyright c 2011 Tsiryuta G. N. <spbtgn@gmail.com>
@echo off
cls
	:start_prog
echo            Copyright ^c 2011 Tsiryuta G. N. ^<spbtgn^@gmail.com^>
echo.
set question1=
set question2=
set question3=
echo ###########################################################################
echo #                                                                         #
echo #     � ������� �⮣� ����⭮�� 䠩�� �� ����� �������� �ਮ���       #
echo #  ��� ������, � ����� �� �㤥� �ᥣ�� ��⮬���᪨ ����᪠����,  #
echo #          ���� �� 㤠���� �����祭�� ���� ࠭�� �ਮ���.              #
echo #                                                                         # 
echo ###########################################################################
@echo.
	:qstn1
set question1=
set question2=
set question3=
@echo.
echo �롥�� �������� ������:
echo 1 - �������� �ਮ��� ��।�������� ������;
echo 2 - ������� ������ � �����祭��� ࠭�� �ਮ��� ��।�������� ������;
echo 3 - ���.
@echo.
set /P question1="������ ���� �� ���, ᮮ⢥�������� �������� ����樨 (�ਬ��: 2): ":
@echo.
@echo.
if %question1%==1 (
	goto create_record
} else (
	goto q1_ans2
)
	:q1_ans2
if %question1%==2 (
	goto delete_record
) else (
	goto q1_ans3
)
	:q1_ans3
if %question1%==3 (
	goto end_prog
) else (
	echo �⢥� �� ����. ���஡�� �� ࠧ.
	goto qstn1
)
	:create_record
@echo.
set question1=
set question2=
set /P question2="������ �������� ����� (�ਬ��: example.exe): ":
@echo.
echo ##################################################
echo #                                                #
echo #   �������� �ਮ���� ��� ����ᮢ:          #
echo #   1 - �ਮ��� Idle (������);                 #
echo #   2 - �ਮ��� BelowNormal (���� �।����);   #
echo #   3 - �ਮ��� Normal (�।���);              #
echo #   4 - �ਮ��� AboveNormal (��� �।����);   #
echo #   5 - �ਮ��� High (��᮪��).                #
echo #                                                #
echo ##################################################
@echo.
	:qstn3
set question3=
set /P question3="������ ���� �� ���, ᮮ⢥�������� ��।�������� �ਮ���� (�ਬ��: 1): ":
if %question3%==1 (
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%question2%\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 0x00000001
	goto continue_qstn
) else (
	goto q3_ans2
)
	:q3_ans2
if %question3%==2 (
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%question2%\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 0x00000005
	goto continue_qstn
) else (
	goto q3_ans3
)
	:q3_ans3
if %question3%==3 (
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%question2%\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 0x00000008
	goto continue_qstn
) else (
	goto q3_ans4
)
	:q3_ans4
if %question3%==4 (
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%question2%\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 0x00000006
	goto continue_qstn
) else (
	goto q3_ans5
)
	:q3_ans5
if %question3%==5 (
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%question2%\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 0x00000003
	goto continue_qstn
) else (
	echo �� ����� ���ࠢ��쭮� ���祭��. �롥�� ���祭�� �� ᯨ᪠ ��� � ������ ����.
	goto qstn3
)
set question2=
set question3=
goto continue_qstn
	:delete_record
@echo.
set question1=
set question2=
set /P question2="������ �������� ����� (�ਬ��: example.exe): ":
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%question2%"
set question2=
	:continue_qstn
@echo.
set /P continue_question="���� �த������ ࠡ���� � ����⭮� 䠩��? (y - ��; n - ���): ":
@echo.
if "%continue_question%"=="y" (
	goto qstn1
} else (
	goto c_q_ans_n
)
	:c_q_ans_n
if "%continue_question%"=="n" (
	goto end_prog
} else (
	echo �⢥� �� ����. ���஡�� �� ࠧ.
	goto continue_qstn
)
	:end_prog
exit
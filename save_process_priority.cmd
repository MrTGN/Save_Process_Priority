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
echo #     С помощью этого пакетного файла вы можете назначить приоритет       #
echo #  любому процессу, с которым он будет всегда автоматически запускаться,  #
echo #          либо же удалить назначенный вами ранее приоритет.              #
echo #                                                                         # 
echo ###########################################################################
@echo.
	:qstn1
set question1=
set question2=
set question3=
@echo.
echo Выберите желаемую операцию:
echo 1 - Назначить приоритет определенному процессу;
echo 2 - Удалить запись о назначенном ранее приоритете определенному процессу;
echo 3 - Выйти.
@echo.
set /P question1="Введите одну из цифр, соответствующую желаемой операции (Пример: 2): ":
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
	echo Ответ не верный. Попробуйте еще раз.
	goto qstn1
)
	:create_record
@echo.
set question1=
set question2=
set /P question2="Введите название процесса (Пример: example.exe): ":
@echo.
echo ##################################################
echo #                                                #
echo #   Возможные приоритеты для процессов:          #
echo #   1 - приоритет Idle (низкий);                 #
echo #   2 - приоритет BelowNormal (ниже среднего);   #
echo #   3 - приоритет Normal (средний);              #
echo #   4 - приоритет AboveNormal (выше среднего);   #
echo #   5 - приоритет High (высокий).                #
echo #                                                #
echo ##################################################
@echo.
	:qstn3
set question3=
set /P question3="Введите одну из цифр, соответствующую определенному приоритету (Пример: 1): ":
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
	echo Вы ввели неправильное значение. Выберите значение из списка выше и повторите ввод.
	goto qstn3
)
set question2=
set question3=
goto continue_qstn
	:delete_record
@echo.
set question1=
set question2=
set /P question2="Введите название процесса (Пример: example.exe): ":
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%question2%"
set question2=
	:continue_qstn
@echo.
set /P continue_question="Хотите продолжить работать в пакетном файле? (y - Да; n - Нет): ":
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
	echo Ответ не верный. Попробуйте еще раз.
	goto continue_qstn
)
	:end_prog
exit
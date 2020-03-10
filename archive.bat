@SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1251

rem ********************************************
rem ���� � ����� ��������� 7-zip
set BACKUPZIP="C:\Program Files\7-Zip\7z.exe"
rem ���� � ����� �� ������� ��� (��� �������) - ������: ��� (��������) "���� � ������" 
set SPISOKBAZ=E:\scrypt\base.txt
rem ���� � ����� ���������� ������
set BACKUPLOCDIR="E:\backup"
rem ������� ������� (�����) ������� ��������� ������
set BACKUPLOCDIRTIME=03
rem ���� � ����� ��� ����� �������� ����� � ���������� ������� �������
set BACKUPOTCHET=%BACKUPLOCDIR%
rem ���� � ����� �� ������� ����� 1 ���� ����� ����������� ����� � ����� ���������� ������
set BACKUPNETDISK1="\\backupserver\backup"
rem ������� ���� 1 ����� ������������� ��� ���������. ��� �����.
set BACKUPNETDISKLOC1=Y
rem ������������ �������� ����� 1
set BACKUPNETDISK1USER=Administrator
rem ������ ������������ �������� ����� 1
set BACKUPNETDISK1PASSW=
rem ������� ������� ������� ������ �� ������� ����� 1
set BACKUPNETDISK1TIME=03
rem ���� � ����� �� ������� ����� 2 ���� ����� ����������� ����� � ����� ���������� ������
set BACKUPNETDISK2="\\backupserver2\backup\"
rem ������� ���� 2 ����� ������������� ��� ���������. ��� �����.
set BACKUPNETDISKLOC2=H
rem ������������ �������� ����� 2
set BACKUPNETDISK2USER=user
rem ������ ������������ �������� ����� 2
set BACKUPNETDISK2PASSW=
rem ������� ������� ������� ������ �� ������� ����� 2
set BACKUPNETDISK2TIME=03


rem ********����������� �� �����*****************************************
rem ���� � ��������� blat
set file_blat=E:\scrypt\blat3222\full\blat.exe
rem SMTP ������ ��� �������� ���������, �������� smtp.mail.ru
set from_server=127.0.0.1
rem ���� SMTP ������� ��� ��������, �������� 25 ����
set from_port=25
rem ������ ������������ �� �������� ����� ���������� ���������
set from_mail=backup@mail.ru
rem ������ ������������ �� �������� ������������ ���������
set from_name=backup@mail.ru
rem ������ �� ��������� ����� ������������ �� �������� ������������ ���������
set from_pass=
rem ����������� �����, ���� �� ���������� ���������
set to_mail=my@mail.ru
rem ���� ���������
set to_subject="����� � ������"


rem *********************C�����******************************************************

rem ���� ������ ������
set DAT=%date:~6,4%%date:~3,2%%date:~0,2%
rem ������� ����� � ������� ����� � ������ ���������
MKDIR %BACKUPLOCDIR%\%DAT%
echo ^<html^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h1^>^<strong^>����� �� ������^<^/strong^>^<^/h1^> >> %BACKUPOTCHET%\%DAT%\report.html

rem ����� � ��������� �����
echo ^<h2^>^<strong^>����� � ��������� �����^<^/strong^>^<^/h2^> >> %BACKUPOTCHET%\%DAT%\report.html
FOR /f  "tokens=1,2" %%a IN (%SPISOKBAZ%) DO (
echo ^<h3^>^<strong^>����� ����� %%a: ������:  >> %BACKUPOTCHET%\%DAT%\report.html
echo !TIME:~0,2!-!TIME:~3,2!-!TIME:~6,2!  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
rem
%BACKUPZIP% a -tzip -ssw -mx7 -p792328912855792328912855 -r0 %BACKUPLOCDIR%\%DAT%\%DAT%.%%a.zip %%b >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>��������� ������ ����� %%a:  >> %BACKUPOTCHET%\%DAT%\report.html
echo !TIME:~0,2!-!TIME:~3,2!-!TIME:~6,2!  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
)

rem ����������� ����� ������ � �������� ����� �� ������� ���� 2
echo ^<h2^>^<strong^>����������� ����� ������ � �������� ����� �� ������� ���� %BACKUPNETDISK2%:^<^/strong^>^<^/h2^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>������:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ������������� �������� ����� >> %BACKUPOTCHET%\%DAT%\report.html
net use %BACKUPNETDISKLOC2%: /del /yes
net use %BACKUPNETDISKLOC2%: %BACKUPNETDISK2% /user:%BACKUPNETDISK2USER% %BACKUPNETDISK2PASSW% >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ����������� ������: >> %BACKUPOTCHET%\%DAT%\report.html
Robocopy %BACKUPLOCDIR%\%DAT% %BACKUPNETDISKLOC2%:\%DAT% *.zip /DCOPY:D /COPY:D /B /MT:32 /LOG+:%BACKUPLOCDIR%\%DAT%\robocopy2.log /NP
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ������� ������ ������ ������ �� ������� �����: >> %BACKUPOTCHET%\%DAT%\report.html
forfiles /P "%BACKUPNETDISKLOC2%:" /M *.* /S /D -%BACKUPNETDISK2TIME%  /C "cmd /c del /Q /F @PATH" >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ���������� ����� %BACKUPNETDISKLOC2%:\%DAT% : >> %BACKUPOTCHET%\%DAT%\report.html
dir %BACKUPNETDISKLOC2%:\%DAT% /D /B >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
rem ���������� �������� �����
net use %BACKUPNETDISKLOC2%: /del /yes
echo ^<h3^>^<strong^>��������� ����������� ������ �� ������� ����:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html


rem ����������� ����� ������ � �������� ����� �� ������� ����1
echo ^<h2^>^<strong^>����������� ����� ������ � �������� ����� �� ������� ���� %BACKUPNETDISK1%:^<^/strong^>^<^/h2^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>������:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ������������� �������� ����� >> %BACKUPOTCHET%\%DAT%\report.html
net use %BACKUPNETDISKLOC1%: /del /yes
net use %BACKUPNETDISKLOC1%: %BACKUPNETDISK1% /user:%BACKUPNETDISK1USER% %BACKUPNETDISK1PASSW% >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ����������� ������: >> %BACKUPOTCHET%\%DAT%\report.html
Robocopy %BACKUPLOCDIR%\%DAT% %BACKUPNETDISKLOC1%:\%DAT% *.zip /B /MT:32 /LOG:%BACKUPLOCDIR%\%DAT%\robocopy1.log /NP
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ������� ������ ������ ������ �� ������� �����: >> %BACKUPOTCHET%\%DAT%\report.html
forfiles /P "%BACKUPNETDISKLOC1%:" /M *.* /S /D -%BACKUPNETDISK1TIME%  /C "cmd /c del /Q /F @PATH" >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ���������� ����� %BACKUPNETDISKLOC1%:\%DAT% : >> %BACKUPOTCHET%\%DAT%\report.html
dir %BACKUPNETDISKLOC1%:\%DAT% /D /B >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
rem ���������� �������� �����
net use %BACKUPNETDISKLOC1%: /del /yes
echo ^<h3^>^<strong^>��������� ����������� ������ �� ������� ����:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html



echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ������� ������ ������ ������ �� ��������� �����: >> %BACKUPOTCHET%\%DAT%\report.html
forfiles /P "%BACKUPLOCDIR%" /M *.* /S /D -%BACKUPLOCDIRTIME%  /C "cmd /c del /Q /F @PATH" >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>��������� �������:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<html^> >> %BACKUPOTCHET%\%DAT%\report.html

rem ���� ������ � ������
set file_text=%BACKUPOTCHET%\%DAT%\report.html
rem �������������� ������� ���� log_blat.txt, ��� ����� �������� ���� 
set file_log=%BACKUPOTCHET%\%DAT%\log_blat.txt
echo logs > %file_log%
rem ������� �������� ����������� �� ����� � �������� ������
%file_blat% %file_text% -server %from_server%:%from_port% -f %from_mail% -u %from_name% -pw %from_pass% -to %to_mail% -s %to_subject% -log %file_log%
set file_text=%BACKUPLOCDIR%\%DAT%\robocopy1.log
rem ������� �������� ����������� �� ����� � �������� ����������� � ������� ����� 1
set to_subject="����� (robocopy) %BACKUPNETDISK1%"
%file_blat% %file_text% -server %from_server%:%from_port% -f %from_mail% -u %from_name% -pw %from_pass% -to %to_mail% -s %to_subject% -log %file_log%
rem ������� �������� ����������� �� ����� � �������� ����������� � ������� ����� 2
set file_text=%BACKUPLOCDIR%\%DAT%\robocopy2.log
set to_subject="����� (robocopy) %BACKUPNETDISK2%"
%file_blat% %file_text% -server %from_server%:%from_port% -f %from_mail% -u %from_name% -pw %from_pass% -to %to_mail% -s %to_subject% -log %file_log%
@SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1251

rem ********************************************
rem Путь к папке программы 7-zip
set BACKUPZIP="C:\Program Files\7-Zip\7z.exe"
rem Путь к файлу со списком баз (без кавычек) - формат: имя (латиница) "путь к файлам" 
set SPISOKBAZ=E:\scrypt\base.txt
rem Путь к папке локального бэкапа
set BACKUPLOCDIR="E:\backup"
rem Сколько времени (сутки) хранить локальные бэкапы
set BACKUPLOCDIRTIME=03
rem Путь к папке где будет хранится отчет о выполнении данного скрипта
set BACKUPOTCHET=%BACKUPLOCDIR%
rem Путь к папке на сетевом диске 1 куда будут копироватся файлы с папки локального бэкапа
set BACKUPNETDISK1="\\backupserver\backup"
rem Сетевой диск 1 будет монтироваться как локальный. Имя диска.
set BACKUPNETDISKLOC1=Y
rem Пользователь сетевого диска 1
set BACKUPNETDISK1USER=Administrator
rem Пароль пользователя сетевого диска 1
set BACKUPNETDISK1PASSW=
rem Сколько времени хранить бэкапы на сетевом диске 1
set BACKUPNETDISK1TIME=03
rem Путь к папке на сетевом диске 2 куда будут копироватся файлы с папки локального бэкапа
set BACKUPNETDISK2="\\backupserver2\backup\"
rem Сетевой диск 2 будет монтироваться как локальный. Имя диска.
set BACKUPNETDISKLOC2=H
rem Пользователь сетевого диска 2
set BACKUPNETDISK2USER=user
rem Пароль пользователя сетевого диска 2
set BACKUPNETDISK2PASSW=
rem Сколько времени хранить бэкапы на сетевом диске 2
set BACKUPNETDISK2TIME=03


rem ********уведомления на почту*****************************************
rem Путь к программе blat
set file_blat=E:\scrypt\blat3222\full\blat.exe
rem SMTP сервер для отправки сообщения, например smtp.mail.ru
set from_server=127.0.0.1
rem Порт SMTP сервера для отправки, например 25 порт
set from_port=25
rem Данные пользователя от которого будет отправлено сообщение
set from_mail=backup@mail.ru
rem Данные пользователя от которого отправляется сообщение
set from_name=backup@mail.ru
rem Пароль от почтового ящика пользователя от которого отправляется сообщение
set from_pass=
rem Электронный адрес, кому мы отправляем сообщение
set to_mail=my@mail.ru
rem Тема сообщения
set to_subject="Отчет о бэкапе"


rem *********************Cкрипт******************************************************

rem Дата начала бэкапа
set DAT=%date:~6,4%%date:~3,2%%date:~0,2%
rem создаем папку с текущей датой и файлом сообщения
MKDIR %BACKUPLOCDIR%\%DAT%
echo ^<html^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h1^>^<strong^>Отчет по бэкапу^<^/strong^>^<^/h1^> >> %BACKUPOTCHET%\%DAT%\report.html

rem бэкап в локальную папку
echo ^<h2^>^<strong^>Бэкап в локальную папку^<^/strong^>^<^/h2^> >> %BACKUPOTCHET%\%DAT%\report.html
FOR /f  "tokens=1,2" %%a IN (%SPISOKBAZ%) DO (
echo ^<h3^>^<strong^>Бэкап папки %%a: начало:  >> %BACKUPOTCHET%\%DAT%\report.html
echo !TIME:~0,2!-!TIME:~3,2!-!TIME:~6,2!  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
rem
%BACKUPZIP% a -tzip -ssw -mx7 -p792328912855792328912855 -r0 %BACKUPLOCDIR%\%DAT%\%DAT%.%%a.zip %%b >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>Окончание бэкапа папки %%a:  >> %BACKUPOTCHET%\%DAT%\report.html
echo !TIME:~0,2!-!TIME:~3,2!-!TIME:~6,2!  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
)

rem Копирование папки бэкапа с заданной датой на сетевой диск 2
echo ^<h2^>^<strong^>Копирование папки бэкапа с заданной датой на сетевой диск %BACKUPNETDISK2%:^<^/strong^>^<^/h2^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>Начало:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Присоединение сетевого диска >> %BACKUPOTCHET%\%DAT%\report.html
net use %BACKUPNETDISKLOC2%: /del /yes
net use %BACKUPNETDISKLOC2%: %BACKUPNETDISK2% /user:%BACKUPNETDISK2USER% %BACKUPNETDISK2PASSW% >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Копирование файлов: >> %BACKUPOTCHET%\%DAT%\report.html
Robocopy %BACKUPLOCDIR%\%DAT% %BACKUPNETDISKLOC2%:\%DAT% *.zip /DCOPY:D /COPY:D /B /MT:32 /LOG+:%BACKUPLOCDIR%\%DAT%\robocopy2.log /NP
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Очистка старых файлов бэкапа на сетевом диске: >> %BACKUPOTCHET%\%DAT%\report.html
forfiles /P "%BACKUPNETDISKLOC2%:" /M *.* /S /D -%BACKUPNETDISK2TIME%  /C "cmd /c del /Q /F @PATH" >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Содержимое папки %BACKUPNETDISKLOC2%:\%DAT% : >> %BACKUPOTCHET%\%DAT%\report.html
dir %BACKUPNETDISKLOC2%:\%DAT% /D /B >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
rem Отключение сетевого диска
net use %BACKUPNETDISKLOC2%: /del /yes
echo ^<h3^>^<strong^>Окончание копирования файлов на сетевой диск:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html


rem Копирование папки бэкапа с заданной датой на сетевой диск1
echo ^<h2^>^<strong^>Копирование папки бэкапа с заданной датой на сетевой диск %BACKUPNETDISK1%:^<^/strong^>^<^/h2^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>Начало:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Присоединение сетевого диска >> %BACKUPOTCHET%\%DAT%\report.html
net use %BACKUPNETDISKLOC1%: /del /yes
net use %BACKUPNETDISKLOC1%: %BACKUPNETDISK1% /user:%BACKUPNETDISK1USER% %BACKUPNETDISK1PASSW% >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Копирование файлов: >> %BACKUPOTCHET%\%DAT%\report.html
Robocopy %BACKUPLOCDIR%\%DAT% %BACKUPNETDISKLOC1%:\%DAT% *.zip /B /MT:32 /LOG:%BACKUPLOCDIR%\%DAT%\robocopy1.log /NP
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Очистка старых файлов бэкапа на сетевом диске: >> %BACKUPOTCHET%\%DAT%\report.html
forfiles /P "%BACKUPNETDISKLOC1%:" /M *.* /S /D -%BACKUPNETDISK1TIME%  /C "cmd /c del /Q /F @PATH" >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Содержимое папки %BACKUPNETDISKLOC1%:\%DAT% : >> %BACKUPOTCHET%\%DAT%\report.html
dir %BACKUPNETDISKLOC1%:\%DAT% /D /B >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
rem Отключение сетевого диска
net use %BACKUPNETDISKLOC1%: /del /yes
echo ^<h3^>^<strong^>Окончание копирования файлов на сетевой диск:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html



echo ^<p^>^<strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo Очистка старых файлов бэкапа на локальном диске: >> %BACKUPOTCHET%\%DAT%\report.html
forfiles /P "%BACKUPLOCDIR%" /M *.* /S /D -%BACKUPLOCDIRTIME%  /C "cmd /c del /Q /F @PATH" >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/p^>^<^/strong^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<h3^>^<strong^>Окончание очистки:  >> %BACKUPOTCHET%\%DAT%\report.html
echo %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%  >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<^/strong^>^<^/h3^> >> %BACKUPOTCHET%\%DAT%\report.html
echo ^<html^> >> %BACKUPOTCHET%\%DAT%\report.html

rem Файл отчета о бэкапе
set file_text=%BACKUPOTCHET%\%DAT%\report.html
rem Предварительно создаем файл log_blat.txt, где будут ложиться логи 
set file_log=%BACKUPOTCHET%\%DAT%\log_blat.txt
echo logs > %file_log%
rem команда отправки уведомления на почту о процессе бэкапа
%file_blat% %file_text% -server %from_server%:%from_port% -f %from_mail% -u %from_name% -pw %from_pass% -to %to_mail% -s %to_subject% -log %file_log%
set file_text=%BACKUPLOCDIR%\%DAT%\robocopy1.log
rem команда отправки уведомления на почту о процессе копирования в сетевую папку 1
set to_subject="Отчет (robocopy) %BACKUPNETDISK1%"
%file_blat% %file_text% -server %from_server%:%from_port% -f %from_mail% -u %from_name% -pw %from_pass% -to %to_mail% -s %to_subject% -log %file_log%
rem команда отправки уведомления на почту о процессе копирования в сетевую папку 2
set file_text=%BACKUPLOCDIR%\%DAT%\robocopy2.log
set to_subject="Отчет (robocopy) %BACKUPNETDISK2%"
%file_blat% %file_text% -server %from_server%:%from_port% -f %from_mail% -u %from_name% -pw %from_pass% -to %to_mail% -s %to_subject% -log %file_log%
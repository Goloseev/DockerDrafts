REM ПРИМЕР СОЗДАНИЯ РЕЗЕРВНОЙ КОПИИ БАЗЫ ДАННЫХ POSTGRESQL
CLS
ECHO OFF

@: включим поддержку русских символов способ 1
rem CHCP 1251
@: включим поддержку русских символов
chcp 65001

SET Script_Folder=%~dp0
Echo    - Запущен скрипт бэкап базы %PGDATABASE% в файл %DUMPPATH%


REM ------- УСТАНОВКА ВАЖНЫХ ПАРАМЕТРОВ --------------
SET PGDATABASE=Buh_Frutella
SET Pause_After_Finish=false
SET PGBIN=C:\Program Files\PostgreSQL\12.5-3.1C\bin
SET PGHOST=localhost
SET PGPORT=6432
SET PGUSER=postgres
SET PGPASSWORD=Jnrhsnm1
SET Backup_Folder=%Script_Folder%
REM а можно и так... SET Backup_Folder=E:\_pg_Backups
Rem Используем для архивных копий подкаталог с именем базы
Set UseSubDirInBackupFolder=false
Set BackupName_UsePostFix=None

REM ------- УСТАНОВКА ПРОЧИХ ПАРАМЕТРОВ --------------
IF %UseSubDirInBackupFolder%==true (
	Echo    - использую поддиректорию с именем базы
	SET Backup_Folder=%Backup_Folder%%PGDATABASE%_backup
	) 


SET Backup_Hystory_FileName=BackUP_Hystory_%PGDATABASE%.log
SET DATETIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
SET Month_Day=%DATE:~0,2%
Rem определим номер дня недели
For /F "Skip=1" %%i In ('WMIC Path Win32_LocalTime Get DayOfWeek') Do Set /A $DayOfWeek=%%i+1&GoTo DayOfWeek
:DayOfWeek
For /F "Tokens=%$DayOfWeek% Delims=," %%i In ("Воскресенье,Понедельник,Вторник,Среда,Четверг,Пятница,Суббота") Do Set $DayOfWeekName=%%i
Rem Echo День недели  : %$DayOfWeekName% (%$DayOfWeek%-й день недели)

REM -------НАЗНАЧИМ ИМЯ ДАМПА ФАЙЛА --------------
IF %BackupName_UsePostFix%==DateTime (
	Echo    - в имя архива добавляю дату и время
	SET DUMPFILE=%PGDATABASE%_%DATETIME%.backup
	SET LOGFILE=%PGDATABASE%_%DATETIME%.log
	) ELSE IF %BackupName_UsePostFix%==Day (
		Echo    - в имя архива добавляю день Day%Month_Day%
		SET DUMPFILE=%PGDATABASE%_Day%Month_Day%.backup
		SET LOGFILE=%PGDATABASE%_Day%Month_Day%.log
	) ELSE IF %BackupName_UsePostFix%==DayOfWeek (
		Echo    - в имя архива добавляю имя дня недели %$DayOfWeekName%
		SET DUMPFILE=%PGDATABASE%_%$DayOfWeekName%.backup
		SET LOGFILE=%PGDATABASE%_%$DayOfWeekName%.log

	) ELSE (
		Echo    - в имя архива не добавляю даты или времени
		SET DUMPFILE=%PGDATABASE%.backup
		SET LOGFILE=%PGDATABASE%.log
	)



SET DUMPPATH="%Backup_Folder%\%DUMPFILE%"
SET LOGPATH="%Backup_Folder%\%LOGFILE%"


REM Смена диска и переход в папку из которой запущен bat-файл
%~d0
CD %~dp0



REM -------Создадим каталог для архивной копии, если он еще не существует --------------
IF NOT EXIST %Backup_Folder% (
	Echo    - Создаю каталог "%Backup_Folder%
	MD %Backup_Folder%
	Rem Проверяю удалось ли создать каталог...
	IF NOT EXIST %Backup_Folder% (
		Echo НЕ УДАЛОСЬ СОЗДАТЬ КАТАЛОГ %Backup_Folder% ОСТАНАВЛИВАЮ СКРИПТ!!!!!!!
		GOTO End
		) ELSE (
		Echo    - Успешно создал каталог "%Backup_Folder%
		)
	) 

REM -------НЕПОСРЕДСТВЕННО ЗАПУСК ПРОЦЕСА ДАМПА --------------
ECHO    - Запускаю процесс "%PGBIN%\pg_dump.exe" --format=custom --verbose --file=%DUMPPATH% 2>%LOGPATH%
CALL "%PGBIN%\pg_dump.exe" --format=custom --verbose --file=%DUMPPATH% 2>%LOGPATH%
ECHO    - процесс pg_dump закончился 


REM ------- Анализ кода завершения --------------
IF NOT %ERRORLEVEL%==0 (
	ECHO    - получил ERRORLEVEL равным %ERRORLEVEL%
	GOTO Error
	) ELSE (
	ECHO    - процесс pg_dump выдал ответ об успешном выполнении
	)


REM ------- Проверим существует ли файл с копией --------------
IF NOT EXIST %DUMPPATH% (
	GOTO Error
	) ELSE (
	ECHO    - подтверждено наличие бэкапа %DUMPPATH%
	GOTO Successfull
	)


ECHO    - ЭТА СТРОЧКА НИКОГДА НЕ ИСПОЛНИТСЯ, ПОТОМУ КАК ТОЛЬКО ЧТО УКАЗАНО ПЕРЕХОДИТЬ НА ERROR ИЛИ Successfull


:Error
REM ------- В случае ошибки удаляется поврежденная резервная копия и делается соответствующая запись в журнале --------------
ECHO    - удаляю поврежденный бэкап %DUMPPATH%. Подробности в %LOGFILE%
DEL %DUMPPATH%
ECHO %DATETIME% Ошибки при создании резервной копии базы данных %DUMPFILE%. Смотрите отчет %LOGFILE%. >> %PGDATABASE%_backup%_hystory.log
GOTO End


:Successfull
REM ------- В случае удачного резервного копирования просто делается запись в журнал --------------
ECHO    - успешно создал резервную копию %DUMPPATH%
ECHO %DATETIME% Успешно создал резервную копию %DUMPPATH% >> %PGDATABASE%_backup%_hystory.log



:End
IF %Pause_After_Finish%==true (
pause
)


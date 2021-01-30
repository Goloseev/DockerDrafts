@ECHO OFF
chcp 1251
ECHO ------------Installing PostgreSQL service
@SET PATH="C:\Program Files\PostgreSQL\12.5-3.1C"
@SET PGDATA="D:\2021_Postgre12_5_3_port8432_DB"
@SET PGDATABASE=postgres
@SET PGUSER=postgres
@SET PGPORT=8439
@Set PGSeviceName=pgsql_1C_port_%PGPORT%
@SET PGLOCALEDIR=%PATH%\share\locale
REM ------------Installing PostgreSQL service on port %PGPORT% 
%PATH%\bin\initdb -D %PGDATA% -U postgres -A trust
rem %PATH%\bin\pg_ctl register -N %PGSeviceName% -D %PGDATA% -l logfile
ECHO ----------You need to replace conf file and port in itv--------------
pause
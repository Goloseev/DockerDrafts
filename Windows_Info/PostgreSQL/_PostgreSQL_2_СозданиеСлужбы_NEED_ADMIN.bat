@ECHO ON
chcp 1251
REM ------------Installing PostgreSQL servict 
@SET PATH="C:\Program Files\PostgreSQL\12.5-3.1C"
@SET PGDATA="D:\2021_Postgre12_5_3_port8432_DB"
@SET PGPORT=8439
@Set PGSeviceName=pgsql_1C_port_%PGPORT%
REM ------------Installing PostgreSQL service on port %PGPORT%
%PATH%\bin\pg_ctl register -N %PGSeviceName% -D %PGDATA% -l logfile
pause
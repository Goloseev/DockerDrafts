set kat=C:\Program Files (x86)\1cv8\8.3.18.1208
set serv=localhost
set base=Buh_Frutella
set user=Cobian_Архиватор
set pass=Cobian_Архиватор1
set passblok=КодРазрешения
set path_to_log_file=E:\_Cobian_Backups\BUH_Frutella_dt\log_%base%.log
set pathexport=E:\_Cobian_Backups\BUH_Frutella_dt

rem Делаю копию
"%kat%\bin\1cv8.exe" DESIGNER /S %serv%\%base% /N %user% /P %pass% /DumpIB "%pathexport%\archive_%base%.dt" /UC %passblok% /Out%path_to_log_file% 


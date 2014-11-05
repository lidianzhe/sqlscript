set mypara=-S .\sqlexpress -U sa -P mysql1324! -i
osql %mypara% CreateDatabase.sql
osql %mypara%  01.00.00.Tables.sql
osql %mypara%  vw_Personnel.sql
osql %mypara% base_Organizations_GenSequalData.proc.sql
osql %mypara% Update.base_Personnel.sql
pause

set mypara=-uroot -p000000
rem create database...
mysql %mypara% <database.sql
rem create tables...
mysql %mypara% <tables.sql 
rem create functions...
mysql %mypara% <functions.sql
rem create procedure...
mysql %mypara% <procedures.sql


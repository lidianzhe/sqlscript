--����Ŀ¼
exec master..xp_cmdshell 'if not exist c:\database md c:\database'

if not exists (select 1 from master.dbo.sysdatabases
			where has_dbaccess(name) = 1 and name='azBase') 
begin
--�������ݿ�
create database azBase on
 (
	name= azBase_dat,
	filename='c:\database\azBase.mdf',
	size = 5
)
 log on
(
	name= azBase_log,
	filename='c:\database\azBase_log.ldf',
	size = 1
)
--����ģʽ
alter database azBase set recovery SIMPLE

end  --end create database


--����Ŀ¼
exec master..xp_cmdshell 'if not exist c:\database md c:\database'

if not exists (select 1 from master.dbo.sysdatabases
			where has_dbaccess(name) = 1 and name='azInterface') 
begin
--�������ݿ�
create database azInterface on
 (
	name= azInterface_dat,
	filename='c:\database\azInterface.mdf',
	size = 5
)
 log on
(
	name= azInterface_log,
	filename='c:\database\azInterface_log.ldf',
	size = 1
)
--����ģʽ
alter database azInterface set recovery SIMPLE

end  --end create database


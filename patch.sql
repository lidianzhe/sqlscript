alter table enrolltable add if_UserNo integer;
update enrolltable set if_UserNo=Name;
insert into configsettings(DeviceId,SeriesId,Mode,HostAddress,HostPort)
	values(1,2,0,'10.1.121.10',1234);


create table InoutRecords (
    InoutId integer  not null primary key  autoincrement , --主关键字，自动增量
    PersonId int not null, --人员Id
    --CardId  int , --卡号,冗余
    --MobilePhone  int ,--手机号码，冗余
    InoutTime datetime not null, --刷卡时间
    InoutFlag smallint not null -- 进出标识， 0＝进，1＝出
);

create table PersonCodes(
	pid integer not null primary key autoincrement,
	PersonId int not null,
	CardId int not null,
	Arrears int 
);

create table Devices(
	DeviceId integer not null primary key,
	IPAddress char(16) not null,
	InoutFlag smallint not null
);


create index UX_InoutRecords_PersonId on InoutRecords(PersonId);
create index UX_PersonCodes_CardId on PersonCodes(CardId);
create index UX_Devices_IPAddress on Devices(IPAddress);

create table ConfigSettings(
	DeviceId int not null primary key,
	DeviceNo varchar(20),
	SeriesId tinyint,
	Mode	tinyint, --0=上 1=下 2=上下混用 
	AllowSwitchMode	boolean,
	AllowEnroll boolean,
	UploadPosition integer,
	DownloadPosition integer
);
	
create table PersonIris(
	PersonId int not null primary key,
	Name varchar(20), --冗余
	LeftIrisTemplate varchar(1024),
	RightIrisTemplate varchar(1024),
	LeftIrisPath Text,
	RightIrisPath Text,
	FaceImagePath Text,
	if_UserNo interger,
	LastUpdatedTime	datetime
);
create table InoutDetails(
	PId integer not null primary key autoincrement,
	DeviceNo varchar(20) ,
	PersonId int null,
	CardTime datetime,
	Flag tinyint,
	SeriesId tinyint,
	if_UserNo integer --冗余
);

	

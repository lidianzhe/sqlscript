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
	LeftIrisTemplate blob,
	RightIrisTemplate blob,
	LeftIrisPath Text,
	RightIrisPath Text,
	FaceImagePath Text,
	LastUpdatedTime	datetime
);
create table InoutDetails(
	PId integer not null primary key autoincrement,
	DeviceId int not null,
	PersonId int null,
	CardTime datetime,
	Flag tinyint,
	SeriesId tinyint
);

	

create table InoutRecords (
    InoutId integer  not null primary key  autoincrement , --���ؼ��֣��Զ�����
    PersonId int not null, --��ԱId
    --CardId  int , --����,����
    --MobilePhone  int ,--�ֻ����룬����
    InoutTime datetime not null, --ˢ��ʱ��
    InoutFlag smallint not null -- ������ʶ�� 0������1����
);

create table PersonCodes(
	pid integer not null primary key autoincrement,
	PersonId int not null,
	CardId int not null,
	Arrears int 
);


create index UX_InoutRecords_PersonId on InoutRecords(PersonId);
create index UX_PersonCodes_CardId on PersonCodes(CardId);


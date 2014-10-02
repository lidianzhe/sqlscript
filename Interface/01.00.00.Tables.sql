use azInterface
/*---------------------------------------------------------------
Author: lihongjun 2014-09-05 10:29
�Ž��ӿ�˵����
	1��ʵʱ��if_InoutRecords���в���ˢ����¼��
	2���ؼ�����PersonIdΪ׼�����������CardId��MobilePhone���������ֶο���Ϊ�ա�
	3��if_InoutRecords����ʷ��Ǩ�ƵĹ��� �����ø�����
*/---------------------------------------------------------------

/*�����*/
if object_id('if_InoutRecords') is not null
	drop table if_InoutRecords
go
if object_id('if_InoutHistory') is not null
	drop table if_InoutHistory
go
---------------------------------------------------------------------------------------------------------
/*
�Ž������¼��(ֻ����50�������)
*/
create table if_InoutRecords (
    InoutId int   identity(1,1) not null primary key  , --���ؼ��֣��Զ�����
    PersonId int not null, --��ԱId
    CardId  int , --����,����
    MobilePhone  int ,--�ֻ����룬����
    InoutTime datetime not null, --ˢ��ʱ��
    InoutFlag smallint not null -- ������ʶ�� 0������1����
);
go
create index UX_InoutRecords_PersonId on if_InoutRecords(PersonId)
go
/*�Ž������¼��ʷ���ݣ�����*/
create table if_InoutHistory (
    InoutId int   identity(1,1) not null primary key  , --���ؼ��֣��Զ�����
    PersonId int not null, --��ԱId
    CardId  int , --����,����
    MobilePhone  int ,--�ֻ����룬����
    InoutTime datetime not null, --ˢ��ʱ��
    InoutFlag smallint not null -- ������ʶ�� 0������1����
);
go


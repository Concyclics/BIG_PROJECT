#by concyclics
#DatabaseSystem experiment2 SPJ
#Defination for db_SPJ

#供应商表
create table S
(
	SNO varchar(10) not null,
	SNAME varchar(10) unique,
	STATUS int,
	CITY varchar(10),
	primary key(SNO)
);

#零件表
create table P
(
	PNO varchar(20),
	PNAME varchar(10),
	COLOR varchar(10),
	WEIGHT int check (WEIGHT>0),
	primary key(PNO)
);

#工程项目表
create table J
(
	JNO varchar(10),
	JNAME varchar(10) default '工厂',
	CITY varchar(10),
	primary key(JNO)
);

#供应情况表
create table SPJ
(
	SNO varchar(10) default 'S1',
	PNO varchar(10) default 'P1',
	JNO varchar(10) default 'J1',
	QTY int default 0,
	foreign key (SNO) references S(SNO)
		on delete set NULL
		on update cascade,
	foreign key (PNO) references P(PNO)
		on update cascade,
	foreign key (JNO) references J(JNO)
		on delete no action
);
#MySQL 8.0不支持set default,用触发器替代
delimiter //
create trigger SetDefault after delete on S
for each row
begin
	update SPJ set SPJ.SNO='S1' where SPJ.SNO is NULL;
end;
//
delimiter ;
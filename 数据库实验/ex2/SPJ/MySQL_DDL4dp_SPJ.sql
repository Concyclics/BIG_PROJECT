#by concyclics
#DatabaseSystem experiment2 SPJ
#Defination for db_SPJ

#供应商表
create table S
(
	SNO varchar(2) not null,
	SNAME varchar(10) unique,
	STATUS int,
	CITY varchar(10),
	primary key(SNO)
);

#零件表
create table P
(
	PNO varchar(2),
	PNAME varchar(10),
	COLOR varchar(10),
	WEIGHT int check (WEIGHT>0),
	primary key(PNO)
);


#工程项目表
create table J
(
	JNO varchar(2),
	JNAME varchar(10) default '工厂',
	CITY varchar(10),
	primary key(JNO)
);


#供应情况表
create table SPJ
(
	SNO varchar(2) not null,
	PNO varchar(2) not null,
	JNO varchar(2) not null,
	QTY int default 0,
	primary key(SNO,PNO,JNO),
	foreign key (SNO) references S(SNO)
		on delete cascade,
	foreign key (PNO) references P(PNO)
		on delete cascade,
	foreign key (JNO) references J(JNO)
		on delete cascade
);

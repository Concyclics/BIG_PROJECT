#by concyclics
#DatabaseSystem quiz in experiment2

#1创建一个临时表test，包含至少4个不同类型的属性，并指定主码
create table test
(
	id int,
	name varchar(10),
	sex char(2),
	height numeric(3, 2),
	primary key(id)
);

#2修改test表中一个已有属性为另一类型
alter table test modify height float;

#3修改test表，插入一个新的列“new_attr”，数据类型为日期型
alter table test add new_attr datetime;

#4向test表中插入2条数据
insert into test values(1,'大古','男',1.80,'2021-04-10');
insert into test values(2,'丽娜','女',1.65,'2021-04-14');

#5更新test表中某一行数据
update test set id=100, height=1.85, new_attr='2021-04-11'
where id=1;

#6按test表中某一属性升序建立索引
create index high on test(height asc);#升序
#create index high on test(height desc);#降序

show index from test;
#查询索引

#7删除test表任一索引
drop index high on test;

#8删除test表中所有数据（但保留表）
delete from test;

#9删除test表
drop table test;
	
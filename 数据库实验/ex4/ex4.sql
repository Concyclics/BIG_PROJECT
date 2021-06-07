#for database concept experiment 4
#author: Concyclics
#@2021-06-07

#1、创建U8，赋予U8在P表上的SELECT权限
create user U8 identified by '19260817';
grant select on db_spj.p to U8;


#2、创建U9，赋予U9在SPJ表上qty的UPDATE权限
create user U9;
grant update(qty) on db_spj.spj to U9;


#3、回收U9的所有权限
revoke all on *.* from U9;


#4、创建角色R2，使之拥有P表上的的SELECT和INSERT
create role 'R2';
grant select, insert on db_spj.p to R2;


#5、将R2授予U3和U8，使他们具有角色R2所包含的全部权限
grant R2 to U3, U8;
set default role R2 to U3, U8;


#6、增加R2对P表的DELETE权限，并验证U8是否具有了这个权限？
grant delete on db_spj.p to R2;


#7、创建一个作用在SPJ表上的触发器，确保无论在什么时候，qty均应大于零，否则给出错误提示并回滚此操作。请测试该触发器
delimiter //
create trigger qty_ins before insert on spj
for each row
begin
if new.qty<=0 then
	set new.sno=null;
	signal sqlstate '45000'
		set message_text='qty must > 0 !';
end if;
end;
//
delimiter ;

delimiter //
create trigger qty_upd before update on spj
for each row
begin
if new.qty<=0 then
	set new.sno=old.sno;
	set new.pno=old.pno;
	set new.jno=old.jno;
	set new.qty=old.qty;
	signal sqlstate '45000'
		set message_text='qty must > 0 !';
end if;
end;
//
delimiter ;


#8、查看SPJ上的触发器
select * from information_schema.triggers where event_object_table='spj' \G;


#9、删除SPJ上的触发器
drop trigger qty_ins, qty_upd;


/*by concyclics
 *for Database System experiment3
 *created in 2021/4/19
 *ex3.sql
 */


#a)	在上一次实验建立的数据库db_SPJ中，实现以下查询：

#[1]	找出所有供应商的姓名和所在城市。
select SNAME, CITY from S \p;

#[2]	找出所有零件的名称、颜色和重量。
select PNAME, COLOR, WEIGHT from P \p;

#[3]	找出使用了供应商S1所供应的零件的工程号码。
select distinct PNO from SPJ where SNO='S1' \p;

#[4]	找出工程J2使用的各种零件的名称和数量。
select PNAME, QTY from SPJ, P where P.PNO=SPJ.PNO and JNO='J2' \p;

#[5]	找出上海供应商供应的所有零件的零件号码。
select distinct PNO from SPJ natural join S where CITY='上海' \p;

#[6]	找出使用了上海供应商供应的零件的工程名称。
select JNAME from SPJ, S, J where S.CITY='上海' and J.JNO=SPJ.JNO and S.SNO=SPJ.SNO \p;

#[7]	找出供应工程J1零件的供应商号SNO。
select distinct SNO from SPJ where JNO='J1' \p;

#[8]	找出供应工程J1零件P1的供应商号SNO。
select SNO from SPJ where JNO='J1' and PNO='P1' \p;

#[9]	找出供应工程J1红色零件的供应商号SNO。
select distinct SNO from SPJ natural join P where JNO='J1' and COLOR='红' \p;

#[10]	找出没有使用天津供应商生产的红色零件的工程号JNO。
select distinct JNO from J where JNO not in
(select JNO from SPJ, P, S where SPJ.PNO=P.PNO and SPJ.SNO=S.SNO and S.CITY='天津' and P.COLOR='红') \p;

#[11]	求所有有关project 的信息。
select * from J \p;

#[12]	求在北京的所有project 的信息。
select * from J where CITY='北京' \p;

#[13]	求为project（工程）J1 提供part（零件）的supplier（供应商）的号码。
select distinct SNO as supplier from SPJ where JNO='J1' \p;

#[14]	求数量在300 到750 之间的发货。
select * from SPJ where QTY between 300 and 750 \p;

#[15]	求所有的零件颜色 / 城市对。注意：这里及以后所说的“所有”特指在数据库中。
select distinct COLOR,A.CITY from P, (select CITY from S union select CITY from J) as A \p;

#[16]	求所有的supplier-number / part-number / project-number 对。其中所指的供应商和工程在同一个城市。
select distinct S.SNO as supplier_number, P.PNO as part_number, J.JNO as project_number
from S, P, J where S.CITY=J.CITY \p;

#[17]	求所有的supplier-number / part-number / project-number 对。其中所指的供应商和工程不在同一个城市。
select distinct S.SNO as supplier_number, P.PNO as part_number, J.JNO as project_number
from S, P, J where S.CITY<>J.CITY \p;

#[18]	求由北京供应商提供的零件的信息。
select * from P
where PNO in (select distinct PNO from SPJ natural join S where CITY='北京') \p;

#[19]	求由北京供应商为北京工程供应的零件号。
select distinct PNO from SPJ natural join S natural join J where S.CITY='北京' \p;

#[20]	求满足下面要求的城市对，要求在第一个城市的供应商为第二个城市的工程供应零件。
select distinct S.CITY as SCITY, J.CITY as JCITY from SPJ, S, J
where SPJ.SNO=S.SNO and SPJ.JNO=J.JNO \p;

#[21]	求供应商为工程供应的零件的号码，要求供应商和工程在同一城市。
select distinct PNO from SPJ natural join S natural join J \p;

#[22]	求至少被一个不在同一城市的供应商供应零件的工程号。
select distinct J.JNO from SPJ, S, J where SPJ.SNO=S.SNO and SPJ.JNO=J.JNO and S.CITY<>J.CITY \p;

#[23]	求由同一个供应商供应的零件号的对。
select distinct A.PNO, B.PNO from SPJ as A, SPJ as B where A.SNO=B.SNO \p;

#[24]	求所有由供应商S1 供应的工程号。
select distinct JNO from SPJ where SNO='S1' \p;

#[25]	求供应商S1 供应的零件P1 的总量。
select sum(QTY) from SPJ where SNO='S1' and PNO='P1' \p;

#[26]	对每个供应给工程的零件，求零件号、工程号和相应的总量。
select PNO, JNO, sum(QTY) from SPJ group by PNO, JNO \p;

#[27]	求为单个工程供应的零件数量超过350 的零件号。
select PNO from SPJ group by PNO, JNO having sum(QTY)>350 \p;

#[28]	求由S1 供应的工程名称。
select JNAME from SPJ natural join J where SNO='S1' \p;

#[29]	求由S1 供应的零件颜色。
select distinct COLOR from SPJ natural join P where SNO='S1' \p;

#[30]	求供应给北京工程的零件号。
select distinct PNO from SPJ natural join J where CITY='北京' \p;

#[31]	求使用了S1 供应的零件的工程号。
select distinct JNO from SPJ where SNO='S1' \p;

#[32]	求status 比S1 低的供应商号码。
select SNO from S where `STATUS`<(select `STATUS` from S where SNO='S1') \p;

#[33]	求所在城市按字母排序为第一的工程号。
select JNO from J order by CITY asc limit 1 \p;

#[34]	求被供应零件P1 的平均数量大于供应给工程J1 的任意零件的最大数量的工程号。
select JNO from SPJ where PNO='P1' group by JNO 
having avg(QTY)>(select max(QTY) from SPJ where JNO='J1') \p;
/*select JNO from SPJ where PNO='P1' group by JNO having avg(QTY)>
(select max(X.cnt) from (select sum(QTY) as cnt from SPJ where JNO='J1' group by PNO) as X) \p;
*/

#[35]	求满足下面要求的供应商号码，该供应商供应给某个工程零件P1 的数量大于这个工程被供应的零件P1 的平均数量。
select A.JNO from SPJ as A where A.PNO='P1' and A.QTY>
(select avg(B.QTY) from SPJ as B where B.PNO='P1' and B.JNO=A.JNO) \p;

#[36]	求没有被北京供应商供应过红色零件的工程号码。
select JNO from J where JNO not in
(select JNO from SPJ natural join S natural join P where S.CITY='北京' and P.COLOR='红') \p;

#[37]	求所用零件全被S1 供应的工程号码。
select JNO from SPJ where JNO not in(select JNO from SPJ where SNO<>'S1') \p;

#[38]	求所有北京工程都使用的零件号码。


#[39]	求对所有工程都提供了同一零件的供应商号码。


#[40]	求使用了S1 提供的所有零件的工程号码。
select JNO from J where not exists
(select PNO from SPJ where SNO='S1' and PNO not in(select PNO from SPJ where SPJ.JNO=J.JNO)) \p;

#[41]	求至少有一个供应商、零件或工程所在的城市。
select CITY from S union select CITY from J \p;

#[42]	求被北京供应商供应或被北京工程使用的零件号码。
select distinct PNO from SPJ, S, J 
where SPJ.SNO=S.SNO and SPJ.JNO=J.JNO and(S.CITY='北京' or J.CITY='北京') \p;

#[43]	求所有supplier-number / part-number 对，其中指定的供应商不供应指定的零件。
select distinct SNO as supplier_number, PNO as part_number
from S, P where (SNO, PNO) not in (select SNO, PNO from SPJ) \p;

#[44]	向p表追加如下记录（P0,PN0,蓝）。
insert into P values('P0', 'PNO', '蓝',null) \p;

#[45]	把零件重量在15到20之间的零件信息追加到新的表p1中。
insert into p1 from P where weight between 15 and 20 \p;

#[46]	向s表追加记录（s1, n2, ’上海’）能成功吗?为什么？
insert into S values('S1','n2','上海') \p;#不能，因为SNO是主键不能重复。

#[47]	把s、p、j三个表中的s#,p#,j#列进行交叉联接，把结果追加到spj1表中（如果只考虑下面表格中的原始数据，应该在spj1表中追加多少条记录？你是如何计算记录条数的？）。


#[48]	向spj表追加（s6,p1,j6,1000）本操作能正确执行吗？为什么？如果追加(s4,p1,j6,-10) 行吗？如果现在想强制追加这两条记录该怎么办？


#[49]	把s1供应商供应的零件为p1的所有项目对应的数量qty改为500。
update SPJ set QTY=500 where SNO='S1' and PNO='P1' \p;

#[50]	把qty值大于等于1000的所有供应商城市更改为‘北京’ 。
update S set CITY='北京' where SNO=(select SNO from SPJ where QTY>=1000) \p;

#[51]	把j1更改成j7，本操作能正确执行吗？为什么？如果改成j0呢？spj表中记录有何变化？为什么？
update J set JNO='J7' where JNO='J1';#不能，JNO是主键不可重复，J7已存在。
update J set JNO='J0' where JNO='J1';#可以，spj中的J1一起变成J0。

#[52]	把零件重量低于15的增加3，高于15的增加2。
update P set weight=case when weight>15 then weight+2
when weight<15 then weight+3 else weight end \p;

#[53]	删除为j7工程供应零件的所有供应商信息（如果建立外键时没有带级联删除选项，本操作能正确执行吗？为什么？）


#[54]	删除p1表中所有记录。
delete from p1 \p;

#[55]	删除供应商和工程在同一个城市的供应商信息。


#b)	请为三建工程项目建立一个供应情况的视图，包括供应商代码（SNO）、零件代码（PNO）、供应数量（QTY）。针对该视图完成下列查询：


#[1]	找出三建工程项目使用的各种零件代码及其数量；


#[2]	找出供应商S1的供应情况；



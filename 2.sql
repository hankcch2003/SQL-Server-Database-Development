create database 明新公司;
use 明新公司;

create table 部門
(
部門id nchar(4) primary key,
部門名稱 nchar(20)
);

create table 員工
(
員工id nchar(4) primary key,
員工姓名 nchar(20),
性別 nchar(1),
部門名稱 nchar(10),  
所屬部門id nchar(4),
foreign key (所屬部門id) references 部門(部門id)
);

create table 產品
(
產品id nchar(4) primary key,
產品名稱 nchar(20),
定價 money
);

create table 銷售
(
員工id nchar(4),
產品id nchar(4),
銷售數量 int,
primary key (員工id, 產品id),
foreign key (員工id) references 員工(員工id),
foreign key (產品id) references 產品(產品id)
);

insert into 部門
values ('d001','總經理室'),('d002','業務部'),('d003','研發部');

insert into 員工
values
('e001','apple','女','業務部','d001'),('e002','bob','男','研發部','d002'),
('e003','catty','女','製造部','d003'),('e004','david','男','業務部','d001'),
('e005','frank','男','研發部','d002'),('e006','emy','女','製造部','d003');

insert into 員工 (員工id, 員工姓名, 性別)
values
('n001','amy臨時人員','女'),('n002','bob臨時人員','男'),
('n005','frank臨時人員','男'),('n006','emy臨時人員','女');

insert into 產品
values
('p001','手機',2000),('p002','手機',3000),('p003','記憶體',1000),
('p004','鍵盤',500),('p005','滑鼠',100),('p006','螢幕',1500);

insert into 產品
values
('p007','米老鼠',2000),('p008','大老鼠',3000),('p009','天竺鼠車車',1000),
('p010','鼠來寶',500),('p011','鳳梨鼠鼠',100),('p012','小老鼠',1500);

insert into 銷售
values
('e001','p001',5),('e001','p002',2),('e001','p003',15),('e001','p004',25),('e001','p005',3),
('e002','p001',6),('e002','p002',15),('e002','p004',25),('e002','p005',25),('e002','p006',3),
('e003','p003',7),('e003','p002',4),('e004','p006',35),('e004','p002',15),('e004','p001',6),
('e005','p005',9),('e005','p003',55),('e005','p006',15),('e006','p001',5),('e006','p004',7);

-- 8-1 查詢
select * from 銷售;
select 員工id, 性別, 部門名稱 from 員工;

-- 8-2 SELECT 子句
select * from 員工 where 性別='女';
select * from 員工 where 所屬部門id='d001';
select 員工id as id, 性別 as sex, 部門名稱 as dept from 員工;

-- 8-3 比較運算子
select * from 銷售 where 銷售數量 > 10;
select * from 銷售 where not 銷售數量 > 10;

-- 8-4 邏輯運算子
select * from 員工 where 性別='女' and 部門名稱='業務部';
select * from 員工 where not (性別='女' and 部門名稱='業務部');
select * from 員工 where 性別='女' and not 部門名稱='業務部';
select * from 員工 where not 性別='女' and 部門名稱='業務部';
select * from 員工 where 性別='女' or 部門名稱='業務部';
select * from 員工 where not (性別='女' or 部門名稱='業務部');
select * from 員工 where not 性別='女' or 部門名稱='業務部';
select * from 員工 where 性別='女' or not 部門名稱='業務部';

-- 8-5 模糊查詢與範圍查詢
select * from 產品 where 產品名稱 like '%鼠%';
select * from 產品 where 產品名稱 like '鼠%';
select * from 產品 where 產品名稱 like '%鼠';
select * from 產品 where 產品名稱 like '_鼠%';

select * from 產品 where 產品id in ('p001','p005','p003');
select * from 產品 where 產品id='p001' or 產品id='p005' or 產品id='p003';

select * from 產品 where 定價 between 100 and 500;
select * from 產品 where 定價 between 100 and 500 and 產品名稱 like '%鼠%';
select * from 產品 where (定價 >= 100 and 定價 <=500) and (產品名稱 like '%鼠%');

-- 8-6 算術運算子
select 產品id, 產品名稱, 定價, 定價 * 1.2 as 售價 from 產品;
select 產品id, 產品名稱, 定價, 定價 * 1.2 as 售價 from 產品 where 定價 * 1.2 < 1000;

alter table 產品 add 成本 money;

update 產品 set 成本 = 定價 * 0.8;

insert into 產品 (產品id, 產品名稱) values
('p013','nvida顯示卡'),('p014','nvida cpu');

select *, 定價 - 成本 as 利潤 from 產品;

-- 8-7 聚合函數
select * from 產品;
select count(*) as 資料表筆數 from 產品;
select count(產品名稱) as 產品名稱筆數 from 產品;
select count(定價) as 有定價的筆數 from 產品;

select count(*) as 資料表筆數, count(產品名稱) as 產品名稱筆數, count(定價) as 有定價的筆數 from 產品;

select count(定價) as 有定價的筆數, avg(定價) as 定價平均值, sum(定價) as 定價的總合 from 產品;

select count(定價) as 有定價的筆數, avg(定價) as 定價平均值, sum(定價) as 定價的總合, max(定價) as 最高定價, min(定價) as 最低定價 from 產品;

select count(定價) as 有定價的筆數, avg(定價) as 定價平均值, sum(定價) as 定價的總合, max(定價) as 最高定價, min(定價) as 最低定價 from 產品 where 產品名稱 like '%鼠%';

-- 8-8 排序
select * from 產品 order by 定價;
select * from 產品 order by 定價 desc;
select * from 產品 order by 定價 desc, 成本 asc;

-- 8-9 群組與 HAVING
alter table 產品 add 產品類型 nchar(20);

update 產品 set 產品類型 = '電腦零件';
update 產品 set 產品類型 = '玩具' where 產品名稱 like '%鼠%';
update 產品 set 產品類型 = '高級零件' where 產品名稱 like '%nvida%';

select 產品類型 from 產品 group by 產品類型;

select 產品類型, count(定價) as 有定價的筆數, avg(定價) as 定價平均值, sum(定價) as 定價的總合, max(定價) as 最高定價, min(定價) as 最低定價 from 產品 group by 產品類型;

select 產品類型, count(定價) as 有定價的筆數, avg(定價) as 定價平均值, sum(定價) as 定價的總合, max(定價) as 最高定價, min(定價) as 最低定價
from 產品 group by 產品類型 having count(定價) > 0;

-- 8-10 DISTINCT
select * from 銷售;
select 員工id from 銷售;
select distinct 員工id from 銷售;

-- 9-1~9-7 合併查詢與巢狀查詢
select * from 部門, 員工;
select * from 部門, 員工 where 部門.部門id = 員工.所屬部門id;

select * from 部門 inner join 員工 on 部門.部門id = 員工.所屬部門id;
select * from 部門 as a inner join 員工 as b on a.部門id = b.所屬部門id;
select * from 部門 left outer join 員工 on 部門.部門id = 員工.所屬部門id;

insert 部門 values ('d004','人事部'),('d005','財務部');

select * from 部門 left outer join 員工 on 部門.部門id = 員工.所屬部門id where 員工.所屬部門id is null;
select * from 部門 right outer join 員工 on 部門.部門id = 員工.所屬部門id;
select * from 部門 full outer join 員工 on 部門.部門id = 員工.所屬部門id;

select * from 員工, 銷售;
select * from 員工, 銷售 where 員工.員工id = 銷售.員工id;
select * from 員工 inner join 銷售 on 員工.員工id = 銷售.員工id;
select * from 員工 left outer join 銷售 on 員工.員工id = 銷售.員工id;
select * from 員工 right outer join 銷售 on 員工.員工id = 銷售.員工id;
select * from 員工 full outer join 銷售 on 員工.員工id = 銷售.員工id;

select * from 員工;
select * from 銷售 where 銷售數量 > 20;
select * from 員工 where 員工id in (select 員工id from 銷售 where 銷售數量 > 20);

select 員工id, sum(銷售數量) as 總銷售數量 from 銷售 group by 員工id order by sum(銷售數量) desc;
select top 3 員工id, sum(銷售數量) as 總銷售數量 from 銷售 group by 員工id order by sum(銷售數量) desc;
select top 1 員工id from 銷售 group by 員工id order by sum(銷售數量) desc;

select * from 員工 where 員工id = (
    select top 1 員工id from 銷售 group by 員工id order by sum(銷售數量) desc
);

select * from 員工 where 員工id in (
    select top 3 員工id from 銷售 group by 員工id order by sum(銷售數量) desc
);

-- 10 view 建立
use 明新公司;
go

create view 高單價產品view as
select * from dbo.產品 where 定價 > 1000;

update 高單價產品view
set 成本 = 定價 * 0.5;

create view 部門r員工view as
select 部門id, 部門.部門名稱, 員工id, 員工姓名
from dbo.部門 inner join dbo.員工 on dbo.部門.部門id = dbo.員工.所屬部門id;
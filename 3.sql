create database 陳承翰2;
use 陳承翰2;

create table 部門
(
部門ID nchar(4) primary key,
部門名稱 nchar(20)
);

create table 員工
(
員工ID nchar(4) primary key,
員工姓名 nchar(20),
性別 nchar(1),
部門名稱 nchar(10),
所屬部門ID nchar(4),
foreign key (所屬部門ID) references 部門(部門ID)
);

create table 產品
(
產品ID nchar(4) primary key,
產品名稱 nchar(20),
定價 money
);

create table 銷售
(
員工ID nchar(4),
產品ID nchar(4),
銷售數量 int,
primary key(員工ID, 產品ID),
foreign key (員工ID) references 員工(員工ID),
foreign key (產品ID) references 產品(產品ID)
);

insert into 部門
values ('D001','總經理室'),('D002','業務部'),('D003','研發部');

insert into 員工
values
('E001','Apple','女','業務部','D001'),('E002','Bob','男','研發部','D002'),('E003','Catty','女','製造部','D003'),('E004','David','男','業務部','D001'),
('E005','Frank','男','研發部','D002'),('E006','Emy','女','製造部','D003');

insert into 產品
values
('P001','手機',2000),('P002','筆電',3000),('P003','記憶體',1000),('P004','鍵盤',500),('P005','滑鼠',100),('P006','螢幕',1500);

insert into 銷售
values
('E001','P001',5),('E001','P002',2),('E001','P003',15),('E001','P004',25),('E001','P005',3),
('E002','P001',6),('E002','P002',15),('E002','P004',25),('E002','P005',25),('E002','P006',3),
('E003','P003',7),('E003','P002',4),('E004','P006',35),('E004','P002',15),('E004','P001',6),
('E005','P005',9),('E005','P003',55),('E005','P006',15),('E006','P001',5),('E006','P004',7);

select*
from 員工

select 員工姓名,部門名稱
from 員工

select 產品名稱 as 品名,定價
from 產品

select 員工ID,銷售數量 as 數量
from 銷售
where 產品ID ='P005'

select 員工ID,產品ID,銷售數量 as 數量
from 銷售
where 銷售數量 < 30

select 員工ID,銷售數量 as 數量
from 銷售
where 銷售數量 > 5 and 產品ID ='P003'

select 員工ID,產品ID,銷售數量 as 數量
from 銷售
where 產品ID ='P002' or 產品ID ='P004'

select 員工ID,銷售數量 as 數量
from 銷售
where 產品ID ='P001' and not 銷售數量 >= 30

select 員工ID,產品ID,銷售數量
from 銷售
where 銷售數量 is null

select 員工ID,產品ID,銷售數量
from 銷售
where 銷售數量 is not null

select*
from 員工
where 部門名稱 like '研%'

select*
from 產品
where 產品名稱 like '%機%'

select*
from 產品
where 產品名稱 like '_鼠%'

select 員工ID,產品ID,銷售數量 as 數量
from 銷售
where 產品ID in ('P001','P005')

select 員工ID,產品ID,銷售數量
from 銷售
where 銷售數量 between 15 and 30

select 員工ID,產品ID,銷售數量
from 銷售
where 產品ID in ('P002','P005') and 銷售數量 between 15 and 40

select 員工ID,產品ID,銷售數量
from 銷售
where 產品ID in ('P002','P005') and 銷售數量 >= 15 and 銷售數量 <= 60

select 產品ID,產品名稱,定價,定價 * 1.2 as 售價
from 產品
where 定價 * 1.2 < 1000;

select 產品ID,產品名稱,定價,定價 * 1.2 as 售價
from 產品

alter table 產品
add 成本 money,
    產品類型 nvarchar(50),
    製造成本 money;

insert into 產品(產品ID,產品名稱)
values
('P018','NVIDA顯示卡'),('P019','NVIDA CPU');

update 產品
set 製造成本 = 1400.0000
where 產品id = 'P001';

update 產品
set 製造成本 = 2100.0000
where 產品id = 'P002';

update 產品
set 製造成本 = 700.0000
where 產品id = 'P003';

update 產品
set 製造成本 = 350.0000
where 產品id = 'P004';

update 產品
set 製造成本 = 60.0000
where 產品id = 'P005';

update 產品
set 製造成本 = 1000.0000
where 產品id = 'P006';

update 產品
set 定價 = 8000.0000,
    製造成本 = 5500.0000
where 產品id = 'P018';

update 產品
set 定價 = 9000.0000,
    製造成本 = 6500.0000
where 產品id = 'P019';

update 產品
set 產品類型 = '電腦零件'

update 產品
set 產品類型 = '玩具'
where 產品名稱 like '%鼠%'

update 產品
set 產品類型 = '高級零件'
where 產品名稱 like '%NVIDA%'

update 產品
set 成本 = 定價 * 0.8;

select *, 定價 - 成本 as 利潤
from 產品

select *, 定價 - 製造成本 as 利潤
from 產品

select count(*) as 資料表筆數
from 產品

select count(產品名稱) as 產品名稱筆數
from 產品;

select count(定價) as 有定價的筆數
from 產品

select count(*) as 資料表筆數, count(產品名稱) as 產品名稱筆數, count(定價) as 有定價的筆數
from 產品

select count(定價) as 有定價的筆數, avg(定價) as 產品平均值, sum(定價) as 定價的總和
from 產品

select count(定價) as 有定價的筆數, avg(定價) as 產品平均值,
sum(定價) as 定價的總和, max(定價) as 最高定價, min(定價) as 最低定價
from 產品

select count(定價) as 有定價的筆數, avg(定價) as 產品平均值,
sum(定價) as 定價的總和, max(定價) as 最高定價, min(定價) as 最低定價
from 產品
where 產品名稱 like '%鼠%'

select * from 產品
order by 定價;

select * from 產品
order by 定價 desc;

select * from 產品
order by 定價 desc, 製造成本 asc;

select 產品類型, count(定價) as 有定價的筆數, avg(定價) as 產品平均值,
sum(定價) as 定價的總和, max(定價) as 最高定價, min(定價) as 最低定價
from 產品
group by 產品類型

select 產品類型, count(定價) as 有定價的筆數, avg(定價) as 產品平均值,
sum(定價) as 定價的總和, max(定價) as 最高定價, min(定價) as 最低定價
from 產品
group by 產品類型
having count(定價) > 0;

select * from 銷售;
select 員工ID from 銷售;
select distinct 員工ID from 銷售;

select*
from 部門, 員工

select*
from 部門, 員工 
where 部門.部門ID = 員工.所屬部門ID

select*
from 部門 inner join 員工 
on 部門.部門ID = 員工.所屬部門ID

select*
from 部門 as a inner join 員工 as b
on a.部門ID = b.所屬部門ID

select*
from 部門 left outer join 員工 
on 部門.部門ID = 員工.所屬部門ID 

select*
from 部門 left outer join 員工 
on 部門.部門ID = 員工.所屬部門ID
where 員工.所屬部門ID is null

select*
from 部門 right outer join 員工 
on 部門.部門ID = 員工.所屬部門ID

select*
from 部門 full outer join 員工
on 部門.部門ID = 員工.所屬部門ID

select*
from 員工, 銷售

select*
from 員工, 銷售
where 員工.員工ID = 銷售.員工ID

select*
from 員工 inner join 銷售
on 員工.員工ID = 銷售.員工ID

select*
from 員工 left outer join 銷售
on 員工.員工ID = 銷售.員工ID

select*
from 員工 right outer join 銷售
on 員工.員工ID = 銷售.員工ID

select*
from 員工 full outer join 銷售
on 員工.員工ID = 銷售.員工ID

select * from 員工

select * from 銷售 where 銷售數量 > 20

select*
from 員工
where 員工ID in (select 員工ID from 銷售 where 銷售數量 > 20)

select 員工ID, sum(銷售數量) as 總銷售數量
from 銷售
group by 員工ID
order by sum(銷售數量) desc

select top 3 員工ID, sum(銷售數量) as 總銷售數量
from 銷售
group by 員工ID
order by sum(銷售數量) desc

select top 1 員工ID, sum(銷售數量) as 總銷售數量
from 銷售
group by 員工ID
order by sum(銷售數量) desc

select top 3 員工ID
from 銷售
group by 員工ID
order by sum(銷售數量)

select top 1 員工ID, sum(銷售數量) as 總銷售數量
from 銷售
group by 員工ID
order by sum(銷售數量) desc

select top 1 員工ID
from 銷售
group by 員工ID
order by sum(銷售數量) desc

select*
from 員工
where 員工ID = (select top 1 員工ID from 銷售 group by 員工ID order by sum(銷售數量) desc)

select*
from 員工
where 員工ID in (select top 3 員工ID from 銷售 group by 員工ID order by sum(銷售數量) desc)

create view 高單價產品檢視表view
as
select*
from dbo.產品
where 定價 > 1000;

update 高單價產品檢視表view
set 成本 = 定價 * 0.5

create view 部門R員工view
as
select 部門ID,部門.部門名稱,員工ID,員工姓名
from dbo.部門 inner join dbo.員工
on dbo.部門.部門ID = dbo.員工.所屬部門ID
create database 陳承翰3;
go

use 陳承翰3;
go

create table customers
(
customerid int primary key identity,
customername nvarchar(100)
);
go

create table orders
(
orderid int primary key identity,
customerid int foreign key references customers(customerid),
orderdate datetime
);
go

create table orderdetails
(
orderdetailid int primary key identity,
orderid int foreign key references orders(orderid),
productname nvarchar(100),
quantity int,
price money
);
go

-- 建立 Table Type
create type orderdetailtype as table
(
productname nvarchar(100),
quantity int,
price money
);
go

-- SQL進階1：預存程序(Stored Procedure)

-- 建立儲存過程
create procedure usp_createorder
  @customerid int,
  @orderdate datetime,
  @detailtable orderdetailtype readonly
as
begin
  set nocount on;
  set xact_abort on;
  begin try
    begin transaction;

    insert into orders (customerid, orderdate)
    values (@customerid, @orderdate);

    declare @orderid int = scope_identity();

    insert into orderdetails (orderid, productname, quantity, price)
    select @orderid, productname, quantity, price
    from @detailtable;

    commit transaction;
  end try
  begin catch
    if @@trancount > 0 rollback transaction;
    throw;
  end catch
end;
go

insert into customers (customername)
values ('王小明');
go

-- 宣告並建立明細資料，然後呼叫儲存過程
declare @details orderdetailtype;

insert into @details (productname, quantity, price)
values
('滑鼠', 2, 300),
('鍵盤', 1, 800);

exec usp_createorder
  @customerid = 1,
  @orderdate = '2025-07-26 17:10:00',
  @detailtable = @details;

-- 查看儲存結果
select name
from sys.procedures;

-- 建立稽核表格 order_audit
create table order_audit
(
auditid int identity primary key,
orderdetailid int,
productname nvarchar(100),
quantity int,
price money,
insert_date datetime default getdate()
);
go

-- SQL進階2：觸發程序(Trigger)

-- 建立觸發程序
create trigger trg_after_insert_orderdetails
on orderdetails
after insert
as
begin
  set nocount on;

  insert into order_audit (orderdetailid, productname, quantity, price)
  select i.orderdetailid, i.productname, i.quantity, i.price
  from inserted i;
end;
go

-- 測試觸發程序(已經用 usp_createorder 新增了一筆訂單，再新增一筆訂單資料，檢查觸發程序是否有作用)

-- 新增更多明細並呼叫儲存程序
declare @details2 orderdetailtype;

insert into @details2 (productname, quantity, price)
values
('耳機', 1, 1200),
('螢幕', 2, 5000);

exec usp_createorder
  @customerid = 1,
  @orderdate = '2025-07-26 17:39:00',
  @detailtable = @details2;

-- 查看稽核資料表
select * from order_audit;
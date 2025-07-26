create database ���ӿ�3;
go

use ���ӿ�3;
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

-- �إ� Table Type
create type orderdetailtype as table
(
productname nvarchar(100),
quantity int,
price money
);
go

-- SQL�i��1�G�w�s�{��(Stored Procedure)

-- �إ��x�s�L�{
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
values ('���p��');
go

-- �ŧi�ëإߩ��Ӹ�ơA�M��I�s�x�s�L�{
declare @details orderdetailtype;

insert into @details (productname, quantity, price)
values
('�ƹ�', 2, 300),
('��L', 1, 800);

exec usp_createorder
  @customerid = 1,
  @orderdate = '2025-07-26 17:10:00',
  @detailtable = @details;

-- �d���x�s���G
select name
from sys.procedures;

-- �إ߽]�֪�� order_audit
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

-- SQL�i��2�GĲ�o�{��(Trigger)

-- �إ�Ĳ�o�{��
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

-- ����Ĳ�o�{��(�w�g�� usp_createorder �s�W�F�@���q��A�A�s�W�@���q���ơA�ˬdĲ�o�{�ǬO�_���@��)

-- �s�W��h���ӨéI�s�x�s�{��
declare @details2 orderdetailtype;

insert into @details2 (productname, quantity, price)
values
('�վ�', 1, 1200),
('�ù�', 2, 5000);

exec usp_createorder
  @customerid = 1,
  @orderdate = '2025-07-26 17:39:00',
  @detailtable = @details2;

-- �d�ݽ]�ָ�ƪ�
select * from order_audit;
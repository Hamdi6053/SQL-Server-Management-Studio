create table tMusteriler
(
ID smallint identity(1,1) primary key ,
Adi varchar(250) not null,
Soyadi varchar (100) not null,
CepTel char(10) unique not null,
KayýtZamaný date,
TcKimlikNo char(11) unique not null,
Eposta varchar(150) unique
);
DELETE FROM tMusteriler;
insert into tMusteriler( Adi,Soyadi,CepTel,TcKimlikNo,Eposta)
values ('Hamd','Özkurt','2052521','5231627','JDHSDDSJ@');

Alter table tMusteriler
Add Adres varchar(150);

Alter table tMusteriler
Alter Column KayýtZamaný smalldatetime;

Alter table tMusteriler
Add Constraint Gt_KayýtZamaný default getdate() for KayýtZamaný;

insert into tMusteriler( Adi,Soyadi,CepTel,TcKimlikNo)
values ('MELÝH','HSH','54345','34236');

select * from tMusteriler;

DROP TABLE tMusteriler;


--Bir restoran veritabaný tasarlamak istiyorsunuz. Müþterileri, yemekleri, ücretlerini ve satýþlarýný kayýt altýna alan veritabaný tasarlayýn.
Create database Retsoran_Yönetim_Sistemi
Go
Use  Retsoran_Yönetim_Sistemi

create table tMusteriler 
(
ID int identity(1,1) primary key not null,
Adi varchar(150) not null,
Soyadi varchar(150) not null,
CepTel char(10) not null unique,
);

create table tYemekler
(
ID tinyint identity(1,1) primary key not null,
Yemek_Adi varchar(100) not null,
Porsiyon float not null
);

create table tYemekFiyatlari
(
ID tinyint identity(1,1) primary key not null,
KayýtTarihi date default getdate(),
YemekFiyatý float,
);


create table tSatýslar
(
ID int identity(1,1) primary key not null,
KayýtTarihi date default getdate(),
Yemekler_YemeklerID tinyint,
constraint iliski_tSatýslar_tYemekler
foreign key (Yemekler_YemeklerID) references tYemekler(ID),
Musteriler_tMusterilerID int,
constraint iliski_tSatýslar_tMusteriler
foreign key (Musteriler_tMusterilerID ) references tMusteriler(ID),
Toplam_Fiyat float
);



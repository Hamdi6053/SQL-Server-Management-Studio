CREATE DATABASE Kitapcý_Yönetim_Sistemi
GO
USE Kitapcý_Yönetim_Sistemi

Create table tMusteriler
(
ID int identity(1,1) primary key,
Adi varchar(100) not null,
Soyadi varchar(100) not null,
TelNo char(10) unique,
E_Mail varchar(250) unique
);


create table tKitaplar
(
ID int identity(1,1) primary key,
Adi varchar(250) not null,
Yayýnevi varchar(250) not null,
fiyat float
);


create table tKategoriler
(
ID int identity(1,1) primary key,
Kitaplar_tKitaplarID int,
constraint iliski_tKategoriler_tKitaplar
foreign key (Kitaplar_tKitaplarID) references tKitaplar(ID) 
);


create table tYazarlar 
(
ID int identity(1,1) primary key,
Yazar_Adi varchar(250) not null,
Yazar_Soyadi varchar(250) not null
);



CREATE TABLE tKitap_Yazar (
KitapID int,
YazarID int,
primary key (KitapID, YazarID),
foreign key (KitapID) references tKitaplar(ID),
foreign key (YazarID) references tYazarlar(ID)
);


create table tSiparisler
(
ID int identity(1,1) primary key,
Kitaplar_tKitaplarID int,
constraint iliski_tSiparisler_tKitaplar
foreign key (Kitaplar_tKitaplarID) references tKitaplar(ID),
Musteriler_tMusterilerID int 
constraint iliski_tSiparisler_tMusteriler
foreign key (Musteriler_tMusterilerID) references tMusteriler(ID),
Kayýt_Tarih smalldatetime default getdate(),
Adet int,
BirimFiyat float
);
--Bir otel veritaban� tasarlamak istiyorsunuz. Odalar� rezervasyon, fiyat ve m��terilerin bilgileri ile kay�t alt�na al�nacak veritaban� tasarlay�n.
create database Otel_Veritaban�
Go
Use Otel_Veritaban�

create table tMusteriler
(
ID int identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyadi varchar(200) not null,
TcKimlikNo char(10) unique not null,
Email varchar(100) unique not null,
CepTel char(10) unique not null
);

create table tOdalar
(
ID tinyint identity(1,1) primary key not null,
OdaNo tinyint,
Oda_Tipi varchar(100),
OdaTemizlikDurumu varchar(10),
OdaFiyat float
);

create table tRezervasyon
(
ID int identity(1,1) primary key not null,
Musteriler_tMusterilerID int,
constraint iliski_tRezervasyon_tMusteriler
foreign key (Musteriler_tMusterilerID) references tMusteriler(ID),
Odalar_tOdalarID tinyint,
constraint iliski_tOdalar_tRezervasyon
foreign key (Odalar_tOdalarID ) references tOdalar(ID),
ToplamFiyat float,
GirisZaman� date default getdate()
);


-------------------------------------------------------------------------------------------------------------------------------------
create database SutCiftligi_2
create table tTurler (
    ID bit primary key, 
	Adi varchar(50) not null)

create table tHayvanlar (
    ID tinyint primary key identity(1,1),
    Adi varchar(50) unique,
    Tur_tTurlerID bit, 
    constraint iliski_tHayvanlarVetTurler
		foreign key (Tur_tTurlerID) references tTurler(ID)
	)

create table tMusteriler ( 
    ID int primary key identity(1,1),
    AdiSoyadi varchar(100)
)


create table tSatislar (
    ID int primary key identity(1,1),
    Hayvan_tHayvanlarID tinyint,
    Musteri_tMusterilerID int,
    Miktar float, 
    Ucret float,
    Zaman smalldatetime,
    
    constraint iliski_tSatislarVetHayvanlar
        foreign key (Hayvan_tHayvanlarID) references tHayvanlar(ID),
    
    constraint iliski_tSatislarVetMusteriler
        foreign key (Musteri_tMusterilerID) references tMusteriler(ID)

------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* ��rencileri (adsoyad,ceptel,TC) b�l�mlerini(adi),
Fak�ltelerini(adi) ve al�nan dersleri (adi,kredi,akts)
tutan veritaban� olu�turun*/

CREATE DATABASE OGRENC�_VER�TABANI
GO
USE OGRENC�_VER�TABANI

CREATE TABLE tOgrenciler
(
ID int identity(1,1) primary key not null,
Adi varchar(250) not null,
Soyadi varchar(250) not null,
CepTel char(10) unique not null,
TCKimlikNo char(11) unique not null,
OgrenciNo char(4) unique not null,
Bolumler_BolumlerID smallint not null,
constraint ilisiki_tBolumler_tOgrenciler,
foreign key (Bolumler_BolumlerID) references tBolumler(ID)
);

CREATE TABLE tBolumler
(
ID smallint identity(1,1) primary key not null,
BolumAdi varchar(200) not null,
Fakultesi_tFakultelerID tinyint,
constraint iliski_tFakulteler_tBolumler
foreign key (Fakultesi_tFakultelerID) references tFakulteler(ID)
);


CREATE TABLE tFakulteler
(
ID tinyint identity(1,1) primary key not null,
Fak�lteAdi varchar(200) not null
);

CREATE TABLE tDersler
(
ID smallint identity(1,1) primary key not null,
DersADi varchar(50) not null
);

CREATE TABLE tAl�nanDersler
(
ID smallint identity(1,1) primary key not null,
Dersler_tDerslerID smallint not null,
constraint iliski_tAl�nanDersler
foreign key (Dersler_tDerslerID) references tDersler(ID),
Ogrenciler_tOgrencilerID int not null,
constraint ilisk_tAl�nanDersler_tOgrenciler
foreign key (Ogrenciler_tOgrencilerID) references tOgrenciler(ID),
DersiAld�g�Zaman date default getdate() not null,
Kredi tinyint,
AKTS tinyint
);



























































/* M��teriler i�in adi , soyadi, do�um tarihi, cep telefonu, kay�t olma tarihi,
tc kimlik no , kan grubu de�erlerini tutacak gerekli kodlar� yaz�n.*/

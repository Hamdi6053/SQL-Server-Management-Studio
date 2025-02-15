--Bir restoran veritaban� tasarlamak istiyorsunuz. M��terileri, yemekleri, �cretlerini ve sat��lar�n� kay�t alt�na alan veritaban� tasarlay�n.
Create database Retsoran_Y�netim_Sistemi
Go
Use  Retsoran_Y�netim_Sistemi

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
Kay�tTarihi date default getdate(),
YemekFiyat� float,
);


create table tSat�slar
(
ID int identity(1,1) primary key not null,
Kay�tTarihi date default getdate(),
Yemekler_YemeklerID tinyint,
constraint iliski_tSat�slar_tYemekler
foreign key (Yemekler_YemeklerID) references tYemekler(ID),
Musteriler_tMusterilerID int,
constraint iliski_tSat�slar_tMusteriler
foreign key (Musteriler_tMusterilerID ) references tMusteriler(ID),
Toplam_Fiyat float
);



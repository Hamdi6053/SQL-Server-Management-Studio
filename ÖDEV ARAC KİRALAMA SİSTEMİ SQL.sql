CREATE DATABASE Arac_Kiralama_Sistemi
GO
USE Arac_Kiralama_Sistemi

create table tMusteriler
(
ID int identity(1,1) primary key not null,
Adi varchar(150) not null,
Soyadi varchar(150) not null,
TcKimlikNo char(11) unique not null,
CepTel char(10) unique not null
);


create table tKiralanan_Araclar
(
ID smallint identity(1,1) primary key not null,
PlakaNo varchar(30) not null,
AracDurumu varchar(150),
Marka varchar(150) not null,
Model int,
ModelAdi varchar(100)
);




create table tKiralama_Ýslemi
(
ID smallint identity(1,1) primary key not null,
KiralananAraclar_tKiralanan_AraclarID smallint,
constraint iliski_tKiralanan_Araclar_tKiralama_Ýslemi
foreign key (KiralananAraclar_tKiralanan_AraclarID) references tKiralanan_Araclar(ID),
Musteriler_tMusterilerID int not null,
constraint iliski_tMusteriler_tKiralama_Ýslemi
foreign key (Musteriler_tMusterilerID ) references tMusteriler(ID),
KayýtTarihi date default getdate(),
BaslangicTarihi date not null,
BitisTarihi date not null
);


create table Fiyatlandýrma_Planý
(
ID smallint identity(1,1) primary key not null,
Kiralama_tKiralama_Ýslemi smallint not null,
constraint iliski_tKiralama_Ýslemi_Fiyatlandýrma_Planý
foreign key (Kiralama_tKiralama_Ýslemi) references tKiralama_Ýslemi(ID),
fiyat int not null
);


create table tSigorta_Policesi
(
ID smallint identity(1,1) primary key not null,
KiralananAraclar_tKiralanan_AraclarID smallint not null,
constraint iliski_tAraclar_tSigorta_Policesi
foreign key (KiralananAraclar_tKiralanan_AraclarID) references tKiralanan_Araclar(ID),
SigortaAdi varchar(150) not null
);

 

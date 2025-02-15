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




create table tKiralama_�slemi
(
ID smallint identity(1,1) primary key not null,
KiralananAraclar_tKiralanan_AraclarID smallint,
constraint iliski_tKiralanan_Araclar_tKiralama_�slemi
foreign key (KiralananAraclar_tKiralanan_AraclarID) references tKiralanan_Araclar(ID),
Musteriler_tMusterilerID int not null,
constraint iliski_tMusteriler_tKiralama_�slemi
foreign key (Musteriler_tMusterilerID ) references tMusteriler(ID),
Kay�tTarihi date default getdate(),
BaslangicTarihi date not null,
BitisTarihi date not null
);


create table Fiyatland�rma_Plan�
(
ID smallint identity(1,1) primary key not null,
Kiralama_tKiralama_�slemi smallint not null,
constraint iliski_tKiralama_�slemi_Fiyatland�rma_Plan�
foreign key (Kiralama_tKiralama_�slemi) references tKiralama_�slemi(ID),
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

 

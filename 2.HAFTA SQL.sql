/* Müþteriler için adi , soyadi, doðum tarihi, cep telefonu, kayýt olma tarihi,
tc kimlik no , kan grubu deðerlerini tutacak gerekli kodlarý yazýn.*/

create table tKangruplari
(
ID tinyint identity(1,1) primary key,
Kangrubu varchar(20) not null
);
DROP TABLE tKangruplari;

create table tMusteriler
(
ID int identity(1,1) primary key,
adi varchar(250) not null,
soyadi varchar(250) not null,
TcKimlikNo char(11) unique not null, -- null olursa unique de sadece bir adet olabilir.
KayýtTarihi smalldatetime default getdate(),
DogumTarihi date not null,
telNo char(10) not null,
--Kan-tKangruplariID tinyint references tKangruplari(ID)
Kangrubu_tKangruplariID tinyint,
constraint iliski_tMusteriler_tKangruplari 
foreign key (Kangrubu_tKangruplariID) references tKangruplari(ID),
constraint tekildegerler unique(Adi,Soyadi)
);

insert into tKangruplari(Kangrubu)
values('B rh -'),('B rh +');

select * from tKangruplari;

insert into tMusteriler (Adi,Soyadi,TcKimlikNo,DogumTarihi,telNo)
values('Emrah','Aydemir','122354565','2020-05-03','535213');

TRUNCATE TABLE tKisiler;
-- Tablodaki kayýtlarý silmek için kullanýlýr.

select * from tMusteriler;

TRUNCATE TABLE tMusteriler;

DROP TABLE tMusteriler;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* otobüs hatlarý,kiþileri ve onlarýn bindiði verileri sabit ücret ile tutan bir veritabaný
tasarlayan kodlarý yazýnýz.*/

create database OtobusBinisleri
GO 
use OtobusBinisleri

create table tKisiler
(
ID int identity(1,1) primary key,
AdiSoyadi varchar(100)
);

create table tOtobusler
(
ID smallint identity(1,1) primary key,
Plaka varchar(100)
);

create table tGuzergahlar 
(
ID int identity(1,1) primary key,
Adi varchar(100)
);

create table tHatlar
(
ID int identity(1,1) primary key,
Otobus_tOtobuslerID smallint,
constraint iliski_tHatlar_tOtobusler
foreign key (Otobus_tOtobuslerID) references tOtobusler(ID),
Guzergah_tGuzergahlarID int,
constraint iliski_tHatlar_tGuzergahlar
foreign key (Guzergah_tGuzergahlarID) references tGuzergahlar(ID)
);

create table tBinisler
(
ID int identity(1,1) primary key,
Fiyat float,
Hat_HatlarID int,
constraint iliski_tBinisler_tHatlar
foreign key (Hat_HatlarID) references tHatlar(ID),
Kisi_tKisilerID int,
constraint iliski_tBinisler_tKisiler
foreign key (Kisi_tKisilerID) references tKisiler(ID),
zaman smalldatetime default getdate()
);

DROP TABLE tHatlar;
DROP TABLE tOtobusler;
DROP TABLE tGuzergahlar;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Öðrencileri (adsoyad,ceptel,TC) bölümlerini(adi),
Fakültelerini(adi) ve alýnan dersleri (adi,kredi,akts)
tutan veritabaný oluþturun*/

-- Bir öðrenci birden fazla ders alabilir bunlarý iyi düþün baþka tablo.
-- Veritabaný tasarlarken bir çokluk iliþkilerine dikkat et.
create table tOgrenciler
(
ID smallint identity(1,1) primary key,
Adi varchar(250) not null,
Soyad varchar(250) not null,
TcKimlikNo char(11) unique not null,
CepTel char(10) unique not null,
Bolum_tBolumlerID smallint,
constraint iliski_tOgrenciler_tBolumler
foreign key (Bolum_tBolumlerID) references tBolumler(ID)
);

create table tBolumler
(
ID smallint identity(1,1) primary key,
BolumAdi varchar(250) not null,
Fakulteler_tFakultelerID smallint,
constraint iliski_tBolumler_tFakulteler
foreign key (Fakulteler_tFakultelerID) references tFakulteler(ID)
);

create table tFakulteler
(
ID smallint identity(1,1) primary key,
FakulteAdi varchar(250) not null
);

create table tDersler
(
ID smallint identity(1,1) primary key,
Adi varchar (250) not null,
Kredi tinyint not null,
Akts tinyint not null,
);

create table tOgrenciDersleri
(
ID smallint identity(1,1) primary key,
Dersler_tDerslerID smallint,
constraint iliski_tOgrenciDersleri_tDersler
foreign key (Dersler_tDerslerID) references tDersler(ID),
Ogrenci_tOgrencilerID smallint,
constraint iliski_tOgrenciDersleri_tOgrenciler
foreign key (Ogrenci_tOgrencilerID) references tOgrenciler(ID),
);


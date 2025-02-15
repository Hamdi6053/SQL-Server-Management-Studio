/*Bir restoran, m��teri sipari�lerini, men� ��elerini, �al��anlar� ve masalar� takip etmek istiyor. 
Restoran�n �e�itli �ubeleri bulunuyor ve her �ubede farkl� �al��anlar g�rev yap�yor. 
M��teriler restoran� ziyaret etti�inde, bir masa se�ip, sipari� verirler. Sipari�ler, men�deki farkl� ��elerden olu�ur ve her sipari� bir garson taraf�ndan al�n�r. 
Ayr�ca m��teriler �ube baz�nda restoran� de�erlendirebilir.*/

CREATE DATABASE RestoranDB;
USE RestoranDB;

--tSubeler tablosu
create table tSubeler
(
ID int identity(1,1) primary key,
Adi varchar(250),
Adres varchar(250)
);
insert into tSubeler(Adi,Adres)
values('Ali','Kemalpa�a MAH.')

DROP TABLE tSubeler;


--tCal�sanlar tablosu
create table tCal�sanlar
(
ID int identity(1,1) primary key,
Adi varchar(250),
Soyadi varchar(250),
Rol varchar(250),
Subeler_tSubelerID int,
constraint iliski_tCal�sanlar_tSubeler
foreign key (Subeler_tSubelerID) references tSubeler(ID) 
);


insert into tCal�sanlar(Adi,Soyadi,Rol,Subeler_tSubelerID)
values ('Veli' ,'Kahraman','Garson','1')

DROP TABLE tCal�sanlar;


-- tMusteriler tablosu
create table tMusteriler
(
ID int identity(1,1) primary key,
Adi varchar(250),
Soyadi varchar(250),
Degerlendirme tinyint,
DegerlendirmeTarihi date
);

insert into tMusteriler(Adi,Soyadi,Degerlendirme,DegerlendirmeTarihi)
values('Cenk','Tosun','2','1988-05-02 12:00:35')

DROP TABLE tMusteriler;


-- tMenuler tablosu
create table tMenuler
(
ID int identity(1,1) primary key,
YemekAdi varchar(250),
Fiyat float,
Subeler_tSubelerID int,
constraint iliski_tMenuler_tSubeler
foreign key (Subeler_tSubelerID) references tSubeler(ID) 
);
insert into tMenuler(YemekAdi,Fiyat,Subeler_tSubelerID)
values('Pilav','70','1')

DROP TABlE tMenuler;


-- tMasalar tablosu
create table tMasalar
(
ID int identity(1,1) primary key,
Numara int,
Kapasite int,
);

insert into tMasalar(Numara,Kapasite)
values('5','100')

DROP TABLE tMasalar;

-- tSiparisler tablosu
create table tSiparisler
(
ID int identity(1,1) primary key,
SiparisTarihi Datetime,
Musteriler_tMusterilerID int,
constraint iliski_tSiparisler_tMusteriler
foreign key (Musteriler_tMusterilerID) references tMusteriler(ID),
Masalar_tMasalarID int,
constraint iliski_tSiparisler_tMasalar
foreign key (Masalar_tMasalarID) references tMasalar(ID)
);

insert into tSiparisler(SiparisTarihi,Musteriler_tMusterilerID,Masalar_tMasalarID)
values('2024-12-02 13:00:20','1','1');

DROP TABLE tSiparisler;
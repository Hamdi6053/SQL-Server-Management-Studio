/* otobüs hatlarý,kiþileri ve onlarýn bindiði verileri sabit ücret ile tutan bir veritabaný
tasarlayan kodlarý yazýnýz.*/

CREATE DATABASE OTOBUS_VERÝTABANI
GO
USE OTOBUS_VERÝTABANI

create table tKisiler
(
ID int identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyadý varchar(200) not null,
TCKimlikNo char(11) not null,
);

create table tOtobusler
(
ID int identity(1,1) primary key not null,
OtobusAdi varchar(50) not null,
Plaka varchar(20) not null unique,
);


create table tHatlar
(
ID smallint identity(1,1) primary key not null,
HatAdi varchar(50) not null,
Otobusler_OtobuslerID int not null
constraint iliski_tOtobusler_tHatlar
foreign key (Otobusler_OtobuslerID) references tOtobusler(ID),
Guzergahlar_GuzergahlarID smallint not null,
constraint iliski_tHatlar_tGuzergahlar
foreign key (Guzergahlar_GuzergahlarID) references tGuzergahlar(ID)
);

create table tGüzergahlar
(
ID smallint identity(1,1) primary key not null,
Ucret float
);

create table tOtobusBinis
(
ID int identity(1,1) primary key not null,
Kisiler_KisilerID int not null,
constraint iliski_tOtobusBinis_tKisiler 
foreign key (Kisiler_KisilerID) references tKisiler(ID),
Hatlar_HatlarID smallint,
constraint iliski_tHatlar_tOtobusBinis
foreign key (Hatlar_HatlarID) references tHatlar(ID),
zaman smalldatetime default getdate()
);










 








































/* Öðrencileri (adsoyad,ceptel,TC) bölümlerini(adi),
Fakültelerini(adi) ve alýnan dersleri (adi,kredi,akts)
tutan veritabaný oluþturun*/
--Online eðitim verecek bir web sitesi yapmak istiyorsunuz. Bunun için kursu alacak kiþileri, kursu, ücreti ve kursu verecek kiþileri kayýt altýna alacaðýnýzý düþünerek bir veritabaný tasarýmý yapýnýz
--Bir otel veritabaný tasarlamak istiyorsunuz. Odalarý rezervasyon, fiyat ve müþterilerin bilgileri ile kayýt altýna alýnacak veritabaný tasarlayýn.
--Diyelim ki pasaport nu. tutmak istiyoruz. musterilere tutarýz
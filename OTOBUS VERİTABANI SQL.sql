/* otob�s hatlar�,ki�ileri ve onlar�n bindi�i verileri sabit �cret ile tutan bir veritaban�
tasarlayan kodlar� yaz�n�z.*/

CREATE DATABASE OTOBUS_VER�TABANI
GO
USE OTOBUS_VER�TABANI

create table tKisiler
(
ID int identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyad� varchar(200) not null,
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

create table tG�zergahlar
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










 








































/* ��rencileri (adsoyad,ceptel,TC) b�l�mlerini(adi),
Fak�ltelerini(adi) ve al�nan dersleri (adi,kredi,akts)
tutan veritaban� olu�turun*/
--Online e�itim verecek bir web sitesi yapmak istiyorsunuz. Bunun i�in kursu alacak ki�ileri, kursu, �creti ve kursu verecek ki�ileri kay�t alt�na alaca��n�z� d���nerek bir veritaban� tasar�m� yap�n�z
--Bir otel veritaban� tasarlamak istiyorsunuz. Odalar� rezervasyon, fiyat ve m��terilerin bilgileri ile kay�t alt�na al�nacak veritaban� tasarlay�n.
--Diyelim ki pasaport nu. tutmak istiyoruz. musterilere tutar�z
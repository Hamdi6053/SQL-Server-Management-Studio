--Online e�itim verecek bir web sitesi yapmak istiyorsunuz. 
--Bunun i�in kursu alacak ki�ileri, kursu, �creti ve kursu verecek ki�ileri kay�t alt�na alaca��n�z� d���nerek bir veritaban� tasar�m� yap�n�z
create database WEB_S�TES�_VER�TABANI
Go
Use  WEB_S�TES�_VER�TABANI

create table tKurslar
(
ID smallint identity(1,1) primary key not null,
Kurs_Adi varchar(250) not null,
Kurs_Baslang�c_Tarihi date default getdate(),
Kurs_Bitis_Tarihi date default getdate(),
Kurs�creti_tKursUcretleriID smallint,
constraint iliski_tKurslar_tKurs�cretleri
foreign key (Kurs�creti_tKursUcretleriID ) references tKursUcretleri(ID)
);


create table KursuAlanKisiler
(
ID int identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyadi varchar(200) not null,
TelNo char(10) not null unique,
Email varchar(50) not null unique,
TcKimlikNo char(11) not null unique,
Al�nanKurslar_tKurslarID  smallint not null,
constraint iliski_tKursuAlanKisiler_tKurslar
foreign key (Al�nanKurslar_tKurslarID) references tKurslar(ID)
);


create table tKursUcretleri
(
ID smallint identity(1,1) primary key,
Kurs_Adi varchar(100) not null,
Kurs�creti float
);


create table tKursuVerenKisiler
(
ID tinyint identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyadi varchar(200) not null,
Kurslar_tKurslarID smallint not null,
constraint iliski_tKurslar_tKursVerenKisiler
foreign key (Kurslar_tKurslarID) references tKurslar(ID)
);

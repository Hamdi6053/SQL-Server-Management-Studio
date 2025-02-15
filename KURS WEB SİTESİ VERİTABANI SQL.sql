--Online eðitim verecek bir web sitesi yapmak istiyorsunuz. 
--Bunun için kursu alacak kiþileri, kursu, ücreti ve kursu verecek kiþileri kayýt altýna alacaðýnýzý düþünerek bir veritabaný tasarýmý yapýnýz
create database WEB_SÝTESÝ_VERÝTABANI
Go
Use  WEB_SÝTESÝ_VERÝTABANI

create table tKurslar
(
ID smallint identity(1,1) primary key not null,
Kurs_Adi varchar(250) not null,
Kurs_Baslangýc_Tarihi date default getdate(),
Kurs_Bitis_Tarihi date default getdate(),
KursÜcreti_tKursUcretleriID smallint,
constraint iliski_tKurslar_tKursÜcretleri
foreign key (KursÜcreti_tKursUcretleriID ) references tKursUcretleri(ID)
);


create table KursuAlanKisiler
(
ID int identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyadi varchar(200) not null,
TelNo char(10) not null unique,
Email varchar(50) not null unique,
TcKimlikNo char(11) not null unique,
AlýnanKurslar_tKurslarID  smallint not null,
constraint iliski_tKursuAlanKisiler_tKurslar
foreign key (AlýnanKurslar_tKurslarID) references tKurslar(ID)
);


create table tKursUcretleri
(
ID smallint identity(1,1) primary key,
Kurs_Adi varchar(100) not null,
KursÜcreti float
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

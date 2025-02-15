CREATE DATABASE Universite_Y�netim_Sistemi
GO
USE Universite_Y�netim_Sistemi


create table tOgrenciler
(
ID int identity(1,1) primary key not null,
Adi varchar(150) not null,
Soyadi varchar(150) not null,
TCKimlikNo char(11) unique not null,
CepTel char(10) unique not null,
Ogrenci_No int not null,
Dan�sman_Ad� varchar(150) not null,
Dan�sman_Soyad� varchar(150) not null,
);



create table tDersler
(
ID int identity(1,1) primary key not null,
Ders_Adi varchar(150) not null,
S�n�flar tinyint not null,
Ogretim_G�revlisi_Adi varchar(150) not null,
Ogretim_G�revlisi_Soyadi varchar(150) not null
);

create table tAl�nan_Dersler
(
ID smallint identity(1,1) primary key not null,
Dersler_tDerslerID int,
constraint iliski_tDersler_tAl�nan_Dersler
foreign key (Dersler_tDerslerID) references tDersler(ID),
Ogrenciler_tOgrencilerID int not null,
constraint iliski_tOgrenciler_tAc�lan_Dersler
foreign key (Ogrenciler_tOgrencilerID) references tOgrenciler(ID)
);

create table tNotlar
(
ID smallint identity(1,1) primary key not null,
Notlar int not null,
Ogrenciler_tOgrencilerID int not null,
constraint iliski_tOgrenciler_tNotlar
foreign key (Ogrenciler_tOgrencilerID) references tOgrenciler(ID) ,
Al�nanDersler_Al�nan_DerslerID smallint not null,
constraint iliski_tAl�nan_Dersler_tNotlar
foreign key (Al�nanDersler_Al�nan_DerslerID) references tAl�nan_Dersler(ID)
);

create table tOgrenci_Basar�_Durumu
(
ID smallint identity(1,1) primary key,
Ogrenciler_tOgrencilerID int not null,
constraint iliski_tOgrenciler_tOgrenci_Basar�_Durumu
foreign key (Ogrenciler_tOgrencilerID) references tOgrenciler(ID),
Al�nanDersler_tAl�nan_DerslerID smallint not null,
constraint iliski_tAl�nan_Dersler_tOgrenci_Basar�_Durumu
foreign key (Al�nanDersler_tAl�nan_DerslerID) references tAl�nan_Dersler(ID),
Basar�_Durumu varchar(50)
);









CREATE DATABASE Universite_Yönetim_Sistemi
GO
USE Universite_Yönetim_Sistemi


create table tOgrenciler
(
ID int identity(1,1) primary key not null,
Adi varchar(150) not null,
Soyadi varchar(150) not null,
TCKimlikNo char(11) unique not null,
CepTel char(10) unique not null,
Ogrenci_No int not null,
Danýsman_Adý varchar(150) not null,
Danýsman_Soyadý varchar(150) not null,
);



create table tDersler
(
ID int identity(1,1) primary key not null,
Ders_Adi varchar(150) not null,
Sýnýflar tinyint not null,
Ogretim_Görevlisi_Adi varchar(150) not null,
Ogretim_Görevlisi_Soyadi varchar(150) not null
);

create table tAlýnan_Dersler
(
ID smallint identity(1,1) primary key not null,
Dersler_tDerslerID int,
constraint iliski_tDersler_tAlýnan_Dersler
foreign key (Dersler_tDerslerID) references tDersler(ID),
Ogrenciler_tOgrencilerID int not null,
constraint iliski_tOgrenciler_tAcýlan_Dersler
foreign key (Ogrenciler_tOgrencilerID) references tOgrenciler(ID)
);

create table tNotlar
(
ID smallint identity(1,1) primary key not null,
Notlar int not null,
Ogrenciler_tOgrencilerID int not null,
constraint iliski_tOgrenciler_tNotlar
foreign key (Ogrenciler_tOgrencilerID) references tOgrenciler(ID) ,
AlýnanDersler_Alýnan_DerslerID smallint not null,
constraint iliski_tAlýnan_Dersler_tNotlar
foreign key (AlýnanDersler_Alýnan_DerslerID) references tAlýnan_Dersler(ID)
);

create table tOgrenci_Basarý_Durumu
(
ID smallint identity(1,1) primary key,
Ogrenciler_tOgrencilerID int not null,
constraint iliski_tOgrenciler_tOgrenci_Basarý_Durumu
foreign key (Ogrenciler_tOgrencilerID) references tOgrenciler(ID),
AlýnanDersler_tAlýnan_DerslerID smallint not null,
constraint iliski_tAlýnan_Dersler_tOgrenci_Basarý_Durumu
foreign key (AlýnanDersler_tAlýnan_DerslerID) references tAlýnan_Dersler(ID),
Basarý_Durumu varchar(50)
);









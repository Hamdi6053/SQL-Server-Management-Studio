--3. Hastane Y�netim Sistemi 
--Bir hastane, hasta bilgilerini, doktorlar�, hem�ireleri, tedavi s�re�lerini ve re�eteleri takip ediyor.
--Hastalar, �e�itli doktorlara muayene oluyor ve her hastaya belirli tedaviler uygulan�yor.
--Doktorlar, hastalara re�ete yaz�yor ve hem�ireler tedavi s�re�lerinde yer al�yor. 
--Her tedavi, belirli ila�larla destekleniyor ve ila�lar eczane taraf�ndan sa�lan�yor. 

CREATE DATABASE Hastane_Y�netim_Sistemleri
GO
USE Hastane_Y�netim_Sistemleri

Create table tHasta_Bilgileri
(
ID int identity(1,1) primary key not null,
Adi varchar(250) not null,
Soyad� varchar(250) not null,	
TcKimlikNo char(11) unique not null,
Dogum_Tarihi date default getdate(),
cinsiyet varchar(10) not null,
Kay�t_Tarihi date default getdate()
);

create table tDoktorlar
(
ID smallint identity(1,1) primary key not null,
Doktor_Ad varchar(250) not null,
Doktor_Soyad varchar(250) not null
);

create table tHemsireler
(
ID smallint identity(1,1) primary key not null,
Hemsire_Ad varchar(250) not null,
Hemsire_Soyad varchar(250) not null
);

create table tMuayene
(
ID int identity(1,1) primary key not null,
HastaBilgileri_Hasta_BilgileriID int,
constraint iliski_tHasta_Bilgileri_tMuayene
foreign key (HastaBilgileri_Hasta_BilgileriID) references tHasta_Bilgileri(ID),
Doktorlar_tDoktorlarID smallint,
constraint ilsiki_tDoktorlar_tMuayene
foreign key (Doktorlar_tDoktorlarID) references tDoktorlar(ID),
Kay�tTarihi date default getdate()
);

create table tTedaviS�recleri
(
ID int identity(1,1) primary key,
Hemsireler_tHemsirelerID smallint,
constraint iliski_tHemsireler_tTedaviS�recleri
foreign key (Hemsireler_tHemsirelerID) references tHemsireler(ID),
Receteler_tRecetelerID int,
constraint iliski_tTedaviS�recleri_tReceteler
foreign key (Receteler_tRecetelerID) references tReceteler(ID),
Doktorlar_tDoktorlarID smallint,
constraint iliski_tTedaviS�recler�_tDoktorlar
foreign key (Doktorlar_tDoktorlarID) references tDoktorlar(ID),
Kay�tTarihi date default getdate()
)

create table tReceteler
(
ID int identity(1,1) primary key not null,
HastaBilgileri_tHasta_Bilgileri int,
constraint iliski_tRecete_tHasta_Bilgileri
foreign key (HastaBilgileri_tHasta_Bilgileri) references tHasta_Bilgileri(ID),
ilaclar varchar(150),
Kay�tTarihi date default getdate(),
tedavi varchar(150)
);

create table tEczaneler
(
ID int identity(1,1) primary key,
Adres varchar(150),
Ad varchar(150),
Receteler_tRecetelerID int,
constraint iliski_tEczaneler_tReceteler
foreign key (Receteler_tRecetelerID) references tReceteler(ID)
);



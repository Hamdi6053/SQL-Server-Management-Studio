--SORU
--Bir ayakkabýcý zincirinin farklý iþ yerlerinde bot, sandalet, kundura, spor gibi birçok farklý türde ayakkabý satýlmaktadýr. 
--Bu ayakkabýlar Çeþitli renklerde ve numaralarda olabilmektedir. Bu ayakkabýlarý
--müþterilere satýþ bilgileri ile birlikte tutmak için gerekli veritabanýný create kodlarý ile oluþturun. 
--Veri tabanýndaki tablolarda gerekli tüm kýsýtlamalar ve iliþkiler olmalýdýr

create database EsatKundura
go
use EsatKundura

create table tRenkler
(ID primary key identity(1,1) tinyint, 
Adi varchar(100) unique
)

create table tTurler(
renk_tRenklerID tinyint not null foreign key references tRenkler(ID)
ID primary key identity(1,1) tinyint,
Adi varchar(50) unique, Numara tinyint not null
)

create table tSubeler(
ID primary key identity(1,1) tinyint,
Adi varchar(150) unique, 
Adres varchar(500) unique
)

create table tMusteriler(
ID primary key identity(1,1),
AdiSoyadi varchar(150) not null, DogumTarihi date 
)
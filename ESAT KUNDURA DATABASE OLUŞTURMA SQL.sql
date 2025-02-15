--SORU
--Bir ayakkab�c� zincirinin farkl� i� yerlerinde bot, sandalet, kundura, spor gibi bir�ok farkl� t�rde ayakkab� sat�lmaktad�r. 
--Bu ayakkab�lar �e�itli renklerde ve numaralarda olabilmektedir. Bu ayakkab�lar�
--m��terilere sat�� bilgileri ile birlikte tutmak i�in gerekli veritaban�n� create kodlar� ile olu�turun. 
--Veri taban�ndaki tablolarda gerekli t�m k�s�tlamalar ve ili�kiler olmal�d�r

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
CREATE DATABASE Butik_Giyim_Magazas�
USE Butik_Giyim_Magazas�


Create table tKategoriler
(
ID tinyint identity(1,1) primary key,
KategoriAdi varchar(150) not null
);

insert into tKategoriler(KategoriAdi)
values('Kad�n Giyim')
insert into tKategoriler(KategoriAdi)
values('Erkek Giyim')
insert into tKategoriler(KategoriAdi)
values('�ocuk Giyim')
insert into tKategoriler(KategoriAdi)
values('Ayakkab�lar')
insert into tKategoriler(KategoriAdi)
values('Aksesuarlar')
select * from tKategoriler


Create table tUrunler
(
ID smallint identity(1,1) primary key,
UrunAdi varchar(100) not null,
Kategori_tKategorilerID tinyint not null,
constraint iliski_tKategoriler_tUrunler
	foreign key (Kategori_tKategorilerID) references tKategoriler(ID),
AlisFiyati float not null,
SatisFiyati float not null,
StokMiktari int default 0
);
insert into tUrunler(UrunAdi,Kategori_tKategorilerID,AlisFiyati,SatisFiyati,StokMiktari)
values('T-Sh�rt',1,50,75,100)
insert into tUrunler(UrunAdi,Kategori_tKategorilerID,AlisFiyati,SatisFiyati,StokMiktari)
values('Pantolon',2,500,750,50)
insert into tUrunler(UrunAdi,Kategori_tKategorilerID,AlisFiyati,SatisFiyati,StokMiktari)
values('Sapka',4,30,45,10)
insert into tUrunler(UrunAdi,Kategori_tKategorilerID,AlisFiyati,SatisFiyati,StokMiktari)
values('Bot',1,1500,2500,2)
insert into tUrunler(UrunAdi,Kategori_tKategorilerID,AlisFiyati,SatisFiyati,StokMiktari)
values('Etek',1,450,750,15)

select * from tUrunler


Create table tMusteriler
(
ID smallint identity(1,1) primary key ,
MusteriAdi varchar (150) not null,
MusteriSoyadi varchar(150) not null,
CepTel char(10) unique not null,
Adres varchar(100) not null
);
insert into tMusteriler(MusteriAdi,MusteriSoyadi,CepTel,Adres)
values('Ahmet Hamdi','�zkurt',5378652342,'�stanbul,Kad�k�y')
insert into tMusteriler(MusteriAdi,MusteriSoyadi,CepTel,Adres)
values('Tugba','Bilgit',4325678432,'Bursa,Osmangazi')
insert into tMusteriler(MusteriAdi,MusteriSoyadi,CepTel,Adres)
values('Melih','�zkurt',5422567865,'Ordu,G�lyal�')
insert into tMusteriler(MusteriAdi,MusteriSoyadi,CepTel,Adres)
values('Hakan','�zkurt',5057325432,'Ordu,G�lyal�')
insert into tMusteriler(MusteriAdi,MusteriSoyadi,CepTel,Adres)
values('Saim','Demirel',5357802612,'Giresun,Ayvas�l')
delete from tMusteriler

select * from tMusteriler
delete from tMusteriler
Create table tCalisanlar
(
ID smallint identity(1,1) primary key,
CalisanAdi varchar(150) not null,
CalisanSoyadi varchar(150) not null,
Maas float not null,
CepTel char(10) unique,
TcKimliKNo char(11) unique,
Eposta varchar(50) not null
);
INSERT INTO tCalisanlar (CalisanAdi, CalisanSoyadi, Maas, CepTel, TcKimliKNo, Eposta) 
VALUES 
('Murat', 'Y�lmaz', 3000.00, '5556789012', '12345678901', 'murat@butik.com'),
('Aylin', '�elik', 3500.00, '5557890123', '12345678902', 'aylin@butik.com'),
('Serkan', 'Polat', 4000.00, '5558901234', '12345678903', 'serkan@butik.com'),
('Derya', 'G�zel', 3200.00, '5559012345', '12345678904', 'derya@butik.com'),
('Kemal', 'Demir', 2800.00, '5550123456', '12345678905', 'kemal@butik.com');

select * from tCalisanlar


Create table tSatislar
(
ID int identity(1,1) primary key,
Musteriler_tMusterilerID smallint not null,
constraint iliski_tSatislar_tMusteriler
	foreign key (Musteriler_tMusterilerID) references tMusteriler(ID),
Calisanlar_tCalisanlarID  smallint not null,
	foreign key (Calisanlar_tCalisanlarID ) references tCalisanlar(ID),
SatisTarihi date default getdate()
);
insert into tSatislar(Musteriler_tMusterilerID,Calisanlar_tCalisanlarID,SatisTarihi)
values
(31,1,'2022.02.02'),
(32,2,'2024.12.26'),
(33,3,'2023.08.12'),
(34,4,'2024.12.26'),
(35,5,'2024.12.26');

select * from tSatislar

Create table tSatisDetaylari
(
ID int identity(1,1) primary key,
Urunler_tUrunlerID smallint not null,
constraint iliski_tSatisDetaylari_tUrunler
	foreign key (Urunler_tUrunlerID) references tUrunler(ID),
Satislar_tSatislarID int not null,
constraint iliski_tSatisDetaylari_tSatislar
	foreign key (Satislar_tSatislarID) references tSatislar(ID),
Miktar int not null,
indirim int default 0
);
insert into tSatisDetaylari(Urunler_tUrunlerID,Satislar_tSatislarID,Miktar,indirim)
values
(1,33,30,10),
(2,34,10,0),
(3,35,5,10),
(4,36,6,20),
(5,37,8,20);
delete from tSatisDetaylari
SELECT * FROM tSatisDetaylari

Create table tTedarikciler
(
ID smallint identity(1,1) primary key,
TedarikciAdi varchar(150) not null,
Tedarik_Telefon varchar(20) not null
)

INSERT INTO tTedarikciler (TedarikciAdi, Tedarik_Telefon) 
VALUES 
('Tedarik�i A', '5551112233'),
('Tedarik�i B', '5551122334'),
('Tedarik�i C', '5551132335'),
('Tedarik�i D', '5551142336'),
('Tedarik�i E', '5551152337');
SELECT * FROM tTedarikciler



Create table tStokHaraketleri
(
ID int identity(1,1) primary key,
Urunler_tUrunlerID smallint not null,
constraint iliski_tStokHaraketleri_tUrunler
	foreign key (Urunler_tUrunlerID ) references tUrunler(ID),
HareketMiktar� int not null,
HareketTarihi date default getdate()
);
select * from tUrunler
insert into tStokHaraketleri(Urunler_tUrunlerID,HareketMiktar�)
values
(1,100),
(2,200),
(3,3100),
(4,400),
(5,500);
SELECT * FROM tStokHaraketleri

Create table tGiderler 
(
ID smallint identity(1,1) primary key,
GiderAdi varchar(150) not null,
Tutar float not null,
GiderTarihi date default getdate()
);
INSERT INTO tGiderler (GiderAdi, Tutar, GiderTarihi) 
VALUES 
('Kira', 2000, '2024-12-01'),
('Elektrik', 300, '2024-12-02'),
('Su', 100, '2024-12-03'),
('Internet', 150, '2024-12-04'),
('Reklam', 500, '2024-12-05');

select * from tGiderler




Create table tKullanicilar
(
ID tinyint identity(1,1) primary key,
KullaniciAdi varchar(100) not null,
Sifre varchar(20) not null unique,
Rol varchar(100) not null
);

INSERT INTO tKullanicilar (KullaniciAdi, Sifre, Rol) 
VALUES 
('admin', 'admin123', 'Y�netici'),
('musteri1', 'musteri123', 'M��teri'),
('musteri2', 'musteri124', 'M��teri'),
('calisan1', 'calisan123', '�al��an'),
('calisan2', 'calisan124', '�al��an');

SELECT * FROM tKullanicilar

/*9. Olu�turmu� oldu�unuz veritaban�nda esnaf�n g�nl�k karlar�n� nas�l listeleyece�ini g�steren
sorguyu yaz�n�z.
10. Olu�turmu� oldu�unuz veritaban�nda esnaf�n ortalama ayl�k karlar�n� belirleyin. Bu de�erin
alt�ndaki aylara ait sat��lar� nas�l listeleyece�ini g�steren sorguyu yaz�n�z.
11. Olu�turmu� oldu�unuz veritaban�nda esnaf�n zarar etti�i �r�nleri nas�l listeleyece�ini g�steren
sorguyu yaz�n�z.
12. Olu�turmu� oldu�unuz veritaban�nda esnaf�n en �ok hangi �r�n� satt���n� listeleyece�ini
g�steren sorguyu yaz�n�z*/

select * from tSatisDetaylari
select * from tUrunler
SELECT * FROM tSatislar


select U.UrunAdi,((U.SatisFiyati*(1-S.indirim/100)-U.AlisFiyati)*S.Miktar) as 'G�nl�k Kar' from tSatisDetaylari as S
left join tUrunler as U
on s.Urunler_tUrunlerID = U.ID
left join tSatislar AS Sl
on S.Satislar_tSatislarID = Sl.ID
where DATEDIFF(Day,Sl.SatisTarihi,getdate()) = 1
group by U.UrunAdi,U.SatisFiyati,U.AlisFiyati,S.Miktar,S.indirim


/*11. Olu�turmu� oldu�unuz veritaban�nda esnaf�n zarar etti�i �r�nleri nas�l listeleyece�ini g�steren
sorguyu yaz�n�z.*/

select * from tSatisDetaylari
select * from tUrunler

select U.UrunAdi from tSatisDetaylari AS S
left join tUrunler as U
on S.Urunler_tUrunlerID = U.ID
where (U.SatisFiyati*(1-S.indirim/100)) * S.Miktar < U.AlisFiyati*S.Miktar
group by U.UrunAdi


/*12. Olu�turmu� oldu�unuz veritaban�nda esnaf�n en �ok hangi �r�n� satt���n� listeleyece�ini
g�steren sorguyu yaz�n�z*/

select * from tSatisDetaylari
insert into tSatisDetaylari(Urunler_tUrunlerID,Satislar_tSatislarID,Miktar)
VALUES (1,33,100)
select * from tUrunler
 select * from tSatislar

select TOP 1  U.UrunAdi,Sum(S.Miktar) as 'Sat�lan �r�n Adeti' from tSatisDetaylari as S
left join tUrunler AS U
on U.ID = s.Urunler_tUrunlerID
group by U.UrunAdi
ORDER BY Sum(S.Miktar) DESC

/*10. Olu�turmu� oldu�unuz veritaban�nda esnaf�n ortalama ayl�k karlar�n� belirleyin. Bu de�erin
alt�ndaki aylara ait sat��lar� nas�l listeleyece�ini g�steren sorguyu yaz�n�z.*/
select * from tSatislar
select U.UrunAdi,
Month(S.SatisTarihi) as 'Ay', 
SUM((U.SatisFiyati*(1-SD.indirim/100)-U.AlisFiyati)*SD.Miktar) as 'Toplam Kar'
from tSatisDetaylari AS Sd
left join tSatislar AS S
on S.ID = Sd.Satislar_tSatislarID
left join tUrunler AS U
on U.ID= Sd.Urunler_tUrunlerID
group by U.UrunAdi,Month(S.SatisTarihi)
having SUM((U.SatisFiyati*(1-SD.indirim/100)-U.AlisFiyati)*SD.Miktar)<
      (Select AVG((U.SatisFiyati*(1-SD.indirim/100)-U.AlisFiyati)*SD.Miktar) from tSatisDetaylari AS SD
	  left join tUrunler AS U
	  ON sD.Urunler_tUrunlerID=U.ID
	  )


-- 5 V�EW

--1."Stok durumunu analiz edin. Her �r�n�n stoktaki miktar�n�, kategorisini, al��-sat�� fiyatlar�n� ve toplam stok maliyetini g�sterin."

select * from tSatisDetaylari
select * from tUrunler
select * from tKategoriler

create view v_Stok_Durum_Analiz
as
select U.UrunAdi as 'Urun Adi',
K.KategoriAdi as 'Kategori Adi',
U.AlisFiyati as 'Alis Fiyati',
U.SatisFiyati as 'Satis Fiyati',
(U.AlisFiyati*U.StokMiktari) AS 'Toplam Stok Maliyeti'from tUrunler as U
left join tKategoriler as K
on K.ID = U.Kategori_tKategorilerID


--2."M��teri bazl� analiz yap�n. Her m��terinin al��veri� say�s�n�, ald��� toplam �r�n miktar�n� ve toplam harcamas�n� listeleyin."
select * from tMusteriler
select * from tSatislar
select * from tSatisDetaylari
select * from tUrunler
create view v_Musteri_Bazl�_Analiz
as 
select S.Musteriler_tMusterilerID AS 'Musteri ID',
COUNT(DISTINCT S.ID) AS 'M��teri Al��veri� Sayisi' , 
SUM(SD.Miktar) AS 'Al�nan Toplam Urun Miktari',
SUM((U.SatisFiyati*(1-SD.indirim/100))*Sd.Miktar) as 'M�sterinin Toplam Harcamas�'  from tMusteriler as M
left join tSatislar as S
ON m.ID = S.Musteriler_tMusterilerID 
left join tSatisDetaylari AS sd
on sd.Satislar_tSatislarID = S.ID
left join tUrunler AS U
on U.ID = Sd.Urunler_tUrunlerID
Group by S.Musteriler_tMusterilerID


--3."�al��anlar�n performans analizini yap�n. Her �al��an�n toplam sat�� say�s�n� ve sat�� tutar�n� g�sterin."

select * from tCalisanlar
select * from tSatislar
select * from tSatisDetaylari
select * from tUrunler

create view v_Calisan_Performans_Analizi
as
select C.CalisanAdi,C.CalisanSoyadi,
SUM(SD.Miktar) as 'Toplam Satis Miktari',
SUM((U.SatisFiyati*(1-SD.indirim/100)) * SD.Miktar) AS 'Toplam Satis Tutar�' from tCalisanlar AS C
left join tSatislar as S
on S.Calisanlar_tCalisanlarID = C.ID
left join tSatisDetaylari AS Sd
on Sd.Satislar_tSatislarID = S.ID
LEFT join tUrunler AS U
on U.ID = Sd.Urunler_tUrunlerID
group by C.CalisanAdi,C.CalisanSoyadi

select * from v_Calisan_Performans_Analizi


--4."Kategori bazl� analizde her kategorinin toplam sat�� adedi, sat�lan toplam �r�n miktar� ve toplam ciroyu listeleyin."

select * from tKategoriler
select * from tUrunler
select * from tSatisDetaylari
create view v_Kategori_Bazli_Analiz
as
select K.KategoriAdi,COUNT(*) AS 'Toplam Satis Adedi',
SUM(SD.Miktar) as 'Toplam Satilan Urun M�ktar�',
SUM((U.SatisFiyati*(1-SD.indirim/100))*SD.Miktar) AS 'Toplam Ciro' from tKategoriler AS K
left join tUrunler as U
on K.ID = U.Kategori_tKategorilerID
left join tSatisDetaylari AS Sd
on Sd.Urunler_tUrunlerID = U.ID
group by K.KategoriAdi


--5."G�nl�k sat�� raporu olu�turun. 
--Her g�n i�in sat�� adedi, m��teri say�s�, 
--sat�lan �r�n miktar�, ciro ve kar bilgilerini g�sterin."

select * from tSatisDetaylari
select * from tSatislar
select * from tUrunler
select * from tMusteriler
CREATE view v_Gunluk_Rapor
as
select COUNT(S.ID) as 'Toplam Satis Adedi',
count(DISTINCT Musteriler_tMusterilerID) as 'Toplam Musteri Sayisi' ,
SUM(SD.Miktar) AS 'Toplam Satis Miktari',
SUM((U.SatisFiyati*(1-SD.indirim/100)-U.AlisFiyati)*SD.Miktar) as 'Toplam Kar',
SUM((U.SatisFiyati*(1-SD.indirim/100))*SD.Miktar) as 'Toplam Ciro',
CONVERT(DATE,S.SatisTarihi) as 'Satis Tarihi'
FROM tSatisDetaylari AS Sd
left join tSatislar as S
on Sd.Satislar_tSatislarID = S.ID
left join tUrunler AS U
on u.ID = sd.Urunler_tUrunlerID
LEFT join tMusteriler AS M
on M.ID = s.Musteriler_tMusterilerID
group by CONVERT(date, S.SatisTarihi)
Having  CONVERT(date, S.SatisTarihi) = CONVERT(date, GETDATE());

--INDEKS OLU�TURMA

CREATE INDEX idx_Satislar_SatisTarihi ON tSatislar (SatisTarihi);
CREATE INDEX idx_Urunler_KategoriID ON tUrunler (Kategori_tKategorilerID);
CREATE INDEX idx_Satislar_MusterilerID ON tSatislar (Musteriler_tMusterilerID);
CREATE INDEX idx_SatisDetaylari_SatislarID_UrunlerID ON tSatisDetaylari (Satislar_tSatislarID, Urunler_tUrunlerID);
CREATE INDEX idx_Satislar_CalisanlarID ON tSatislar (Calisanlar_tCalisanlarID);


/*Bir veritaban�nda Urunler adl� bir tablo bulunmaktad�r. Bu tablo, �r�nlerin adlar�n� (UrunAdi), sat�� fiyatlar�n� (SatisFiyati), 
stok miktarlar�n� (StokMiktari) ve �r�nlerin ait olduklar� kategorilerin kimliklerini (KategoriID) i�erir.*/
select * from tUrunler
Create procedure proc_KategoriID(@KategoriID tinyint)
AS 
Begin 
    Select U.UrunAdi,U.SatisFiyati,U.StokMiktari
	from tUrunler as U
	where U.Kategori_tKategorilerID = @KategoriID
End

execute  proc_KategoriID @KategoriID = 2

--A�a��daki gereksinimlere g�re bir stored procedure yaz�n�z:

/*Gereksinimler:

Parametreler:

Ba�lang�� tarihi (@BaslangicTarihi, DATE).
Biti� tarihi (@BitisTarihi, DATE).
��kt�:

Sat�� tarihi (SatisTarihi).
M��terinin ad� (MusteriAdi) ve soyad� (MusteriSoyadi).
Sat�lan �r�n ad� (UrunAdi).
Sat�lan �r�n miktar� (Miktar).*/

CREATE PROCEDURE proc_Urun_Musteri (@BaslangicTarihi date , @BitisTarihi date)
As
Begin 
     Select  S.SatisTarihi,(M.MusteriAdi + ' ' + M.MusteriSoyadi) AS 'M�steri Adi ve Soyadi',U.UrunAdi,SD.Miktar FROM tSatislar AS S
	 left join tMusteriler as M
	 on M.ID = S.Musteriler_tMusterilerID
	 LEFT join tSatisDetaylari AS Sd
	 on Sd.Satislar_tSatislarID = S.ID
	 LEFT join tUrunler AS U
	 ON U.ID = sd.Urunler_tUrunlerID
	 WHERE S.SatisTarihi BETWEEN @BaslangicTarihi AND @BitisTarihi
End

execute proc_Urun_Musteri @BaslangicTarihi = '2022-04-05', @BitisTarihi = '2024-12-28'


select * frOM tMusteriler
Create procedure proc_Musteri_Ekleme(@MusteriAdi varchar(150),@MusteriSoyadi varchar(150),@CepTel char(10),@Adres varchar(100))
AS
Begin 
    insert into tMusteriler(MusteriAdi,MusteriSoyadi,CepTel,Adres)
	values(@MusteriAdi,@MusteriSoyadi,@CepTel,@Adres)
End

exec proc_Musteri_Ekleme @MusteriAdi = 'Hasan', @MusteriSoyadi = '�zkurt', @CepTel = 65445632 , @Adres = 'Ordu,Carsamba'

/*Cla�san ID parametre toplam satt��� �r�n say�s� adi ve soyadi*/
select * from tSatisDetaylari
create procedure proc_Calisan (@CalisanID smallint)
AS
Begin 
     select C.CalisanAdi,C.CalisanSoyadi,SUM(SD.Miktar) AS 'Satt�g� toplam ��rn Sayisi' from tCalisanlar AS C
	 left join tSatislar as S
	 on S.Calisanlar_tCalisanlarID = C.ID
	 left join tSatisDetaylari AS Sd
	 on Sd.Satislar_tSatislarID = S.ID
	 where C.ID = @CalisanID
	 GROUP BY C.CalisanAdi,C.CalisanSoyadi
End	
SELECT * FROM tCalisanlar
exec proc_Calisan @CalisanID = 2

--Tabii, sizin i�in stok miktar� belirli bir seviyenin alt�na d��en �r�nleri listeleyen bir prosed�r yazabilirim. 
--Bu, stok takibi ve yeniden sipari� verme s�re�leri i�in faydal� olabilir
create procedure proc_Kritik_Stok_Seviyesi(@Kritikstokseviyesi int)
AS
Begin
    Select U.UrunAdi, U.StokMiktari  from tUrunler as U
	where U.StokMiktari< @Kritikstokseviyesi
End
execute proc_Kritik_Stok_Seviyesi @Kritikstokseviyesi = 40
DROP PROCEDURE proc_Kritik_Stok_Seviyesi
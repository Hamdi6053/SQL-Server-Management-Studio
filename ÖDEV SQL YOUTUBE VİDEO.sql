CREATE DATABASE Butik_Giyim_Magazasý;
USE Butik_Giyim_Magazasý;

CREATE TABLE tDepartmanlar
(
    ID int identity(1,1) primary key,
    DepartmanAdi varchar(150) not null
);
insert into tDepartmanlar(DepartmanAdi)
values ('Kadýn Giyim')

insert into tDepartmanlar(DepartmanAdi)
values ('Erkek Giyim')

insert into tDepartmanlar(DepartmanAdi)
values ('Çocuk Giyim')

insert into tDepartmanlar(DepartmanAdi)
values ('Aksesuarlar')


insert into tDepartmanlar(DepartmanAdi)
values ('Ayakkabýlar')

select * from tDepartmanlar

CREATE TABLE tKategoriler
(
    ID int identity(1,1) primary key,
    --DepartmanID ekle
	KategoriAdi varchar(150) not null
);

insert into tKategoriler(KategoriAdi)
values ('Tisört')

insert into tKategoriler(KategoriAdi)
values ('Pantolon')

insert into tKategoriler(KategoriAdi)
values ('Elbise')

insert into tKategoriler(KategoriAdi)
values ('Ceket')

insert into tKategoriler(KategoriAdi)
values ('Ayakkabý')
select * from tKategoriler

/*ALTER TABLE tKategoriler ADD DepartmanID INT;
ALTER TABLE tKategoriler ADD CONSTRAINT FK_Departman_Kategori FOREIGN KEY (DepartmanID) REFERENCES tDepartmanlar(ID);*/

CREATE TABLE tKullanicilar
(
    ID int identity(1,1) primary key,
    KullaniciAdi varchar(150) unique not null,
    Sifre varchar(50) unique not null
);

insert into tKullanicilar(KullaniciAdi,Sifre)
values('Ha_di','123Ha')

insert into tKullanicilar(KullaniciAdi,Sifre)
values('Ah_et','123Ah')

insert into tKullanicilar(KullaniciAdi,Sifre)
values('V_li','123Ve')

insert into tKullanicilar(KullaniciAdi,Sifre)
values('Ma_mut','123Ma')

insert into tKullanicilar(KullaniciAdi,Sifre)
values('H_lal','123Hi')
select * from tKullanicilar

CREATE TABLE tMusteriler
(
  ID int identity(1,1) primary key,
  MusteriAdi varchar(150) not null,
  Ceptel char(10) unique not null
);
 insert into tMusteriler(MusteriAdi,Ceptel)
 values ('Ahmet Hamdi',5345634)

 insert into tMusteriler(MusteriAdi,Ceptel)
 values ('Hakan',5345631)

 insert into tMusteriler(MusteriAdi,Ceptel)
 values ('Melih',5345630)

 insert into tMusteriler(MusteriAdi,Ceptel)
 values ('Hilal',5345635)

 insert into tMusteriler(MusteriAdi,Ceptel)
 values ('Alperen',5345632)

 select * from tMusteriler


CREATE TABLE tTedarikciler
(
    ID int identity(1,1) primary key,
    TedarikciAdi varchar(150)
);

insert into tTedarikciler(TedarikciAdi)
VALUES ('Tedarikci1')

insert into tTedarikciler(TedarikciAdi)
VALUES ('Tedarikci2')

insert into tTedarikciler(TedarikciAdi)
VALUES ('Tedarikci3')

insert into tTedarikciler(TedarikciAdi)
VALUES ('Tedarikci4')

insert into tTedarikciler(TedarikciAdi)
VALUES ('Tedarikci5')

select * from tTedarikciler


CREATE TABLE tUrunler
(
    ID int identity(1,1) primary key,
    UrunAdi varchar(150) unique not null,
    BirimFiyat float not null,
    StokMiktarý float default 0,
    Kategoriler_tKategorilerID int NOT NULL,
    constraint iliski_tKategoriler_tUrunler foreign key (Kategoriler_tKategorilerID) references tKategoriler(ID),
    Tedarikciler_tTedarikcilerID int NOT NULL,
    constraint iliski_tUrunler_tTedarikciler foreign key (Tedarikciler_tTedarikcilerID) references tTedarikciler(ID)
);
select * from tTedarikciler
select * from tKategoriler
insert into tUrunler(UrunAdi,BirimFiyat,StokMiktarý,Kategoriler_tKategorilerID,Tedarikciler_tTedarikcilerID)
VALUES ('Mavi Kot',300,5,2,1)
insert into tUrunler(UrunAdi,BirimFiyat,StokMiktarý,Kategoriler_tKategorilerID,Tedarikciler_tTedarikcilerID)
VALUES ('V tisört',100,4,1,2)
insert into tUrunler(UrunAdi,BirimFiyat,StokMiktarý,Kategoriler_tKategorilerID,Tedarikciler_tTedarikcilerID)
VALUES ('Kýrmýzý Elbise',200,9,3,3)
insert into tUrunler(UrunAdi,BirimFiyat,StokMiktarý,Kategoriler_tKategorilerID,Tedarikciler_tTedarikcilerID)
VALUES ('Bot',400,10,5,3)
insert into tUrunler(UrunAdi,BirimFiyat,StokMiktarý,Kategoriler_tKategorilerID,Tedarikciler_tTedarikcilerID)
VALUES ('Deri Ceket',50,5,4,5)

select * from tUrunler

CREATE TABLE tSatislar
(
    ID int identity(1,1) primary key,
    SatisTarihi date default getdate(),
    ToplamTutar float not null,-- Gerçekleþen satýþýn tutarý
    Adet int not null,
	Urunler_tUrunlerID int not null,
    constraint iliski_tUrunler_tSatislar foreign key (Urunler_tUrunlerID) references tUrunler(ID),
    Musteriler_tMusterilerID int not null,
    constraint iliski_tMusteriler_tSatislar foreign key (Musteriler_tMusterilerID) references tMusteriler(ID)
);
set language turkish
select * from tSatislar
Alter table tSatislar
Add Adet int
delete from tSatislar




SELECT * FROM tUrunler
select * from tMusteriler

insert into tSatislar(SatisTarihi,Adet,Urunler_tUrunlerID,Musteriler_tMusterilerID,ToplamTutar)
values('2022-03-03',2,2,1,400)
insert into tSatislar(Adet,Urunler_tUrunlerID,Musteriler_tMusterilerID,ToplamTutar)
values(3,1,2,300)
insert into tSatislar(SatisTarihi,Adet,Urunler_tUrunlerID,Musteriler_tMusterilerID,ToplamTutar)
values('2022-03-03',1,3,3,400)
insert into tSatislar(SatisTarihi,Adet,Urunler_tUrunlerID,Musteriler_tMusterilerID,ToplamTutar)
values('2022-05-05',2,4,5,100)
insert into tSatislar(SatisTarihi,Adet,Urunler_tUrunlerID,Musteriler_tMusterilerID,ToplamTutar)
values('2024-12-25',5,5,4,1500)




select * from tSatislar

CREATE TABLE tSiparisler
(
    ID int identity(1,1) primary key,
    SiparisTarih date default getdate(),
    ToplamTutar float not null,-- Bu sadece sipariþ edilen ürünlerin tahmini toplam tutarýdýr.Henüz gerçekleþmemiþ
    Musteriler_tMusterilerID int not null,
    constraint iliski_tMusteriler_tSiparisler foreign key (Musteriler_tMusterilerID) references tMusteriler(ID)
);
select * from tMusteriler
SELECT * FROM tUrunler
insert into tSiparisler(SiparisTarih,ToplamTutar,Musteriler_tMusterilerID)
VALUES ('2021.02.01',500,1)
insert into tSiparisler(SiparisTarih,ToplamTutar,Musteriler_tMusterilerID)
VALUES ('2021.01.11',500,2)
insert into tSiparisler(ToplamTutar,Musteriler_tMusterilerID)
VALUES (250,3)
insert into tSiparisler(SiparisTarih,ToplamTutar,Musteriler_tMusterilerID)
VALUES ('2021.04.01',400,4)
insert into tSiparisler(SiparisTarih,ToplamTutar,Musteriler_tMusterilerID)
VALUES ('2021.06.01',1500,4)
insert into tSiparisler(SiparisTarih,ToplamTutar,Musteriler_tMusterilerID)
VALUES ('2021.06.01',1500,4)

SELECT * FROM tSiparisler

CREATE TABLE tAlisveGiderler
(
    ID int identity(1,1) primary key,
    AlisTarihi date default getdate(),
    ToplamMiktar float not null,
    ToplamFiyat float not null,
    GiderKategorisi_tGiderKategorileriID int not null,  -- Gider kategorisi
    constraint iliski_tGiderKategorileri_tAlislarVeGiderler foreign key (GiderKategorisi_tGiderKategorileriID) references tGiderKategorileri(ID),
    Urunler_tUrunlerID int not null,
    constraint iliski_tUrunler_tAlislar foreign key (Urunler_tUrunlerID) references tUrunler(ID),
    Tedarikciler_tTedarikcilerID int not null,
    constraint iliski_tAlislar_tTedarikciler foreign key (Tedarikciler_tTedarikcilerID) references tTedarikciler(ID)
);
ALTER TABLE tAlislar
ADD GiderKategori_tGiderKategorileriID int
    CONSTRAINT FK_Alis_GiderKategori FOREIGN KEY (GiderKategori_tGiderKategorileriID) REFERENCES tGiderKategorileri(ID);
EXEC sp_rename 'tAlislar', 'tAlisveGiderler';
select * from tAlisveGiderler
SELECT * FROM tUrunler
insert into tAlisveGiderler(ToplamMiktar,ToplamFiyat,Urunler_tUrunlerID,Tedarikciler_tTedarikcilerID,GiderKategorisi_tGiderKategorileriID)
VALUES (10,1000,1,2,'ÜRün alýmý')
insert into tAlisveGiderler(ToplamMiktar,ToplamFiyat,Urunler_tUrunlerID,Tedarikciler_tTedarikcilerID,GiderKategorisi_tGiderKategorileriID)
VALUES (5,1000,2,3,'ÜRün alýmý')
insert into tAlisveGiderler(ToplamMiktar,ToplamFiyat,Urunler_tUrunlerID,Tedarikciler_tTedarikcilerID,GiderKategorisi_tGiderKategorileriID)
VALUES (2,800,3,3,'ÜRün alýmý')
insert into tAlisveGiderler(ToplamMiktar,ToplamFiyat,Urunler_tUrunlerID,Tedarikciler_tTedarikcilerID,GiderKategorisi_tGiderKategorileriID)
VALUES (6,300,4,5,'ÜRün alýmý')
insert into tAlisveGiderler(ToplamMiktar,ToplamFiyat,Urunler_tUrunlerID,Tedarikciler_tTedarikcilerID,GiderKategorisi_tGiderKategorileriID)
VALUES (5,1500,5,1,'ÜRün alýmý')
delete from tAlisveGiderler
SELECT * FROM tAlislar

-- Gider kategorisi tablosu oluþturuluyor
CREATE TABLE tGiderKategorileri
(
    ID int identity(1,1) primary key,
    GiderKategoriAdi varchar(150) not null
);

-- Kategorileri ekleyelim
insert into tGiderKategorileri(GiderKategoriAdi) 
values ('Ürün Alýmý'), ('Ýþletme Giderleri'), ('Depo Giderleri');
select * from tGiderKategorileri


select * from tSatislar

SET language turkish
create view v_GunlukSatýs
AS
Select Sum(S.ToplamTutar) as 'Günlük Satýlan Toplam Tutar',U.UrunAdi as 'Satýlan Urun Adi'from tSatislar AS s
LEFT join tUrunler AS U
on S.Urunler_tUrunlerID = U.ID
where DATEDIFF(DAY,S.SatisTarihi,GETDATE()) = 1
group by U.UrunAdi

select * from tGiderler
select * from v_GunlukSatýs

--En az satýlan urun

select * from tSatislar

--Aylýk 5000 TL’den fazla olan giderlerin listesini veren view:


create view v_Gider
AS
select SUM(G.GiderTutar), MONTH(g.GiderTarihi)from tGiderler AS G
group by MONTH(g.GiderTarihi)
having sum(g.GiderTutar) > 5000


/*?4. Stokta Bitmek Üzere Olan Ürünler
Mevcut stok miktarlarý 5’ten az olan ürünlerin listesini veren view:*/
SELECT * FROM tUrunler
select * fROM tAlislar
select U.UrunAdi,U.StokMiktarý from tUrunler as U
WHERE U.StokMiktarý < 5


--Bu view, her müþteri için yaptýðý satýþlarýn toplam tutarýný, ürünün kaç kez satýn aldýðý ürünleri ve ürünlerin kategorilerini gösterir.

select * from tSatislar
select * from tKategoriler
select * from tUrunler
create view v_MusteriUrun
AS
select M.MusteriAdi,U.UrunAdi,K.KategoriAdi,Sum(S.ToplamTutar) as 'Toplam Tutar',SUM(S.Adet) as 'Alýnan Adet Sayisi',Count(UrunAdi) as ' SatisKayitSayisi' from tSatislar as S
left join tUrunler AS U
on S.Urunler_tUrunlerID = U.ID
left join tKategoriler as K
on k.ID = U.Kategoriler_tKategorilerID
left join tMusteriler AS M
on M.ID = S.Musteriler_tMusterilerID
group by M.MusteriAdi,U.UrunAdi,K.KategoriAdi

--Kategori Bazlý Satýþ Analizi 
select * from tKategoriler
select * from tUrunler
select * from tSatislar
Create view v_KategoriBazlýSatýs 
as
select k.KategoriAdi,count(*) as 'Kategori için Satýþ sayýsý',SUM(S.ToplamTutar) AS 'ELDE EDÝLEN GELÝR KATEGORÝLERDEN',AVG(S.ToplamTutar) AS 'HANGÝ KATEGORÝNÝN ORTALAMA SATIÞ TUTARI DAHA YÜKSEK' from tKategoriler AS k
left join tUrunler AS u
ON K.ID = u.Kategoriler_tKategorilerID
left join tSatislar AS S
on S.Urunler_tUrunlerID = U.ID
GROUP BY K.KategoriAdi

select * from v_KategoriBazlýSatýs
order by [ELDE EDÝLEN GELÝR KATEGORÝLERDEN] DESC

drop view v_KategoriBazlýSatýs

--9. Oluþturmuþ olduðunuz veritabanýnda esnafýn ortalama aylýk karlarýný belirleyin. Bu deðerin
--altýndaki aylara ait satýþlarý nasýl listeleyeceðini gösteren sorguyu yazýnýz.
--10. Oluþturmuþ olduðunuz veritabanýnda esnafýn zarar ettiði ürünleri nasýl listeleyeceðini gösteren
--sorguyu yazýnýz.
--11. Oluþturmuþ olduðunuz veritabanýnda esnafýn en çok hangi ürünü sattýðýný listeleyeceðini
--gösteren sorguyu yazýnýz.
SELECT * FROM tAlislar
select * from tGiderler
SELECT * FROM tSatislar

select * from tAlisveGiderler


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


--SORU
--Dersi alan öðrenciler için vizesi 50 üstü olanlara 5 puan ve finali 60 üstü olanlara ise 6 puan ekleyecek sorguyu oluþturun
select * from tDersiAlanOgrenciler
update tDersiAlanOgrenciler
set 
Vize = Vize + 5 , Final = Final +6
where vize > 50 and final > 60



--SORU
--kiþinin adýnýn baþýnda ya da sonunda boþluk olanlar ile adý 3 karakterden az olan kiþileri tablodan listeleyen kodu oluþturun

select k.Adi,k.Soyadi
from tKullanicilar as k
where (k.Adi like ' %' or k.Adi like '% ') and (len(k.Adi) < 3) 

--SORU
--Dersi alan öðrenciler için Vizenin %40ý ve Finalin %60ý alýnarak hesaplanan geçme notu 70 üstü olan kiþilerin geçme notlarýný virgülden sonra iki basamak olacak þekilde listeleyin.
select 
Round((k.Vize*0.4+k.Final*0.6),2 ) as 'Virgülden sonraki iki basamak olacak sekilde gecme notu'
from tDersiAlanOgrenciler as k
where k.Vize*0.4+k.Final*0.6 > 70 

--SORU
--Yaz okulunda vizesi ile finali arasýnda 50 puanadn fazla fark olan kaç öðrenci vardýr
select * from tYazOkuluUcretleri;

Select
count(*) as 'Fark Olan Ogrenci Sayýsý'
from tYazOkuluUcretleri AS y
where (y.Vize - y.Final) > 50


--SORU
--Ýki ad sahibi kiþilerden en uzun ada sahip kiþi kimdir?
select
k.Adi
from tKullanicilar as k
where k.Adi like '% %'
order by len(k.Adi) desc

--SORU
--Kullanýcýlardan Cinsiyet deðeri 1 olup DogumYeri_tlLcelerID deðeri 58 olan kiþilerin aþaðýdaki þelilde listelenmesini saðlayýnýz. 
--Kiþi Adý   Kiþi Soyadý
SELECT * FROM tKullanicilar
select Adi as 'Kisi Adi' , Soyadi  as 'Kisi Soyadi'
from tKullanicilar
WHERE Cinsiyet = 1 and DogumYeri_tIlcelerID = 58

--SORU
--Yukarýdaki tablo için vize ortalamasý ile final ortalamasý arasýndaki farký hesaplayýn.
select avg(Vize) - avg(Final) as 'Vize final farký' from tDersNotlari


--SORU
--Kullanýcýlarýn adlarýný baþ harflerine göre analiz etmek istiyoruz. Her bir baþ harfe göre kaç kullanýcý var listeleyiniz

select
Count(*) as 'Sayisi',SUBSTRING(k.Adi,1,1) as 'Bas Harfleri'
from tKullanicilar as k
where SUBSTRING(k.Adi,1,1) between 'A' and 'Z'
group by SUBSTRING(k.Adi,1,1) 
order by Count(*) desc

--SORU
--Her bir ilin kaç tane ilçesi oldugunu gösteren sorgu
select * from tIlceler
select * from tIller
select
count(*) as 'Her bir ilin Ýlçe Sayýsý', Il_tIllerID
from tIlceler I
group by Il_tIllerID

--SORU
--En çok ilçesi olan ilID deðeri kaçtýr?
select
count(*) as 'Her bir ilin Ýlçe Sayýsý',Il_tIllerID
from tIlceler
GROUP BY Il_tIllerID
order by count(*) desc 

--SORU
--Kullanýcýlardan adlarýný ve soyadlarýný aþaðýdaki örnekte olduðu gibi adýnýn ilk harfi büyük ve soyadýnýn ilk harfi büyük olacak þekilde yan yana yazýlmasýný saðlayýn Örn) Emrah Aydemir
select
k.Adi +  ' ' + K.Soyadi
from tKullanicilar AS k
Where  LEFT(k.Adi, 1) LIKE '[A-Z]'
  AND LEFT(k.Soyadi, 1) LIKE '[A-Z]'

--SORU
--En Fazla öðrencisi olan bölüm hangisidir?
select * from tYazOkuluUcretleri
select
y.Bolum_tBolumlerID,Count(*) as 'Bolum Sayýsý'
from tYazOkuluUcretleri AS Y
GROUP BY Y.Bolum_tBolumlerID
order by count(*) desc


--SORU
--Yaz okulunda 500TL üzeri ödeme yapan öðrencilerin yer aldýðý bölümlerin öðrencilerden aldýðý ücreti toplamda 2000tl üst olan bölümleri listeleyin
Select Bolum_tBolumlerID, sum(Ucret) as 'Toplam Ücret'
from tYazOkuluUcretleri
where Ucret>500 
group by Bolum_tBolumlerID
having sum(Ucret)>2000


--SORU
--Kullanýcýlardan adý a ile baþlayýp a ile biten ya da b ile baþlayýp b ile biten kayýtlarý listeleyen kodu yazýnýz

select
*
from tKullanicilar as k
where (k.Adi like 'a%a') or (k.Adi like 'b%b')


-- SORU
--Kullanýcýlardan adý a ya da b içermeyen fakat adý c ya da d içeren kayýtlarý listeleyen kodu yazýnýz .
--DÝKKAT AND 
Select
*
from tKullanicilar as k
where (k.Adi not like '%a%' and k.Adi not like '%b%') and (k.Adi like '%c%' or k.Adi like '%d%' ) 

--Soru 
--Kullanýcýlardan 20 yaþýnda olan kiþileri yaþlarý büyükten küçüðe doðru listeleyen kodu yazýnýz.
select
* from tKullanicilar as k
where datediff(Year,k.DogumTarihi,getdate()) = 20
order by datediff(Year,k.DogumTarihi,getdate()) desc
--Soru 
-- Kullanýcýlardan cinsiyeti 0 olmayan ve adýnda  a geçmeyen kiþilerin kaç farklý doðum tarihi vardýr ?
select distinct
k.DogumTarihi,K.Adi
from tKullanicilar AS k
where cinsiyet != 0 and k.Adi not like '%a%'

--SORU
--25 den fazla öðrenisi olan bölümler 
select * from tYazOkuluUcretleri
select 
y.Bolum_tBolumlerID, count(*) as 'Ogrenci Sayýsý'
from tOgrenciler AS y
group by y.Bolum_tBolumlerID
having count(*) > 25
order by count(*) asc
-- olusan listelemede group by dan sonra kullanýlýr

--SORU
--tKullanýcýlar adlý tablodaki kiþilerin tam yaþýný ay cinsinden hesaplayýnýz. Kiþi yaþlarý ondalýklý deðerler içerecektir.
select 
cast(datediff(Month,k.DogumTarihi,GETDATE()) as float)/12 as 'Kisi Yaslari'  from tKullanicilar as k -- floata bölersek sonuç float gelir.


 --Kullanýcýlar tablosundan kan grubu '0 Rh (+)' olan kiþilerin idlerini 
--dogum tarihinin yýlýna böl bunu virgülden sonra 2 basamaklý olacak þekilde yazdýr ve
--büyükten küçüðe doðru olacak þekilde sýrala
select * from tKullanicilar
select* from tKanGruplari;
set language turkish
SELECT 
    k.Adi,
    k.Soyadi,
    ROUND(CAST(YEAR(k.DogumTarihi) AS FLOAT) / 7, 2) as 'Virgülden sonraki iki basamak'
FROM tKullanicilar as k
WHERE k.KanGrubu_tKanGruplariID = 7 
ORDER BY ROUND(CAST(YEAR(k.DogumTarihi) AS FLOAT) / 7, 2) DESC


select
K.Adi+ '  ve  ' +K.Soyadi+ '  ismindeki toplam karakter sayýsý  ' + cast(len(K.Adi) + len(K.Soyadi) as varchar)+ ' dur. ' AS 'Toplam_Karakter_Sayýsý' from tKullanicilar as K 

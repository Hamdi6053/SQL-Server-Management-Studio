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


--SORU
--Dersi alan ��renciler i�in vizesi 50 �st� olanlara 5 puan ve finali 60 �st� olanlara ise 6 puan ekleyecek sorguyu olu�turun
select * from tDersiAlanOgrenciler
update tDersiAlanOgrenciler
set 
Vize = Vize + 5 , Final = Final +6
where vize > 50 and final > 60



--SORU
--ki�inin ad�n�n ba��nda ya da sonunda bo�luk olanlar ile ad� 3 karakterden az olan ki�ileri tablodan listeleyen kodu olu�turun

select k.Adi,k.Soyadi
from tKullanicilar as k
where (k.Adi like ' %' or k.Adi like '% ') and (len(k.Adi) < 3) 

--SORU
--Dersi alan ��renciler i�in Vizenin %40� ve Finalin %60� al�narak hesaplanan ge�me notu 70 �st� olan ki�ilerin ge�me notlar�n� virg�lden sonra iki basamak olacak �ekilde listeleyin.
select 
Round((k.Vize*0.4+k.Final*0.6),2 ) as 'Virg�lden sonraki iki basamak olacak sekilde gecme notu'
from tDersiAlanOgrenciler as k
where k.Vize*0.4+k.Final*0.6 > 70 

--SORU
--Yaz okulunda vizesi ile finali aras�nda 50 puanadn fazla fark olan ka� ��renci vard�r
select * from tYazOkuluUcretleri;

Select
count(*) as 'Fark Olan Ogrenci Say�s�'
from tYazOkuluUcretleri AS y
where (y.Vize - y.Final) > 50


--SORU
--�ki ad sahibi ki�ilerden en uzun ada sahip ki�i kimdir?
select
k.Adi
from tKullanicilar as k
where k.Adi like '% %'
order by len(k.Adi) desc

--SORU
--Kullan�c�lardan Cinsiyet de�eri 1 olup DogumYeri_tlLcelerID de�eri 58 olan ki�ilerin a�a��daki �elilde listelenmesini sa�lay�n�z. 
--Ki�i Ad�   Ki�i Soyad�
SELECT * FROM tKullanicilar
select Adi as 'Kisi Adi' , Soyadi  as 'Kisi Soyadi'
from tKullanicilar
WHERE Cinsiyet = 1 and DogumYeri_tIlcelerID = 58

--SORU
--Yukar�daki tablo i�in vize ortalamas� ile final ortalamas� aras�ndaki fark� hesaplay�n.
select avg(Vize) - avg(Final) as 'Vize final fark�' from tDersNotlari


--SORU
--Kullan�c�lar�n adlar�n� ba� harflerine g�re analiz etmek istiyoruz. Her bir ba� harfe g�re ka� kullan�c� var listeleyiniz

select
Count(*) as 'Sayisi',SUBSTRING(k.Adi,1,1) as 'Bas Harfleri'
from tKullanicilar as k
where SUBSTRING(k.Adi,1,1) between 'A' and 'Z'
group by SUBSTRING(k.Adi,1,1) 
order by Count(*) desc

--SORU
--Her bir ilin ka� tane il�esi oldugunu g�steren sorgu
select * from tIlceler
select * from tIller
select
count(*) as 'Her bir ilin �l�e Say�s�', Il_tIllerID
from tIlceler I
group by Il_tIllerID

--SORU
--En �ok il�esi olan ilID de�eri ka�t�r?
select
count(*) as 'Her bir ilin �l�e Say�s�',Il_tIllerID
from tIlceler
GROUP BY Il_tIllerID
order by count(*) desc 

--SORU
--Kullan�c�lardan adlar�n� ve soyadlar�n� a�a��daki �rnekte oldu�u gibi ad�n�n ilk harfi b�y�k ve soyad�n�n ilk harfi b�y�k olacak �ekilde yan yana yaz�lmas�n� sa�lay�n �rn) Emrah Aydemir
select
k.Adi +  ' ' + K.Soyadi
from tKullanicilar AS k
Where  LEFT(k.Adi, 1) LIKE '[A-Z]'
  AND LEFT(k.Soyadi, 1) LIKE '[A-Z]'

--SORU
--En Fazla ��rencisi olan b�l�m hangisidir?
select * from tYazOkuluUcretleri
select
y.Bolum_tBolumlerID,Count(*) as 'Bolum Say�s�'
from tYazOkuluUcretleri AS Y
GROUP BY Y.Bolum_tBolumlerID
order by count(*) desc


--SORU
--Yaz okulunda 500TL �zeri �deme yapan ��rencilerin yer ald��� b�l�mlerin ��rencilerden ald��� �creti toplamda 2000tl �st olan b�l�mleri listeleyin
Select Bolum_tBolumlerID, sum(Ucret) as 'Toplam �cret'
from tYazOkuluUcretleri
where Ucret>500 
group by Bolum_tBolumlerID
having sum(Ucret)>2000


--SORU
--Kullan�c�lardan ad� a ile ba�lay�p a ile biten ya da b ile ba�lay�p b ile biten kay�tlar� listeleyen kodu yaz�n�z

select
*
from tKullanicilar as k
where (k.Adi like 'a%a') or (k.Adi like 'b%b')


-- SORU
--Kullan�c�lardan ad� a ya da b i�ermeyen fakat ad� c ya da d i�eren kay�tlar� listeleyen kodu yaz�n�z .
--D�KKAT AND 
Select
*
from tKullanicilar as k
where (k.Adi not like '%a%' and k.Adi not like '%b%') and (k.Adi like '%c%' or k.Adi like '%d%' ) 

--Soru 
--Kullan�c�lardan 20 ya��nda olan ki�ileri ya�lar� b�y�kten k����e do�ru listeleyen kodu yaz�n�z.
select
* from tKullanicilar as k
where datediff(Year,k.DogumTarihi,getdate()) = 20
order by datediff(Year,k.DogumTarihi,getdate()) desc
--Soru 
-- Kullan�c�lardan cinsiyeti 0 olmayan ve ad�nda  a ge�meyen ki�ilerin ka� farkl� do�um tarihi vard�r ?
select distinct
k.DogumTarihi,K.Adi
from tKullanicilar AS k
where cinsiyet != 0 and k.Adi not like '%a%'

--SORU
--25 den fazla ��renisi olan b�l�mler 
select * from tYazOkuluUcretleri
select 
y.Bolum_tBolumlerID, count(*) as 'Ogrenci Say�s�'
from tOgrenciler AS y
group by y.Bolum_tBolumlerID
having count(*) > 25
order by count(*) asc
-- olusan listelemede group by dan sonra kullan�l�r

--SORU
--tKullan�c�lar adl� tablodaki ki�ilerin tam ya��n� ay cinsinden hesaplay�n�z. Ki�i ya�lar� ondal�kl� de�erler i�erecektir.
select 
cast(datediff(Month,k.DogumTarihi,GETDATE()) as float)/12 as 'Kisi Yaslari'  from tKullanicilar as k -- floata b�lersek sonu� float gelir.


 --Kullan�c�lar tablosundan kan grubu '0 Rh (+)' olan ki�ilerin idlerini 
--dogum tarihinin y�l�na b�l bunu virg�lden sonra 2 basamakl� olacak �ekilde yazd�r ve
--b�y�kten k����e do�ru olacak��ekilde�s�rala
select * from tKullanicilar
select* from tKanGruplari;
set language turkish
SELECT 
    k.Adi,
    k.Soyadi,
    ROUND(CAST(YEAR(k.DogumTarihi) AS FLOAT) / 7, 2) as 'Virg�lden sonraki iki basamak'
FROM tKullanicilar as k
WHERE k.KanGrubu_tKanGruplariID = 7 
ORDER BY ROUND(CAST(YEAR(k.DogumTarihi) AS FLOAT) / 7, 2) DESC


select
K.Adi+ '  ve  ' +K.Soyadi+ '  ismindeki toplam karakter say�s�  ' + cast(len(K.Adi) + len(K.Soyadi) as varchar)+ ' dur. ' AS 'Toplam_Karakter_Say�s�' from tKullanicilar as K 

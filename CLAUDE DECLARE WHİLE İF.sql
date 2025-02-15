
/*Ortalamanýn altýnda yaz okulu vizesine sahip kiþilere ortalamanýn %10'u kadar puan eklenmesi yapan kodu yazýnýz.*/
SELECT * FROM tYazOkuluUcretleri
DECLARE @VizeOrtalama float
select @VizeOrtalama =  AVG(You.Vize) from tYazOkuluUcretleri as YOU
update tYazOkuluUcretleri
SET
Vize = Vize + @VizeOrtalama*0.1
where  Vize<@VizeOrtalama 


--Kan grubu A+ olan öðrencilerin bölüm adlarýný ve öðrenci numaralarýný listeleyin
SELECT * FROM tKanGruplari
select * from tOgrenciler
SELECT * FROM tKanGruplari
select * from tBolumler


select O.OgrenciNo as 'Öðrenci Numarasý',KG.Adi as 'Kan Grubu Adlari',B.Adi as 'Bölüm Adlari' from tKullanicilar AS k
left join tKanGruplari AS kg
on kg.ID = k.KanGrubu_tKanGruplariID
left join tOgrenciler as O
on o.Ogrenci_tKullanicilarID = k.ID
left join tBolumler AS B
ON B.ID = O.Bolum_tBolumlerID
WHERE K.KanGrubu_tKanGruplariID = 1

--Her fakültede kaç öðrenci olduðunu bulan bir sorgu yazýn. Sonuçlar fakülte adýna göre sýralý olmalý.

select * from tFakulteler
select *from tBolumler
SELECT * FROM tOgrenciler


select F.Adi AS 'FAKÜLTE ADÝ',COUNT(*) AS 'ÖÐRENCÝ SAYÝSÝ'from tFakulteler AS F
left join tBolumler AS B
on F.ID = B.Fakulte_tFakultelerID
left join tOgrenciler as O
on o.Bolum_tBolumlerID = B.ID
GROUP BY F.Adi
ORDER BY F.Adi ASC

--Öðrencilerin doðum yerlerine göre daðýlýmýný (hangi þehirden kaç öðrenci var) listeleyin.
select * from tKullanicilar
SELECT * FROM tIller
SELECT * FROM tIlceler
SELECT * FROM tOgrenciler

SELECT 
    II.Adi as 'Ýl',
    IL.Adi as 'Ýlçe',
    COUNT(O.ID) as 'Öðrenci Sayýsý'
FROM tKullanicilar AS K
LEFT JOIN tOgrenciler as O ON K.ID = O.Ogrenci_tKullanicilarID
LEFT JOIN tIlceler as IL ON IL.ID = K.DogumYeri_tIlcelerID
LEFT JOIN tIller AS II ON II.ID = IL.Il_tIllerID
WHERE O.ID IS NOT NULL  -- Sadece öðrencileri getir
GROUP BY II.Adi, IL.Adi
ORDER BY II.Adi, IL.Adi

/*Yaz okulunda ücret ödeyen öðrencilerin her birinin toplam ödenen ücretin 
yüzde kaçý kadar ödeme yaptýðýný kayýtID ,kayýt tarihi ve yüzde oraný olacak þekilde listeleyin
*/
DECLARE @TOPLAM float  -- Toplam ücreti tutacak deðiþken

-- Önce toplam ücreti hesapla
SELECT @TOPLAM = SUM(Ucret) FROM tYazOkuluUcretleri

-- Sonra her kayýt için yüzde hesapla
SELECT 
    ID as 'Kayýt ID',
    IslemTarihi as 'Kayýt Tarihi',
    (Ucret * 100.0 / @TOPLAM) as 'Yüzde Oraný'
FROM tYazOkuluUcretleri

/*CASE yapýsýný kullanarak:

Final notu 0-49 arasý olanlar için "Baþarýsýz"
50-69 arasý olanlar için "Orta"
70-84 arasý olanlar için "Ýyi"
85-100 arasý olanlar için "Çok Ýyi"
yazan bir sorgu yazýn.*/
/*Öðrenci numarasý
Öðrencinin adý soyadý
Dersin adý
Final notu
Baþarý durumu deðerlendirmesi
Öðrencinin bölümü*/

select * from tDersiAlanOgrenciler AS D

SELECT 
   O.OgrenciNo as 'Öðrenci Numarasý',
   (K.Adi + ' ' + K.Soyadi) as 'Öðrenci Adi ve Soyadi',
   Ds.Adi as 'Ders Adi',
   D.Final as 'Final Notu',
   B.ADÝ AS 'Bölüm Adi',
   CASE 
       WHEN D.Final BETWEEN 0 AND 49 THEN 'Baþarýsýz'
       WHEN D.Final BETWEEN 50 AND 69 THEN 'Orta'
       WHEN D.Final BETWEEN 70 AND 84 THEN 'Ýyi'
       WHEN D.Final BETWEEN 85 AND 100 THEN 'Çok iyi'
       ELSE 'Deðerlendirme Dýþý'
   END as 'Deðerlendirme Sonucu'
FROM tKullanicilar AS K
LEFT JOIN tOgrenciler AS O 
   ON k.ID = O.Ogrenci_tKullanicilarID
LEFT JOIN tBolumler as B 
   ON B.ID = O.Bolum_tBolumlerID
LEFT JOIN tDersiAlanOgrenciler as D 
   ON D.Ogrenci_tOgrencilerID = O.ID
LEFT JOIN tDersler as Ds 
   ON Ds.ID = D.Ders_tDerslerID
Where d.Final is not null
order by B.Adi DESC,d.Final DESC

--While döngüsü kullanarak tDersler tablosuna 5 adet örnek ders kaydý ekleyin.
DECLARE @SAYAC int
set @sayac = 1

while @sayac < 5
     BEGIN
	     
		 set @SAYAC += 1
		 insert into tDersler(Adi)
		 values ('Kimya')

	END 
		 

/*Öðrencinin vize ve final notlarýna göre durum deðerlendirmesi yapan bir sorgu yazýn:
Vize notu 50'den küçükse "Vize notu yetersiz"
Final notu 50'den küçükse "Final notu yetersiz"
Ortalama (vize0.4 + final0.6) 60'dan küçükse "Dersten kaldý"
Diðer durumda "Dersten geçti" yazdýrýn*/
set language turkish
select D.Vize as 'Öðrenci Vize Notu',D.Final  as 'Öðrenci Final Notu', 
(D.Vize * 0.4 + D.Final * 0.6) as 'Öðrenci Genel Ortalama',
O.OgrenciNo AS 'Öðrenci Numarasý',
     CASE
	    WHEN D.Vize < 50 THEN 'Vize Notu Yetersiz.'
		WHEN D.Final < 50 THEN 'Final Notu Yetersiz.'
		WHEN (D.Vize * 0.4 + D.Final * 0.6) < 60 THEN 'Dersten Kaldý.'
		ELSE 'Dersten Geçti.'
	  END AS 'Deðerlendirme Sonucu'
from tDersiAlanOgrenciler  as D 
left join tOgrenciler AS O
on D.Ogrenci_tOgrencilerID = O.ID


--While döngüsü kullanarak 1'den 10'a kadar olan sayýlarýn faktöriyelini hesaplayan bir sorgu yazýn.
DECLARE @sayac int = 1           -- Dýþ döngü sayacý (1'den 10'a)
DECLARE @faktoriyel bigint       -- Faktöriyel sonucu
DECLARE @temp int                -- Ýç döngü sayacý

WHILE @sayac <= 10
BEGIN
    SET @faktoriyel = 1
    SET @temp = @sayac
    
    WHILE @temp > 0
    BEGIN
        SET @faktoriyel = @faktoriyel * @temp
        SET @temp = @temp - 1
    END
    
    PRINT CAST(@sayac as varchar(2)) + '! = ' + CAST(@faktoriyel as varchar(20))
    SET @sayac = @sayac + 1
END

/*Bir öðrencinin aldýðý derslerin AKTS toplamýný hesaplayan ve:
AKTS toplamý 30'dan az ise "Ders yükü yetersiz"
AKTS toplamý 30-40 arasýnda ise "Normal ders yükü"
AKTS toplamý 40'tan fazla ise "Yüksek ders yükü"
mesajýný veren sorguyu yazýn.*/
 
select * from tDersiAlanOgrenciler
WHERE Ders_tDerslerID = 232
select * from tOgrenciler
select * from tDersler

select D.Ogrenci_tOgrencilerID, SUM(Ds.AKTS) as 'Öðrenci AKTS Toplamý',
      CASE 
	     WHEN SUM(ds.AKTS) < 30 then 'Ders yükü yetersiz'
		 WHEN SUM(ds.AKTS) BETWEEN 30 AND 40  then 'Normal ders yükü'
		 WHEN SUM(ds.AKTS) > 40 then 'Yüksek ders yükü'
		 ELSE 'DEÐERLENDÝRME DIÞI'
END as 'Deðerlendirme Sonucu'	
from tDersiAlanOgrenciler AS D
left join tDersler AS Ds
on Ds.ID = D.Ders_tDerslerID
left join tOgrenciler AS O
on d.Ogrenci_tOgrencilerID = O.ID
group by D.Ogrenci_tOgrencilerID
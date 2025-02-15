
/*Ortalaman�n alt�nda yaz okulu vizesine sahip ki�ilere ortalaman�n %10'u kadar puan eklenmesi yapan kodu yaz�n�z.*/
SELECT * FROM tYazOkuluUcretleri
DECLARE @VizeOrtalama float
select @VizeOrtalama =  AVG(You.Vize) from tYazOkuluUcretleri as YOU
update tYazOkuluUcretleri
SET
Vize = Vize + @VizeOrtalama*0.1
where  Vize<@VizeOrtalama 


--Kan grubu A+ olan ��rencilerin b�l�m adlar�n� ve ��renci numaralar�n� listeleyin
SELECT * FROM tKanGruplari
select * from tOgrenciler
SELECT * FROM tKanGruplari
select * from tBolumler


select O.OgrenciNo as '��renci Numaras�',KG.Adi as 'Kan Grubu Adlari',B.Adi as 'B�l�m Adlari' from tKullanicilar AS k
left join tKanGruplari AS kg
on kg.ID = k.KanGrubu_tKanGruplariID
left join tOgrenciler as O
on o.Ogrenci_tKullanicilarID = k.ID
left join tBolumler AS B
ON B.ID = O.Bolum_tBolumlerID
WHERE K.KanGrubu_tKanGruplariID = 1

--Her fak�ltede ka� ��renci oldu�unu bulan bir sorgu yaz�n. Sonu�lar fak�lte ad�na g�re s�ral� olmal�.

select * from tFakulteler
select *from tBolumler
SELECT * FROM tOgrenciler


select F.Adi AS 'FAK�LTE AD�',COUNT(*) AS '��RENC� SAY�S�'from tFakulteler AS F
left join tBolumler AS B
on F.ID = B.Fakulte_tFakultelerID
left join tOgrenciler as O
on o.Bolum_tBolumlerID = B.ID
GROUP BY F.Adi
ORDER BY F.Adi ASC

--��rencilerin do�um yerlerine g�re da��l�m�n� (hangi �ehirden ka� ��renci var) listeleyin.
select * from tKullanicilar
SELECT * FROM tIller
SELECT * FROM tIlceler
SELECT * FROM tOgrenciler

SELECT 
    II.Adi as '�l',
    IL.Adi as '�l�e',
    COUNT(O.ID) as '��renci Say�s�'
FROM tKullanicilar AS K
LEFT JOIN tOgrenciler as O ON K.ID = O.Ogrenci_tKullanicilarID
LEFT JOIN tIlceler as IL ON IL.ID = K.DogumYeri_tIlcelerID
LEFT JOIN tIller AS II ON II.ID = IL.Il_tIllerID
WHERE O.ID IS NOT NULL  -- Sadece ��rencileri getir
GROUP BY II.Adi, IL.Adi
ORDER BY II.Adi, IL.Adi

/*Yaz okulunda �cret �deyen ��rencilerin her birinin toplam �denen �cretin 
y�zde ka�� kadar �deme yapt���n� kay�tID ,kay�t tarihi ve y�zde oran� olacak �ekilde listeleyin
*/
DECLARE @TOPLAM float  -- Toplam �creti tutacak de�i�ken

-- �nce toplam �creti hesapla
SELECT @TOPLAM = SUM(Ucret) FROM tYazOkuluUcretleri

-- Sonra her kay�t i�in y�zde hesapla
SELECT 
    ID as 'Kay�t ID',
    IslemTarihi as 'Kay�t Tarihi',
    (Ucret * 100.0 / @TOPLAM) as 'Y�zde Oran�'
FROM tYazOkuluUcretleri

/*CASE yap�s�n� kullanarak:

Final notu 0-49 aras� olanlar i�in "Ba�ar�s�z"
50-69 aras� olanlar i�in "Orta"
70-84 aras� olanlar i�in "�yi"
85-100 aras� olanlar i�in "�ok �yi"
yazan bir sorgu yaz�n.*/
/*��renci numaras�
��rencinin ad� soyad�
Dersin ad�
Final notu
Ba�ar� durumu de�erlendirmesi
��rencinin b�l�m�*/

select * from tDersiAlanOgrenciler AS D

SELECT 
   O.OgrenciNo as '��renci Numaras�',
   (K.Adi + ' ' + K.Soyadi) as '��renci Adi ve Soyadi',
   Ds.Adi as 'Ders Adi',
   D.Final as 'Final Notu',
   B.AD� AS 'B�l�m Adi',
   CASE 
       WHEN D.Final BETWEEN 0 AND 49 THEN 'Ba�ar�s�z'
       WHEN D.Final BETWEEN 50 AND 69 THEN 'Orta'
       WHEN D.Final BETWEEN 70 AND 84 THEN '�yi'
       WHEN D.Final BETWEEN 85 AND 100 THEN '�ok iyi'
       ELSE 'De�erlendirme D���'
   END as 'De�erlendirme Sonucu'
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

--While d�ng�s� kullanarak tDersler tablosuna 5 adet �rnek ders kayd� ekleyin.
DECLARE @SAYAC int
set @sayac = 1

while @sayac < 5
     BEGIN
	     
		 set @SAYAC += 1
		 insert into tDersler(Adi)
		 values ('Kimya')

	END 
		 

/*��rencinin vize ve final notlar�na g�re durum de�erlendirmesi yapan bir sorgu yaz�n:
Vize notu 50'den k���kse "Vize notu yetersiz"
Final notu 50'den k���kse "Final notu yetersiz"
Ortalama (vize0.4 + final0.6) 60'dan k���kse "Dersten kald�"
Di�er durumda "Dersten ge�ti" yazd�r�n*/
set language turkish
select D.Vize as '��renci Vize Notu',D.Final  as '��renci Final Notu', 
(D.Vize * 0.4 + D.Final * 0.6) as '��renci Genel Ortalama',
O.OgrenciNo AS '��renci Numaras�',
     CASE
	    WHEN D.Vize < 50 THEN 'Vize Notu Yetersiz.'
		WHEN D.Final < 50 THEN 'Final Notu Yetersiz.'
		WHEN (D.Vize * 0.4 + D.Final * 0.6) < 60 THEN 'Dersten Kald�.'
		ELSE 'Dersten Ge�ti.'
	  END AS 'De�erlendirme Sonucu'
from tDersiAlanOgrenciler  as D 
left join tOgrenciler AS O
on D.Ogrenci_tOgrencilerID = O.ID


--While d�ng�s� kullanarak 1'den 10'a kadar olan say�lar�n fakt�riyelini hesaplayan bir sorgu yaz�n.
DECLARE @sayac int = 1           -- D�� d�ng� sayac� (1'den 10'a)
DECLARE @faktoriyel bigint       -- Fakt�riyel sonucu
DECLARE @temp int                -- �� d�ng� sayac�

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

/*Bir ��rencinin ald��� derslerin AKTS toplam�n� hesaplayan ve:
AKTS toplam� 30'dan az ise "Ders y�k� yetersiz"
AKTS toplam� 30-40 aras�nda ise "Normal ders y�k�"
AKTS toplam� 40'tan fazla ise "Y�ksek ders y�k�"
mesaj�n� veren sorguyu yaz�n.*/
 
select * from tDersiAlanOgrenciler
WHERE Ders_tDerslerID = 232
select * from tOgrenciler
select * from tDersler

select D.Ogrenci_tOgrencilerID, SUM(Ds.AKTS) as '��renci AKTS Toplam�',
      CASE 
	     WHEN SUM(ds.AKTS) < 30 then 'Ders y�k� yetersiz'
		 WHEN SUM(ds.AKTS) BETWEEN 30 AND 40  then 'Normal ders y�k�'
		 WHEN SUM(ds.AKTS) > 40 then 'Y�ksek ders y�k�'
		 ELSE 'DE�ERLEND�RME DI�I'
END as 'De�erlendirme Sonucu'	
from tDersiAlanOgrenciler AS D
left join tDersler AS Ds
on Ds.ID = D.Ders_tDerslerID
left join tOgrenciler AS O
on d.Ogrenci_tOgrencilerID = O.ID
group by D.Ogrenci_tOgrencilerID